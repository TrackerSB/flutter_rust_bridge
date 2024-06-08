use crate::codegen::ir::mir::func::OwnershipMode;
use crate::codegen::ir::mir::ty::rust_auto_opaque_implicit::{
    MirRustAutoOpaqueRaw, MirTypeRustAutoOpaqueImplicit, MirTypeRustAutoOpaqueImplicitReason,
};
use crate::codegen::ir::mir::ty::rust_opaque::{
    MirRustOpaqueInner, MirTypeRustOpaque, RustOpaqueCodecMode,
};
use crate::codegen::ir::mir::ty::{MirType, MirTypeTrait};
use crate::codegen::parser::mir::parser::ty::path_data::extract_path_data;
use crate::codegen::parser::mir::parser::ty::rust_opaque::{
    GeneralizedRustOpaqueParserInfo, RustOpaqueParserTypeInfo,
};
use crate::codegen::parser::mir::parser::ty::TypeParserWithContext;
use crate::utils::namespace::Namespace;
use anyhow::Result;
use quote::ToTokens;
use syn::Type;
use MirType::RustAutoOpaqueImplicit;

impl<'a, 'b, 'c> TypeParserWithContext<'a, 'b, 'c> {
    pub(crate) fn parse_type_rust_auto_opaque_implicit(
        &mut self,
        namespace: Option<Namespace>,
        ty: &Type,
        reason: Option<MirTypeRustAutoOpaqueImplicitReason>,
        override_ignore: Option<bool>,
    ) -> Result<MirType> {
        let (inner, ownership_mode) = split_ownership_from_ty(ty);
        let (ans_raw, ans_inner) =
            self.parse_type_rust_auto_opaque_common(inner, namespace, None)?;
        Ok(RustAutoOpaqueImplicit(MirTypeRustAutoOpaqueImplicit {
            ownership_mode,
            raw: ans_raw,
            inner: ans_inner,
            ignore: override_ignore.unwrap_or(false),
            reason,
        }))
    }

    pub(crate) fn parse_type_rust_auto_opaque_common(
        &mut self,
        inner: Type,
        namespace: Option<Namespace>,
        codec: Option<RustOpaqueCodecMode>,
    ) -> Result<(MirRustAutoOpaqueRaw, MirTypeRustOpaque)> {
        let inner_str = inner.to_token_stream().to_string();
        let info = self.get_or_insert_rust_auto_opaque_info(&inner_str, namespace, codec);
        parse_type_rust_auto_opaque_common_raw(inner, info.namespace, info.codec)
    }

    fn get_or_insert_rust_auto_opaque_info(
        &mut self,
        inner: &str,
        namespace: Option<Namespace>,
        codec: Option<RustOpaqueCodecMode>,
    ) -> RustOpaqueParserTypeInfo {
        self.inner.rust_auto_opaque_parser_info.get_or_insert(
            inner.to_owned(),
            RustOpaqueParserTypeInfo::new(
                namespace.unwrap_or(self.context.initiated_namespace.clone()),
                codec
                    .or(self.context.func_attributes.rust_opaque_codec())
                    .unwrap_or(self.context.default_rust_opaque_codec),
            ),
        )
    }

    pub(crate) fn transform_rust_auto_opaque(
        &mut self,
        ty_raw: &MirTypeRustAutoOpaqueImplicit,
        transform: impl FnOnce(&str) -> String,
    ) -> Result<MirType> {
        self.parse_type_rust_auto_opaque_implicit(
            ty_raw.self_namespace(),
            &syn::parse_str(&transform(&ty_raw.raw.string))?,
            None,
            None,
        )
    }
}

pub(super) type RustAutoOpaqueParserInfo = GeneralizedRustOpaqueParserInfo;

pub(crate) fn split_ownership_from_ty(ty: &Type) -> (Type, OwnershipMode) {
    match ty {
        Type::Reference(ty) => (
            (*ty.elem).to_owned(),
            if ty.mutability.is_some() {
                OwnershipMode::RefMut
            } else {
                OwnershipMode::Ref
            },
        ),
        _ => (ty.clone(), OwnershipMode::Owned),
    }
}

pub(crate) fn parse_type_rust_auto_opaque_common_raw(
    inner: Type,
    namespace: Namespace,
    codec: RustOpaqueCodecMode,
) -> Result<(MirRustAutoOpaqueRaw, MirTypeRustOpaque)> {
    let inner_str = inner.to_token_stream().to_string();

    let raw_segments = match inner {
        Type::Path(inner) => extract_path_data(&inner.path)?,
        _ => vec![],
    };

    Ok((
        MirRustAutoOpaqueRaw {
            string: inner_str.clone(),
            segments: raw_segments,
        },
        MirTypeRustOpaque {
            namespace,
            // TODO when all usages of a type do not require `&mut`, can drop this Mutex
            // TODO similarly, can use std instead of `tokio`'s lock
            inner: MirRustOpaqueInner(format!(
                "flutter_rust_bridge::for_generated::RustAutoOpaqueInner<{inner_str}>"
            )),
            codec,
            brief_name: true,
        },
    ))
}
