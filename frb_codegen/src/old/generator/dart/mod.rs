mod func;
mod ty;
mod ty_boxed;
mod ty_dart_opaque;
mod ty_delegate;
mod ty_dynamic;
mod ty_enum;
mod ty_general_list;
mod ty_optional;
mod ty_optional_list;
mod ty_primitive;
mod ty_primitive_list;
mod ty_record;
mod ty_rust_opaque;
mod ty_struct;
mod ty_sync_return;
mod wasm;

use func::*;
use std::borrow::Cow;
use std::collections::HashSet;
use std::ffi::OsStr;
use std::path::Path;
use wasm::*;

use itertools::Itertools;
pub use ty::*;
pub use ty_boxed::*;
pub use ty_dart_opaque::*;
pub use ty_delegate::*;
pub use ty_dynamic::*;
pub use ty_enum::*;
pub use ty_general_list::*;
pub use ty_optional::*;
pub use ty_optional_list::*;
pub use ty_primitive::*;
pub use ty_primitive_list::*;
pub use ty_record::*;
pub use ty_rust_opaque::*;
pub use ty_struct::*;
pub use ty_sync_return::*;

use convert_case::{Case, Casing};
use log::debug;

use crate::ir::IrType::*;
use crate::others::*;
use crate::target::Target::*;
use crate::target::{Acc, Target};
use crate::utils::method::{FunctionName, MethodNamingUtil};
use crate::{ir::*, Opts};

pub struct Output {
    pub file_prelude: DartBasicCode,
    pub decl_code: DartBasicCode,
    pub impl_code: Acc<DartBasicCode>,
    pub needs_freezed: bool,
}

pub fn generate(ir_pack: &IrPack, config: &Opts, wasm_funcs: &[IrFuncDisplay]) -> Output {
    let dart_api_class_name = &config.dart_api_class_name();
    let dart_output_file_root = config.dart_output_root().expect("Internal error");
    let spec = DartApiSpec::from(ir_pack, config, wasm_funcs);
    let DartApiSpec {
        dart_funcs,
        dart_structs,
        ..
    } = &spec;
    let needs_freezed = spec.needs_freezed;
    let mut common_header = generate_common_header();
    common_header.import += &config.extra_headers;

    let decl_code = generate_dart_declaration_code(
        &common_header,
        generate_freezed_header(dart_output_file_root, needs_freezed),
        generate_import_header(get_dart_imports(ir_pack), spec.import_array.as_deref()),
        generate_dart_declaration_body(dart_api_class_name, dart_funcs, dart_structs),
    );

    let impl_code = generate_dart_implementation_code(
        &common_header,
        generate_dart_implementation_body(&spec, config),
    );

    let file_prelude = generate_file_prelude();

    Output {
        file_prelude,
        decl_code,
        impl_code,
        needs_freezed,
    }
}

struct DartApiSpec {
    dart_funcs: Vec<GeneratedApiFunc>,
    // dart_structs: Vec<String>,
    dart_opaque_funcs: Acc<String>,
    dart_wasm_funcs: Vec<String>,
    dart_wasm_module: Option<String>,
    import_array: Option<String>,
}

impl DartApiSpec {
    fn from(ir_pack: &IrPack, config: &Opts, extra_funcs: &[IrFuncDisplay]) -> Self {
        // let dart_api_class_name = config.dart_api_class_name();
        // let dart_wire_class_name = config.dart_wire_class_name();
        // let distinct_types = ir_pack.distinct_types(true, true);
        // let distinct_input_types = ir_pack.distinct_types(true, false);
        // let distinct_output_types = ir_pack.distinct_types(false, true);
        // debug!("distinct_input_types={:?}", distinct_input_types);
        // debug!("distinct_output_types={:?}", distinct_output_types);

        // moved
        // let dart_structs = distinct_types
        //     .iter()
        //     .map(|ty| TypeDartGenerator::new(ty.clone(), ir_pack, config).structs())
        //     .collect_vec();

        // moved
        // let dart_funcs = (ir_pack
        //     .funcs
        //     .iter()
        //     .map(|f| generate_api_func(f, ir_pack, &api2wire_funcs.common)))
        TODO.chain(
            distinct_output_types
                .iter()
                .filter(|ty| matches!(ty, IrType::RustOpaque(_)))
                .map(generate_opaque_getters),
        )
        .collect_vec();

        let dart_opaque_funcs = distinct_output_types
            .iter()
            .filter(|ty| matches!(ty, IrType::RustOpaque(_)))
            .map(generate_opaque_func)
            .collect::<Acc<_>>()
            .join("\n");

        let ir_wasm_func_exports = config.wasm_enabled.then(|| {
            ir_pack
                .funcs
                .iter()
                .map(|fun| IrFuncDisplay::from_ir(fun, Target::Wasm))
                .chain(extra_funcs.iter().cloned())
                .collect_vec()
        });
        let dart_wasm_funcs = ir_wasm_func_exports
            .as_ref()
            .map(|exports| exports.iter().map(generate_wasm_wire_func_decl).collect())
            .unwrap_or_default();
        let dart_wasm_module = ir_wasm_func_exports.as_ref().map(|exports| {
            generate_wasm_wire(exports, &dart_wire_class_name, &config.dart_wasm_module())
        });

        let import_array = distinct_types
            .iter()
            .any(IrType::is_array)
            .then(|| "import 'package:collection/collection.dart';".to_owned());

        DartApiSpec {
            dart_funcs,
            dart_structs,
            api2wire_funcs,
            dart_opaque_funcs,
            api_fill_to_wire_funcs,
            impl_wire2api,
            dart_wasm_funcs,
            dart_wasm_module,
            needs_freezed,
            import_array,
        }
    }
}

fn generate_freezed_header(dart_output_file_root: &str, needs_freezed: bool) -> DartBasicCode {
    if needs_freezed {
        DartBasicCode {
            import: "import 'package:freezed_annotation/freezed_annotation.dart' hide protected;"
                .to_string(),
            part: format!("part '{dart_output_file_root}.freezed.dart';"),
            body: "".to_string(),
        }
    } else {
        DartBasicCode::default()
    }
}

fn generate_import_header(
    imports: HashSet<&IrDartImport>,
    import_array: Option<&str>,
) -> DartBasicCode {
    if !imports.is_empty() || import_array.is_some() {
        DartBasicCode {
            import: imports
                .iter()
                .map(|it| match &it.alias {
                    Some(alias) => format!("import '{}' as {};", it.uri, alias),
                    _ => format!("import '{}';", it.uri),
                })
                .collect_vec()
                .join("\n")
                + import_array.unwrap_or(""),
            part: "".to_string(),
            body: "".to_string(),
        }
    } else {
        DartBasicCode::default()
    }
}

fn generate_common_header() -> DartBasicCode {
    DartBasicCode {
        import: format!(
            "{}{}",
            "import 'dart:convert';
            import 'dart:async';
            import 'package:meta/meta.dart';
            import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
            import 'package:uuid/uuid.dart';",
            if config.use_bridge_in_method {
                ""
            } else {
                "import 'ffi.io.dart' if (dart.library.html) 'ffi.web.dart';"
            },
        ),
        part: "".to_string(),
        body: "".to_string(),
    }
}

fn get_dart_imports(ir_pack: &IrPack) -> HashSet<&IrDartImport> {
    ir_pack
        .struct_pool
        .values()
        .flat_map(|s| s.dart_metadata.iter().flat_map(|it| &it.library))
        .collect()
}

fn section_header(header: &str) -> String {
    format!("// Section: {header}\n")
}

/// A Dart bridge module consists of several members:
/// - An `_Impl` class exposing the public Rust functions
/// - One or more `_Platform` classes implementing platform-specific helpers
///
/// The `_Impl` class takes a `_Platform _platform` instance as a private member,
/// and the `_Platform` exposes all of its methods decorated as `@protected`.
fn generate_dart_implementation_body(spec: &DartApiSpec, config: &Opts) -> Acc<DartBasicCode> {
    let mut lines = Acc::<Vec<_>>::default();
    let dart_api_impl_class_name = config.dart_api_impl_class_name();
    let dart_wire_class_name = config.dart_wire_class_name();
    let dart_api_class_name = config.dart_api_class_name();
    let dart_platform_class_name = config.dart_platform_class_name();
    let DartApiSpec {
        dart_funcs,
        api2wire_funcs,
        dart_opaque_funcs,
        api_fill_to_wire_funcs,
        impl_wire2api,
        dart_wasm_funcs,
        dart_wasm_module,
        ..
    } = spec;
    lines.push_acc(Acc {
        common: {
            let implement = &dart_api_impl_class_name;
            let plat = &dart_platform_class_name;
            format!(
                "class {implement} implements {dart_api_class_name} {{
                final {plat} _platform;
                factory {implement}(ExternalLibrary dylib) => {implement}.raw({plat}(dylib));

                /// Only valid on web/WASM platforms.
                factory {implement}.wasm(FutureOr<WasmModule> module) =>
                    {implement}(module as ExternalLibrary);
                {implement}.raw(this._platform);"
            )
        },
        io: {
            let plat = &dart_platform_class_name;
            let wire = &dart_wire_class_name;
            format!(
                "class {plat} extends FlutterRustBridgeBase<{wire}> {{
                {plat}(ffi.DynamicLibrary dylib) : super({wire}(dylib));"
            )
        },
        wasm: {
            let plat = &dart_platform_class_name;
            let wire = &dart_wire_class_name;
            format!(
                "class {plat} extends FlutterRustBridgeBase<{wire}> with FlutterRustBridgeSetupMixin {{
                {plat}(FutureOr<WasmModule> dylib) : super({wire}(dylib)) {{
                    setupMixinConstructor();
                }}
                Future<void> setup() => inner.init;",
            )
        },
    });

    lines.extend(dart_funcs.iter().map(|func| {
        format!(
            "{}\n\n{}",
            func.implementation, func.companion_field_implementation,
        )
    }));

    lines.push_acc(Acc {
        common: "void dispose() {_platform.dispose();}".to_owned(),
        ..Default::default()
    });

    lines.push(section_header("wire2api"));
    lines.push(impl_wire2api.join("\n\n"));

    lines.push("}\n".into());

    lines.push_all(section_header("api2wire"));
    lines.push_acc(api2wire_funcs.clone());

    lines.push_all(section_header("finalizer"));
    lines.push_acc(dart_opaque_funcs.clone());

    lines.io.push(section_header("api_fill_to_wire"));
    lines.io.push(api_fill_to_wire_funcs.join("\n\n"));

    lines.push_acc(Acc::new(|target| match target {
        Io | Wasm => "}\n".into(),
        Common => "".into(),
    }));

    if config.wasm_enabled {
        push_wasm_module(
            &mut lines,
            dart_wasm_funcs,
            dart_wasm_module.as_deref(),
            config,
        );
    }

    let Acc { common, io, wasm } = lines.join("\n");
    let impl_import = if config.wasm_enabled {
        format!(
            "import '{}'; export '{0}';",
            Path::new(&config.dart_output_path)
                .file_name()
                .and_then(OsStr::to_str)
                .unwrap()
        )
    } else {
        "".into()
    };

    // If WASM is not enabled, the common and IO branches are
    // combined into one, making this import statement invalid.
    let common_import = if config.wasm_enabled {
        format!(
            "import '{}' if (dart.library.html) '{}';",
            config
                .dart_io_output_path()
                .file_name()
                .and_then(OsStr::to_str)
                .unwrap(),
            config
                .dart_wasm_output_path()
                .file_name()
                .and_then(OsStr::to_str)
                .unwrap(),
        )
    } else {
        "".into()
    };
    Acc {
        common: DartBasicCode {
            body: common,
            import: common_import,
            ..Default::default()
        },
        io: DartBasicCode {
            import: impl_import.clone(),
            body: io,
            ..Default::default()
        },
        wasm: DartBasicCode {
            import: impl_import,
            body: wasm,
            ..Default::default()
        },
    }
}

fn generate_dart_declaration_code(
    common_header: &DartBasicCode,
    freezed_header: DartBasicCode,
    import_header: DartBasicCode,
    declaration_body: String,
) -> DartBasicCode {
    common_header
        + &freezed_header
        + &import_header
        + &DartBasicCode {
            import: "".to_string(),
            part: "".to_string(),
            body: declaration_body,
        }
}

fn generate_dart_implementation_code(
    common_header: &DartBasicCode,
    implementation_body: Acc<DartBasicCode>,
) -> Acc<DartBasicCode> {
    implementation_body.map(|body, _| common_header + &body)
}

fn generate_file_prelude() -> DartBasicCode {
    DartBasicCode {
        import: format!("{}
            // ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const
            ",
                        code_header()
        ),
        part: "".to_string(),
        body: "".to_string(),
    }
}

fn generate_opaque_func(ty: &IrType) -> Acc<String> {
    let api_type = ty.dart_api_type();
    let generate_impl = |finalizer_type: &str, finalizer_arg: &str| {
        format!(
            "late final {finalizer_type} _{api_type}Finalizer = {finalizer_type}({finalizer_arg});
            {finalizer_type} get {api_type}Finalizer => _{api_type}Finalizer;",
        )
    };

    Acc {
        io: generate_impl(
            "OpaqueTypeFinalizer",
            &format!("inner._drop_opaque_{api_type}Ptr"),
        ),
        wasm: generate_impl(
            "Finalizer<PlatformPointer>",
            &format!("inner.drop_opaque_{api_type}"),
        ),
        ..Default::default()
    }
}
