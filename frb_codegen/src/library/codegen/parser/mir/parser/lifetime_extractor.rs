use crate::if_then_some;
use itertools::Itertools;
use syn::{GenericArgument, Type};

pub(crate) struct LifetimeExtractor;

impl LifetimeExtractor {
    pub(crate) fn extract_skipping_static(ty: &Type) -> Vec<Lifetime> {
        let ans = (Self::extract(ty).into_iter())
            .filter(|lifetime| lifetime.0 != LIFETIME_STATIC)
            .collect_vec();
        log::warn!("extract_skipping_static ans={ans:?} ty={ty:?}");
        ans
    }

    fn extract(ty: &Type) -> Vec<Lifetime> {
        match ty {
            Type::Path(ty) => (ty.path.segments.iter())
                .filter_map(|segment| if_then_some!(let syn::PathArguments::AngleBracketed(inner) = &segment.arguments, inner))
                .flat_map(Self::extract_generic_arguments)
                .collect_vec(),
            _ => vec![],
        }
    }

    fn extract_generic_arguments(args: &syn::AngleBracketedGenericArguments) -> Vec<Lifetime> {
        (args.args.iter())
            .flat_map(|arg| match arg {
                GenericArgument::Lifetime(inner) => vec![Lifetime(inner.ident.to_string())],
                GenericArgument::Type(inner) => Self::extract(inner),
                _ => vec![],
            })
            .collect_vec()
    }
}

pub(crate) const LIFETIME_STATIC: &str = "static";

// TODO maybe move
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub(crate) struct Lifetime(pub String);
