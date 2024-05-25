use crate::codegen::generator::acc::Acc;
use crate::codegen::generator::misc::target::TargetOrCommon;
use crate::codegen::generator::wire::misc::has_port_argument;
use crate::codegen::generator::wire::rust::spec_generator::base::WireRustGeneratorContext;
use crate::codegen::generator::wire::rust::spec_generator::codec::base::WireRustCodecEntrypoint;
use crate::codegen::generator::wire::rust::spec_generator::extern_func::{
    ExternFunc, ExternFuncParam,
};
use crate::codegen::generator::wire::rust::spec_generator::output_code::WireRustOutputCode;
use crate::codegen::ir::func::{IrFunc, IrFuncMode, IrFuncOwnerInfo};
use crate::codegen::ir::ty::IrType;
use crate::if_then_some;
use crate::misc::consts::HANDLER_NAME;
use convert_case::{Case, Casing};
use itertools::Itertools;
use std::convert::TryInto;

pub(crate) fn generate_wire_func(
    func: &IrFunc,
    context: WireRustGeneratorContext,
) -> Acc<WireRustOutputCode> {
    let dart2rust_codec = WireRustCodecEntrypoint::from(func.codec_mode_pack.dart2rust);

    let params = dart2rust_codec.generate_func_params(func, context);
    let inner_func_args = generate_inner_func_args(func);
    let wrap_info_obj = generate_wrap_info_obj(func);
    let code_decode = dart2rust_codec.generate_func_call_decode(func, context);
    let code_inner_decode = generate_code_inner_decode(func);
    let code_call_inner_func_result = generate_code_call_inner_func_result(func, inner_func_args);
    let handler_func_name = generate_handler_func_name(func);
    let return_type = generate_return_type(func);
    let code_closure = generate_code_closure(
        func,
        &code_decode,
        &code_inner_decode,
        &code_call_inner_func_result,
    );
    let func_name = wire_func_name(func);

    Acc::new(|target| match target {
        TargetOrCommon::Io | TargetOrCommon::Web => ExternFunc {
            partial_func_name: func_name.clone(),
            params: params.clone().get(target),
            return_type: return_type.clone(),
            body: generate_redirect_body(func, &params.common),
            target: target.try_into().unwrap(),
            needs_ffigen: true,
        }
        .into(),
        TargetOrCommon::Common => format!(
            "fn {func_name}_impl({params}) {return_type} {{
                {HANDLER_NAME}.{handler_func_name}({wrap_info_obj}, move || {{ {code_closure} }})
            }}",
            HANDLER_NAME = HANDLER_NAME,
            params = params
                .common
                .iter()
                .map(|param| param.rust_name_and_type())
                .join(","),
            return_type = return_type
                .clone()
                .map(|t| format!("-> {t}"))
                .unwrap_or_default(),
        )
        .into(),
    })
}

fn generate_inner_func_args(func: &IrFunc) -> Vec<String> {
    let ans = func
        .inputs
        .iter()
        .map(|field| {
            let mut ans = format!("api_{}", field.inner.name.rust_style());
            let ownership_mode =
                if_then_some!(let IrType::RustAutoOpaqueImplicit(o) = &field.inner.ty, o.ownership_mode)
                    .or(field.ownership_mode);
            if let Some(ownership_mode) = ownership_mode {
                ans = format!("{}{ans}", ownership_mode.prefix())
            }
            ans
        })
        .collect_vec();

    ans
}

fn generate_wrap_info_obj(func: &IrFunc) -> String {
    format!(
        "flutter_rust_bridge::for_generated::TaskInfo{{ debug_name: \"{name}\", port: {port}, mode: flutter_rust_bridge::for_generated::FfiCallMode::{mode} }}",
        name = func.name.name,
        port = if has_port_argument(func.mode) {
            "Some(port_)"
        } else {
            "None"
        },
        mode = ffi_call_mode(func.mode),
    )
}

fn generate_code_inner_decode(func: &IrFunc) -> String {
    super::wire_func_rao::generate_code_inner_decode(func)
}

fn generate_code_call_inner_func_result(func: &IrFunc, inner_func_args: Vec<String>) -> String {
    let mut ans = match &func.owner {
        IrFuncOwnerInfo::Function => {
            format!("{}({})", func.name.rust_style(), inner_func_args.join(", "))
        }
        IrFuncOwnerInfo::Method(method) => {
            format!(
                r"{}::{}({})",
                method.owner_ty_name().rust_style(),
                method.actual_method_name,
                inner_func_args.join(", ")
            )
        }
    };

    if func.rust_async {
        ans = format!("{ans}.await");
    }

    if !func.fallible() {
        ans = format!("Result::<_,()>::Ok({ans})");
    }

    ans
}

fn generate_handler_func_name(func: &IrFunc) -> String {
    let codec = format!(
        "flutter_rust_bridge::for_generated::{}Codec",
        func.codec_mode_pack.rust2dart.delegate_or_self()
    );

    match func.mode {
        IrFuncMode::Sync => format!("wrap_sync::<{codec},_>"),
        IrFuncMode::Normal => {
            let name = if func.rust_async {
                "wrap_async"
            } else {
                "wrap_normal"
            };

            let generic_args = if func.rust_async {
                format!("<{codec},_,_,_>")
            } else {
                format!("<{codec},_,_>")
            };

            format!("{name}::{generic_args}")
        }
    }
}

fn generate_return_type(func: &IrFunc) -> Option<String> {
    match func.mode {
        IrFuncMode::Sync => Some(format!(
            "flutter_rust_bridge::for_generated::WireSyncRust2Dart{}",
            func.codec_mode_pack.rust2dart.delegate_or_self(),
        )),
        IrFuncMode::Normal => None,
    }
}

fn generate_code_closure(
    func: &IrFunc,
    code_decode: &str,
    code_inner_decode: &str,
    code_call_inner_func_result: &str,
) -> String {
    let codec = (func.codec_mode_pack.rust2dart.delegate_or_self())
        .to_string()
        .to_case(Case::Snake);

    match func.mode {
        IrFuncMode::Sync => {
            format!(
                "{code_decode}
                transform_result_{codec}((move || {{
                    {code_inner_decode} {code_call_inner_func_result}
                }})())"
            )
        }
        IrFuncMode::Normal => {
            let maybe_async_move = if func.rust_async { "async move" } else { "" };
            let maybe_await = if func.rust_async { ".await" } else { "" };
            format!(
                "{code_decode} move |context| {maybe_async_move} {{
                    transform_result_{codec}((move || {maybe_async_move} {{
                        {code_inner_decode} {code_call_inner_func_result}
                    }})(){maybe_await})
                }}"
            )
        }
    }
}

fn generate_redirect_body(func: &IrFunc, params: &[ExternFuncParam]) -> String {
    format!(
        "{}_impl({})",
        wire_func_name(func),
        params.iter().map(|x| x.name.clone()).join(", "),
    )
}

pub(crate) fn wire_func_name(func: &IrFunc) -> String {
    let name = &func.name;
    format!("wire__{}__{}", name.namespace.safe_ident(), name.name)
}

fn ffi_call_mode(mode: IrFuncMode) -> &'static str {
    match mode {
        IrFuncMode::Normal => "Normal",
        IrFuncMode::Sync => "Sync",
    }
}
