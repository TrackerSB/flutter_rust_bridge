use crate::codegen::ir::ty::IrType;
use crate::codegen::parser::type_parser::misc::convert_ident_str;
use crate::codegen::parser::type_parser::TypeParserWithContext;
use anyhow::Context;
use syn::Type;

impl<'a, 'b, 'c> TypeParserWithContext<'a, 'b, 'c> {
    pub(crate) fn parse_type(&mut self, ty: &Type) -> anyhow::Result<IrType> {
        let resolve_ty = self.resolve_alias(ty);

        Ok(match resolve_ty.clone() {
            Type::Path(path) => self.parse_type_path(&path)?,
            Type::Array(type_array) => self.parse_type_array(&type_array)?,
            Type::Tuple(type_tuple) => self.parse_type_tuple(&type_tuple)?,
            Type::ImplTrait(type_impl_trait) => self
                .parse_type_impl_trait_dart_fn(&type_impl_trait)
                .context("when trying to parse DartFn")?,
            _ => self.parse_type_rust_auto_opaque_implicit(None, &resolve_ty)?,
        })
    }

    fn resolve_alias(&self, ty: &Type) -> Type {
        self.get_alias_type(ty).unwrap_or(ty).clone()
    }

    fn get_alias_type(&self, ty: &Type) -> Option<&Type> {
        convert_ident_str(ty).and_then(|key| self.inner.src_types.get(&key))
    }
}
