use crate::codegen::ir::mir::ty::MirType;
use crate::codegen::parser::mir::type_parser::TypeParserWithContext;
use crate::utils::syn_utils::ty_to_string;
use syn::TypeTraitObject;

impl<'a, 'b, 'c> TypeParserWithContext<'a, 'b, 'c> {
    pub(crate) fn parse_type_trait_object(
        &mut self,
        type_trait_object: &TypeTraitObject,
    ) -> anyhow::Result<MirType> {
        if let Some(out) = self.parse_type_trait_object_inner(type_trait_object)? {
            return Ok(out);
        }

        // fallback
        self.parse_type_rust_auto_opaque_implicit(
            None,
            &syn::Type::TraitObject(type_trait_object.clone()),
            None,
            None,
        )
    }

    fn parse_type_trait_object_inner(
        &mut self,
        type_trait_object: &TypeTraitObject,
    ) -> anyhow::Result<Option<MirType>> {
        if let Some(trait_name) = extract_trait_name(type_trait_object) {
            return Ok(TODO);
        }
        Ok(None)
    }
}

fn extract_trait_name(type_trait_object: &TypeTraitObject) -> Option<syn::Path> {
    let bounds = &type_trait_object.bounds;
    if bounds.len() != 1 {
        return None;
    }

    if let syn::TypeParamBound::Trait(trait_bound) = bounds.first().unwrap() {
        Some(trait_bound.path.clone())
    } else {
        None
    }
}