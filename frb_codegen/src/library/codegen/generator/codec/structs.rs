use crate::codegen::generator::codec::sse::lang::Lang;
use crate::codegen::ir::pack::IrPackComputedCache;
use crate::codegen::ir::ty::IrType;
use serde::{Deserialize, Serialize};
use strum_macros::{Display, EnumIter};

#[derive(Clone, Copy, Debug, PartialEq, Eq, Serialize, Deserialize, Hash, Display, EnumIter)]
pub(crate) enum CodecMode {
    Cst,
    Dco,
    Sse,
    Pde,
}

impl CodecMode {
    pub(crate) fn delegate(self) -> Option<Self> {
        match self {
            CodecMode::Pde => Some(CodecMode::Sse),
            _ => None,
        }
    }

    pub(crate) fn delegate_or_self(self) -> Self {
        self.delegate().unwrap_or(self)
    }
}

#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize, Hash)]
pub(crate) struct CodecModePack {
    pub dart2rust: CodecMode,
    pub rust2dart: CodecMode,
}

impl CodecModePack {
    pub(crate) fn all(&self) -> Vec<CodecMode> {
        vec![self.dart2rust, self.rust2dart]
    }
}

#[doc(hidden)]
#[macro_export]
macro_rules! codegen_codec_structs {
    ($partial_name:ident) => (
        $crate::codegen_codec_structs!(
            @private

            $partial_name;

            Cst,
            Dco,
            Sse,
            Pde,
        );
    );
    (@private $partial_name:ident ; $($name:ident),*,) => (
        paste::paste! {
            pub(crate) struct [<$partial_name CodecEntrypoint>]<'a>(
                Box<dyn [<$partial_name CodecEntrypointTrait>]<'a>>
            );

            impl<'a> From<CodecMode> for [<$partial_name CodecEntrypoint>]<'a> {
                fn from(mode: CodecMode) -> Self {
                    match mode {
                        $(
                        CodecMode::$name => Self(Box::new([<$name $partial_name CodecEntrypoint>] {})),
                        )*
                    }
                }
            }

            impl<'a> std::ops::Deref for [<$partial_name CodecEntrypoint>]<'a> {
                type Target = Box<dyn [<$partial_name CodecEntrypointTrait>]<'a>>;

                fn deref(&self) -> &Self::Target {
                    &self.0
                }
            }

            impl<'a> [<$partial_name CodecEntrypoint>]<'a> {
                pub(crate) fn generate_all(
                    context: [<$partial_name GeneratorContext>],
                    cache: &IrPackComputedCache,
                    mode: EncodeOrDecode,
                ) -> [<$partial_name CodecOutputSpec>] {
                    let lang = Lang::[<$partial_name Lang>]([<$partial_name Lang>]);
                    CodecMode::iter()
                        .flat_map(|codec| [<$partial_name CodecEntrypoint>]::from(codec)
                            .generate(context, &get_interest_types_for_codec(cache, codec, lang), mode))
                        .collect()
                }
            }

            #[derive(Clone, Serialize)]
            pub(crate) struct [<$partial_name CodecOutputSpec>] {
                pub(crate) inner: Acc<Vec<[<$partial_name OutputCode>]>>,
            }

            impl std::iter::FromIterator<[<$partial_name CodecOutputSpec>]> for [<$partial_name CodecOutputSpec>] {
                fn from_iter<T: IntoIterator<Item = Self>>(iter: T) -> Self {
                    Self {
                        inner: iter.into_iter().map(|x| x.inner).collect(),
                    }
                }
            }
        }
    )
}

pub(crate) fn get_interest_types_for_codec(
    cache: &IrPackComputedCache,
    codec: CodecMode,
    lang: Lang,
) -> Vec<IrType> {
    match codec {
        CodecMode::Cst => cache.distinct_types_for_codec[&codec].clone(),
        CodecMode::Dco => match lang {
            Lang::DartLang(_) => cache.distinct_types_for_codec[&codec].clone(),
            // Consider all types in Rust, since users may want IntoDart and IntoIntoDart for DartDynamic etc
            Lang::RustLang(_) => cache.distinct_types.clone(),
        },
        // For simplicity, consider all types, since (1) PDE needs SSE (2) non-SSE DartFn still requires SSE
        CodecMode::Sse => cache.distinct_types.clone(),
        CodecMode::Pde => vec![],
    }
}

pub(crate) trait BaseCodecEntrypointTrait<C, O> {
    fn generate(&self, context: C, types: &[IrType], mode: EncodeOrDecode) -> Option<O>;
}

#[derive(Debug, Copy, Clone, PartialEq, Eq)]
pub(crate) enum EncodeOrDecode {
    Encode,
    Decode,
}
