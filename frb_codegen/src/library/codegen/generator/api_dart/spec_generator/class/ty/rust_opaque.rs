use crate::codegen::generator::api_dart::spec_generator::class::method::{
    generate_api_methods, GenerateApiMethodConfig, GenerateApiMethodMode, GeneratedApiMethods,
};
use crate::codegen::generator::api_dart::spec_generator::class::misc::generate_class_extra_body;
use crate::codegen::generator::api_dart::spec_generator::class::ty::ApiDartGeneratorClassTrait;
use crate::codegen::generator::api_dart::spec_generator::class::ApiDartGeneratedClass;
use crate::codegen::generator::api_dart::spec_generator::misc::generate_imports_which_types_and_funcs_use;
use crate::codegen::ir::mir::trait_impl::MirTraitImpl;
use crate::codegen::ir::mir::ty::rust_opaque::MirTypeRustOpaque;
use crate::codegen::ir::mir::ty::MirType;
use crate::library::codegen::generator::api_dart::spec_generator::base::*;
use crate::library::codegen::generator::api_dart::spec_generator::info::ApiDartGeneratorInfoTrait;
use crate::library::codegen::ir::mir::ty::MirTypeTrait;
use crate::utils::basic_code::DartBasicHeaderCode;
use crate::utils::namespace::NamespacedName;
use itertools::Itertools;
use lazy_static::lazy_static;
use regex::Regex;

impl<'a> ApiDartGeneratorClassTrait for RustOpaqueApiDartGenerator<'a> {
    fn generate_class(&self) -> Option<ApiDartGeneratedClass> {
        let Info {
            dart_api_type,
            methods,
        } = self.compute_info(
            &GenerateApiMethodConfig {
                mode_static: GenerateApiMethodMode::DeclAndImpl,
                mode_non_static: GenerateApiMethodMode::DeclOnly,
            },
            "",
        );
        let methods_str = &methods.code;

        let rust_api_type = self.mir.rust_api_type();

        let extra_body =
            generate_class_extra_body(self.mir_type(), &self.context.mir_pack.dart_code_of_type);

        let (maybe_impls, maybe_impls_header) =
            generate_maybe_impls(&self.context.mir_pack.trait_impls, &self.mir, self.context);

        Some(ApiDartGeneratedClass {
            namespace: self.mir.namespace.clone(),
            class_name: dart_api_type.clone(),
            code: format!(
                "
                // Rust type: {rust_api_type}
                abstract class {dart_api_type}{maybe_impls} {{
                    {methods_str}

                    void dispose();

                    bool get isDisposed;

                    {extra_body}
                }}
                "
            ),
            needs_freezed: false,
            header: methods.header + maybe_impls_header,
        })
    }

    fn generate_extra_impl_code(&self) -> Option<String> {
        let Info {
            dart_api_type,
            methods,
        } = self.compute_info(
            &GenerateApiMethodConfig {
                mode_static: GenerateApiMethodMode::Nothing,
                mode_non_static: GenerateApiMethodMode::DeclAndImpl,
            },
            "Impl",
        );
        let methods_str = &methods.code;

        let dart_api_type_impl = format!("{dart_api_type}Impl");

        let dart_entrypoint_class_name = &self.context.config.dart_entrypoint_class_name;
        let dart_api_instance = format!("{dart_entrypoint_class_name}.instance.api");

        Some(format!(
            "
            @sealed class {dart_api_type_impl} extends RustOpaque implements {dart_api_type} {{
                // Not to be used by end users
                {dart_api_type_impl}.frbInternalDcoDecode(List<dynamic> wire):
                    super.frbInternalDcoDecode(wire, _kStaticData);

                // Not to be used by end users
                {dart_api_type_impl}.frbInternalSseDecode(BigInt ptr, int externalSizeOnNative):
                    super.frbInternalSseDecode(ptr, externalSizeOnNative, _kStaticData);

                static final _kStaticData = RustArcStaticData(
                    rustArcIncrementStrongCount: {dart_api_instance}.rust_arc_increment_strong_count_{dart_api_type},
                    rustArcDecrementStrongCount: {dart_api_instance}.rust_arc_decrement_strong_count_{dart_api_type},
                    rustArcDecrementStrongCountPtr: {dart_api_instance}.rust_arc_decrement_strong_count_{dart_api_type}Ptr,
                );

                {methods_str}
            }}"
        ))
    }
}

impl RustOpaqueApiDartGenerator<'_> {
    fn compute_info(
        &self,
        config: &GenerateApiMethodConfig,
        dart_class_name_postfix: &str,
    ) -> Info {
        let dart_api_type = ApiDartGenerator::new(self.mir.clone(), self.context).dart_api_type();
        let type_query_name = compute_query_name(&self.mir);

        let methods = generate_api_methods(
            &NamespacedName::new(self.mir.namespace.clone(), type_query_name.clone()),
            self.context,
            config,
            &format!("{dart_api_type}{dart_class_name_postfix}"),
        );

        Info {
            dart_api_type,
            methods,
        }
    }
}

struct Info {
    dart_api_type: String,
    methods: GeneratedApiMethods,
}

fn compute_query_name(mir: &MirTypeRustOpaque) -> String {
    lazy_static! {
        static ref FILTER: Regex =
            Regex::new(r"^flutter_rust_bridge::for_generated::RustAutoOpaqueInner<(.*)>$").unwrap();
    }

    FILTER.replace_all(&mir.inner.0, "$1").to_string()
}

fn generate_maybe_impls(
    all_trait_impls: &[MirTraitImpl],
    self_type: &MirTypeRustOpaque,
    context: ApiDartGeneratorContext,
) -> (String, DartBasicHeaderCode) {
    let interest_trait_impls = all_trait_impls
        .iter()
        .filter(|x| {
            (get_candidate_safe_idents_for_matching(&x.impl_ty).iter())
                .any(|x| x == &self_type.safe_ident())
        })
        .collect_vec();

    if interest_trait_impls.is_empty() {
        return ("".to_owned(), Default::default());
    }

    let combined_impls = (interest_trait_impls.iter())
        .map(|t| ApiDartGenerator::new(t.trait_ty.clone(), context).dart_api_type())
        .join(", ");
    let code = format!(" implements {}", combined_impls);

    let interest_trait_types = (interest_trait_impls.iter())
        .map(|x| MirType::TraitDef(x.trait_ty.clone()))
        .collect_vec();
    let import = generate_imports_which_types_and_funcs_use(
        &self_type.namespace,
        &Some(&interest_trait_types.iter().collect()),
        &None,
        context,
    )
    .unwrap();

    (
        code,
        DartBasicHeaderCode {
            import,
            ..Default::default()
        },
    )
}

#[allow(clippy::single_match)]
fn get_candidate_safe_idents_for_matching(ty: &MirType) -> Vec<String> {
    let mut ans = vec![ty.safe_ident()];
    match ty {
        MirType::RustAutoOpaqueImplicit(ty) => ans.push(ty.inner.safe_ident()),
        _ => {}
    }
    ans
}
