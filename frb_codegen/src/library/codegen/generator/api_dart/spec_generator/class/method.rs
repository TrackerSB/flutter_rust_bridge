use crate::codegen::generator::api_dart;
use crate::codegen::generator::api_dart::spec_generator::function::{
    ApiDartGeneratedFunction, ApiDartGeneratedFunctionParam,
};
use crate::codegen::generator::api_dart::spec_generator::misc::generate_dart_comments;
use crate::codegen::ir::func::{
    IrFunc, IrFuncAccessorMode, IrFuncDefaultConstructorMode, IrFuncOwnerInfo,
    IrFuncOwnerInfoMethod, IrFuncOwnerInfoMethodMode,
};
use crate::codegen::ir::namespace::NamespacedName;
use crate::if_then_some;
use crate::library::codegen::generator::api_dart::spec_generator::base::*;
use convert_case::{Case, Casing};
use itertools::Itertools;

pub(crate) fn generate_api_methods(
    generalized_class_name: &NamespacedName,
    context: ApiDartGeneratorContext,
) -> Vec<String> {
    get_methods_of_enum_or_struct(generalized_class_name, &context.ir_pack.funcs)
        .iter()
        .map(|func| generate_api_method(func, context))
        .collect_vec()
}

// TODO move
pub(crate) fn dart_constructor_postfix(
    name: &NamespacedName,
    all_funcs: &[IrFunc],
) -> &'static str {
    if has_default_dart_constructor(name, all_funcs) {
        ".raw"
    } else {
        ""
    }
}

fn has_default_dart_constructor(name: &NamespacedName, all_funcs: &[IrFunc]) -> bool {
    get_methods_of_enum_or_struct(name, all_funcs)
        .iter()
        .any(|m| {
            m.default_constructor_mode() == Some(IrFuncDefaultConstructorMode::DartConstructor)
        })
}

fn get_methods_of_enum_or_struct<'a>(
    name: &NamespacedName,
    all_funcs: &'a [IrFunc],
) -> Vec<&'a IrFunc> {
    (all_funcs.iter())
        .filter(|f| matches!(&f.owner, IrFuncOwnerInfo::Method(m) if &m.owner_ty_name() == name))
        .collect_vec()
}

fn generate_api_method(func: &IrFunc, context: ApiDartGeneratorContext) -> String {
    let api_dart_func = api_dart::spec_generator::function::generate(func, context).unwrap();

    let method_info =
        if_then_some!(let IrFuncOwnerInfo::Method(info) = &func.owner , info).unwrap();
    let default_constructor_mode = func.default_constructor_mode();

    let skip_names = compute_skip_names(func, method_info);
    let params = (api_dart_func.func_params.iter())
        .filter(|param| !skip_names.contains(&&param.name_str[..]))
        .collect_vec();

    let comments = generate_comments(func, default_constructor_mode);
    let signature = generate_signature(
        func,
        method_info,
        &params,
        default_constructor_mode,
        &api_dart_func,
    );
    let implementation = generate_implementation(func, context, method_info, &params);

    format!("{comments}{signature}=>{implementation};\n\n")
}

fn compute_skip_names(func: &IrFunc, method_info: &IrFuncOwnerInfoMethod) -> Vec<&'static str> {
    let mut ans = vec![];
    if method_info.mode != IrFuncOwnerInfoMethodMode::Static {
        ans.push("that");
    }
    if func.accessor.is_some() {
        ans.push("hint");
    }
    ans
}

fn generate_comments(
    func: &IrFunc,
    default_constructor_mode: Option<IrFuncDefaultConstructorMode>,
) -> String {
    let mut ans = String::new();
    if default_constructor_mode == Some(IrFuncDefaultConstructorMode::StaticMethod) {
        ans += "  // HINT: Make it `#[frb(sync)]` to let it become the default constructor of Dart class.\n";
    }
    ans += &generate_dart_comments(&func.comments);
    ans
}

fn generate_signature(
    func: &IrFunc,
    method_info: &IrFuncOwnerInfoMethod,
    func_params: &[&ApiDartGeneratedFunctionParam],
    default_constructor_mode: Option<IrFuncDefaultConstructorMode>,
    api_dart_func: &ApiDartGeneratedFunction,
) -> String {
    let is_static_method = method_info.mode == IrFuncOwnerInfoMethodMode::Static;
    let maybe_static = if is_static_method { "static" } else { "" };
    let return_type = &api_dart_func.func_return_type;
    let method_name = if default_constructor_mode.is_some() {
        "newInstance".to_owned()
    } else {
        (method_info
            .actual_method_dart_name
            .as_ref()
            .unwrap_or(&method_info.actual_method_name))
        .to_case(Case::Camel)
    };
    let (func_params, maybe_accessor) = match func.accessor {
        Some(IrFuncAccessorMode::Getter) => ("".to_owned(), "get"),
        Some(IrFuncAccessorMode::Setter) => (
            format!(
                "({})",
                func_params
                    .iter()
                    .map(|x| format!("{} {}", x.type_str, x.name_str))
                    .join(", ")
            ),
            "set",
        ),
        None => (
            format!("({{ {} }})", func_params.iter().map(|x| &x.full).join(",")),
            "",
        ),
    };

    if default_constructor_mode == Some(IrFuncDefaultConstructorMode::DartConstructor) {
        return format!("factory {return_type}{func_params}");
    }

    format!("{maybe_static} {return_type} {maybe_accessor} {method_name}{func_params}")
}

fn generate_implementation(
    func: &IrFunc,
    context: ApiDartGeneratorContext,
    method_info: &IrFuncOwnerInfoMethod,
    params: &[&ApiDartGeneratedFunctionParam],
) -> String {
    let dart_entrypoint_class_name = &context.config.dart_entrypoint_class_name;
    let dart_api_instance = format!("{dart_entrypoint_class_name}.instance.api");

    let func_name = func.name_dart_wire();

    let arg_names = params
        .iter()
        .map(|x| format!("{name}: {name}", name = x.name_str))
        .join(", ");

    if method_info.mode == IrFuncOwnerInfoMethodMode::Static {
        format!("{dart_api_instance}.{func_name}({arg_names})")
    } else {
        let extra_arg_name = func.inputs[0].inner.name.dart_style();
        format!("{dart_api_instance}.{func_name}({extra_arg_name}: this, {arg_names})")
    }
}
