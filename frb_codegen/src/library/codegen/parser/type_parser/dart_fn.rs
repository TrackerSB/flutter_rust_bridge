use crate::codegen::ir::ty::dart_fn::IrDartFnOutput;
use crate::codegen::ir::ty::dart_fn::IrTypeDartFn;
use crate::codegen::ir::ty::delegate::IrTypeDelegate;
use crate::codegen::ir::ty::IrType;
use crate::codegen::parser::type_parser::result::{parse_type_maybe_result, ResultTypeInfo};
use crate::codegen::parser::type_parser::TypeParserWithContext;
use crate::if_then_some;
use anyhow::{bail, Context};
use syn::{
    AngleBracketedGenericArguments, GenericArgument, PathArguments, PathSegment, ReturnType, Type,
    TypeImplTrait, TypeParamBound, TypePath,
};

impl<'a, 'b, 'c> TypeParserWithContext<'a, 'b, 'c> {
    pub(crate) fn parse_type_impl_trait_dart_fn(
        &mut self,
        type_impl_trait: &TypeImplTrait,
    ) -> anyhow::Result<IrType> {
        let trait_bound = (type_impl_trait.bounds.iter())
            .filter_map(
                |x| if_then_some!(let TypeParamBound::Trait(trait_bound) = x, trait_bound.clone()),
            )
            .next()
            .context("cannot find trait_bound")?;

        let segment = (trait_bound.path.segments.last()).context("cannot get segment")?;

        let segment_ident = segment.ident.to_string();
        match &segment_ident[..] {
            // TODO Currently, we treat `FnOnce` same as `Fn`,
            //      but in the future we can optimize this because we no longer need Arc or Clone for this case.
            "FnOnce" | "Fn" => {} // Ok
            // This will stop the whole generator and tell the users, so we do not care about testing it
            // frb-coverage:ignore-start
            _ => bail!("Unknown ident: {segment_ident}"),
            // frb-coverage:ignore-end
        }

        if let PathArguments::Parenthesized(arguments) = &segment.arguments {
            let inputs = (arguments.inputs.iter())
                .map(|x| self.parse_type(x))
                .collect::<anyhow::Result<Vec<_>>>()?;

            let output = self.parse_dart_fn_output(&arguments.output)?;

            return Ok(IrType::DartFn(IrTypeDartFn {
                inputs,
                output: Box::new(IrDartFnOutput {
                    normal: output.ok_output,
                    error: output.error_output.clone().unwrap_or(FALLBACK_ERROR_TYPE),
                    api_fallible: output.error_output.is_some(),
                }),
            }));

            // This will stop the whole generator and tell the users, so we do not care about testing it
            // frb-coverage:ignore-start
        }

        bail!("Fail to parse DartFn")
        // frb-coverage:ignore-end
    }

    // the function signature is not covered while the whole body is covered - looks like a bug in coverage tool
    // frb-coverage:ignore-start
    fn parse_dart_fn_output(&mut self, return_type: &ReturnType) -> anyhow::Result<ResultTypeInfo> {
        // frb-coverage:ignore-end
        if let ReturnType::Type(_, ret_ty) = return_type {
            if let Type::Path(TypePath { ref path, .. }) = **ret_ty {
                if let Some(PathSegment {
                    ident,
                    arguments:
                        PathArguments::AngleBracketed(AngleBracketedGenericArguments { args, .. }),
                }) = path.segments.first()
                {
                    if &ident.to_string() == "DartFnFuture" {
                        if let GenericArgument::Type(inner_ty) = (args.iter())
                            .find(|arg| matches!(arg, GenericArgument::Type(_)))
                            .unwrap()
                        {
                            let ir = self.parse_type(inner_ty)?;
                            return parse_type_maybe_result(&ir, self.inner, self.context);

                            // This will stop the whole generator and tell the users, so we do not care about testing it
                            // frb-coverage:ignore-start
                        }
                    }
                }
            }
        }

        bail!("DartFn does not support return types except `DartFnFuture<T>` yet")
        // frb-coverage:ignore-end
    }
}

const FALLBACK_ERROR_TYPE: IrType = IrType::Delegate(IrTypeDelegate::AnyhowException);

// // Use this unit "test" to see how a type will be parsed into a tree
// #[cfg(test)]
// mod tests {
//     #[test]
//     fn test_syn_parse_example() {
//         let ans: syn::Type =
//             syn::parse_str("impl Fn(Apple) -> DartFnFuture<Orange> + UnwindSafe").unwrap();
//         println!("{ans:#?}");
//     }
// }
