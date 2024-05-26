use crate::codegen::ir::field::IrField;
use crate::codegen::ir::func::{
    IrFunc, IrFuncAccessorMode, IrFuncInput, IrFuncMode, IrFuncOutput, IrFuncOwnerInfo,
    IrFuncOwnerInfoMethod, IrFuncOwnerInfoMethodMode, OwnershipMode,
};
use crate::codegen::ir::ident::IrIdent;
use crate::codegen::ir::namespace::NamespacedName;
use crate::codegen::ir::ty::primitive::IrTypePrimitive;
use crate::codegen::ir::ty::IrType;
use crate::codegen::parser::attribute_parser::FrbAttributes;
use crate::codegen::parser::auto_accessor_parser::IrFuncAndSanityCheckInfo;
use crate::codegen::parser::function_parser::argument::merge_ownership_into_ty;
use crate::codegen::parser::function_parser::{
    compute_codec_mode_pack, parse_effective_function_name_of_method,
};
use crate::codegen::parser::internal_config::ParserInternalConfig;
use crate::codegen::parser::sanity_checker::auto_accessor_checker;
use crate::codegen::parser::type_parser::{TypeParser, TypeParserParsingContext};
use sha1::{Digest, Sha1};

pub(super) fn parse_auto_accessor_of_field(
    config: &ParserInternalConfig,
    struct_name: &NamespacedName,
    field: &IrField,
    accessor_mode: IrFuncAccessorMode,
    ty_direct_parse: &IrType,
    type_parser: &mut TypeParser,
    context: &TypeParserParsingContext,
) -> anyhow::Result<IrFuncAndSanityCheckInfo> {
    let rust_method_name = format!("{}_{}", accessor_mode.verb_str(), field.name.raw);

    let owner = IrFuncOwnerInfoMethod {
        owner_ty: ty_direct_parse.to_owned(),
        actual_method_name: rust_method_name,
        actual_method_dart_name: Some(field.name.raw.clone()),
        mode: IrFuncOwnerInfoMethodMode::Instance,
    };

    let mut inputs = vec![compute_self_arg(
        accessor_mode,
        ty_direct_parse,
        type_parser,
        context,
    )?];
    if accessor_mode == IrFuncAccessorMode::Setter {
        inputs.push(IrFuncInput {
            ownership_mode: None,
            inner: create_ir_field(field.ty.clone(), &field.name.raw),
        });
    }

    let field_name_rust = field.name.rust_style();
    let rust_call_code = match accessor_mode {
        IrFuncAccessorMode::Getter => format!("api_that.{field_name_rust}.clone()"),
        IrFuncAccessorMode::Setter => {
            format!("{{ api_that.{field_name_rust} = api_{field_name_rust}; }}")
        }
    };

    let ir_func = IrFunc {
        name: NamespacedName::new(
            struct_name.namespace.clone(),
            parse_effective_function_name_of_method(&owner),
        ),
        dart_name: None,
        id: None,
        inputs,
        output: IrFuncOutput {
            normal: match accessor_mode {
                IrFuncAccessorMode::Getter => field.ty.clone(),
                IrFuncAccessorMode::Setter => IrType::Primitive(IrTypePrimitive::Unit),
            },
            error: None,
        },
        owner: IrFuncOwnerInfo::Method(owner),
        mode: IrFuncMode::Sync,
        stream_dart_await: false,
        rust_async: false,
        initializer: false,
        accessor: Some(accessor_mode),
        comments: vec![],
        codec_mode_pack: compute_codec_mode_pack(
            &FrbAttributes::parse(&[]).unwrap(),
            &config.force_codec_mode_pack,
        ),
        rust_call_code: Some(rust_call_code),
        src_lineno_pseudo: compute_src_lineno_pseudo(struct_name, field),
    };

    Ok(IrFuncAndSanityCheckInfo {
        ir_func,
        sanity_check_hint: auto_accessor_checker::check_field(struct_name, field),
    })
}

fn compute_self_arg(
    accessor_mode: IrFuncAccessorMode,
    ty_direct_parse: &IrType,
    type_parser: &mut TypeParser,
    context: &TypeParserParsingContext,
) -> anyhow::Result<IrFuncInput> {
    let ownership_mode = Some(match accessor_mode {
        IrFuncAccessorMode::Getter => OwnershipMode::Ref,
        IrFuncAccessorMode::Setter => OwnershipMode::RefMut,
    });

    let (ty_interest, ownership_mode) = merge_ownership_into_ty(
        type_parser,
        context,
        ty_direct_parse.to_owned(),
        ownership_mode,
    )?;

    Ok(IrFuncInput {
        ownership_mode,
        inner: create_ir_field(ty_interest, "that"),
    })
}

fn compute_src_lineno_pseudo(struct_name: &NamespacedName, field: &IrField) -> usize {
    let mut hasher = Sha1::new();
    hasher.update(struct_name.rust_style().as_bytes());
    hasher.update(field.name.raw.as_bytes());
    let digest = hasher.finalize();
    usize::from_le_bytes(digest[..8].try_into().unwrap())
}

fn create_ir_field(ty: IrType, name: &str) -> IrField {
    IrField {
        ty,
        name: IrIdent::new(name.to_owned()),
        is_final: true,
        is_rust_public: None,
        comments: vec![],
        default: None,
        settings: Default::default(),
    }
}
