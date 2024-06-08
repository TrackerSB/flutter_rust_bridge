use crate::codegen::generator::api_dart::spec_generator::base::ApiDartGenerator;
use crate::codegen::generator::codec::sse::lang::*;
use crate::codegen::generator::codec::sse::ty::*;
use crate::codegen::ir::mir::ty::delegate::{
    MirTypeDelegatePrimitiveEnum, MirTypeDelegateSet, MirTypeDelegateStreamSink,
    MirTypeDelegateTime,
};
use crate::library::codegen::generator::api_dart::spec_generator::info::ApiDartGeneratorInfoTrait;
use convert_case::{Case, Casing};
use itertools::Itertools;

impl<'a> CodecSseTyTrait for DelegateCodecSseTy<'a> {
    fn generate_encode(&self, lang: &Lang) -> Option<String> {
        let inner_expr = match lang {
            Lang::DartLang(_) => match &self.mir {
                MirTypeDelegate::Array(_) => "self.inner".to_owned(),
                MirTypeDelegate::String => "utf8.encoder.convert(self)".to_owned(),
                MirTypeDelegate::Char => "self".to_owned(),
                MirTypeDelegate::PrimitiveEnum(_) => "self.index".to_owned(),
                MirTypeDelegate::Backtrace => {
                    return Some(format!("{};", lang.throw_unreachable("")));
                }
                MirTypeDelegate::AnyhowException => "self.message".to_owned(),
                MirTypeDelegate::Map(_) => {
                    "self.entries.map((e) => (e.key, e.value)).toList()".to_owned()
                }
                MirTypeDelegate::Set(mir) => {
                    generate_set_to_list(mir, self.context.as_api_dart_context(), "self")
                }
                MirTypeDelegate::Time(mir) => match mir {
                    MirTypeDelegateTime::Utc
                    | MirTypeDelegateTime::Local
                    | MirTypeDelegateTime::NaiveDate
                    | MirTypeDelegateTime::NaiveDateTime => {
                        "PlatformInt64Util.from(self.microsecondsSinceEpoch)".to_owned()
                    }
                    MirTypeDelegateTime::Duration => {
                        "PlatformInt64Util.from(self.inMicroseconds)".to_owned()
                    }
                },
                MirTypeDelegate::Uuid => "self.toBytes()".to_owned(),
                MirTypeDelegate::StreamSink(mir) => {
                    generate_stream_sink_setup_and_serialize(mir, "self")
                }
                MirTypeDelegate::BigPrimitive(_) => "self.toString()".to_owned(),
                MirTypeDelegate::RustAutoOpaqueExplicit(_ir) => "self".to_owned(),
                // MirTypeDelegate::DynTrait(_ir) => lang.throw_unimplemented(""), // TODO
            },
            Lang::RustLang(_) => match &self.mir {
                MirTypeDelegate::Array(_) => {
                    "{ let boxed: Box<[_]> = Box::new(self); boxed.into_vec() }".to_owned()
                }
                MirTypeDelegate::String => "self.into_bytes()".to_owned(),
                MirTypeDelegate::Char => "self.to_string()".to_owned(),
                MirTypeDelegate::PrimitiveEnum(mir) => {
                    let src = mir.mir.get(self.context.mir_pack);
                    let variants = (src.variants.iter().enumerate())
                        .map(|(idx, variant)| {
                            (
                                format!("{}::{}", src.name.rust_style(), variant.name),
                                format!("{idx}"),
                            )
                        })
                        .collect_vec();
                    lang.switch_expr(
                        "self",
                        &variants,
                        Some(format!("{};", lang.throw_unimplemented(""))),
                    )
                }
                MirTypeDelegate::Backtrace => r#"format!("{:?}", self)"#.to_owned(),
                MirTypeDelegate::AnyhowException => r#"format!("{:?}", self)"#.to_owned(),
                MirTypeDelegate::Map(_) => "self.into_iter().collect()".to_owned(),
                MirTypeDelegate::Set(_) => "self.into_iter().collect()".to_owned(),
                MirTypeDelegate::Time(mir) => match mir {
                    MirTypeDelegateTime::Utc | MirTypeDelegateTime::Local => {
                        "self.timestamp_micros()".to_owned()
                    }
                    MirTypeDelegateTime::NaiveDate => "self.and_hms_opt(0, 0, 0).unwrap().and_utc().timestamp_micros()".to_owned(),
                    MirTypeDelegateTime::NaiveDateTime => {
                        "self.and_utc().timestamp_micros()".to_owned()
                    }
                    MirTypeDelegateTime::Duration => {
                        r#"self.num_microseconds().expect("cannot get microseconds from time")"#
                            .to_owned()
                    }
                },
                MirTypeDelegate::Uuid => "self.as_bytes().to_vec()".to_owned(),
                MirTypeDelegate::StreamSink(_) /*| MirTypeDelegate::DynTrait(_)*/ => {
                    return Some(lang.throw_unimplemented(""))
                }
                MirTypeDelegate::BigPrimitive(_) => "self.to_string()".to_owned(),
                MirTypeDelegate::RustAutoOpaqueExplicit(_ir) => {
                    "flutter_rust_bridge::for_generated::rust_auto_opaque_explicit_encode(self)"
                        .to_owned()
                }
            },
        };
        Some(simple_delegate_encode(
            lang,
            &self.mir.get_delegate(),
            &inner_expr,
        ))
    }

    fn generate_decode(&self, lang: &Lang) -> Option<String> {
        let wrapper_expr = match lang {
            Lang::DartLang(_) => {
                match &self.mir {
                    MirTypeDelegate::Array(_) => format!(
                        "{}(inner)",
                        ApiDartGenerator::new(self.mir.clone(), self.context.as_api_dart_context())
                            .dart_api_type()
                    ),
                    MirTypeDelegate::String => "utf8.decoder.convert(inner)".to_owned(),
                    MirTypeDelegate::Char => "inner".to_owned(),
                    MirTypeDelegate::PrimitiveEnum(inner) => {
                        format!(
                            "{}.values[inner]",
                            ApiDartGenerator::new(
                                inner.mir.clone(),
                                self.context.as_api_dart_context()
                            )
                            .dart_api_type()
                        )
                    }
                    MirTypeDelegate::Backtrace => "inner".to_owned(),
                    MirTypeDelegate::AnyhowException => "AnyhowException(inner)".to_owned(),
                    MirTypeDelegate::Map(_) => {
                        "Map.fromEntries(inner.map((e) => MapEntry(e.$1, e.$2)))".to_owned()
                    }
                    MirTypeDelegate::Set(_) => "Set.from(inner)".to_owned(),
                    MirTypeDelegate::Time(mir) => match mir {
                        MirTypeDelegateTime::Utc
                        | MirTypeDelegateTime::Local
                        | MirTypeDelegateTime::NaiveDate
                        | MirTypeDelegateTime::NaiveDateTime => {
                            format!(
                            "DateTime.fromMicrosecondsSinceEpoch(inner.toInt(), isUtc: {is_utc})",
                            is_utc =
                                matches!(mir, MirTypeDelegateTime::NaiveDate | MirTypeDelegateTime::NaiveDateTime | MirTypeDelegateTime::Utc),
                        )
                        }
                        MirTypeDelegateTime::Duration => {
                            "Duration(microseconds: inner.toInt())".to_owned()
                        }
                    },
                    MirTypeDelegate::Uuid => "UuidValue.fromByteList(inner)".to_owned(),
                    MirTypeDelegate::StreamSink(_) => {
                        return Some(format!("{};", lang.throw_unreachable("")));
                    }
                    MirTypeDelegate::BigPrimitive(_) => "BigInt.parse(inner)".to_owned(),
                    MirTypeDelegate::RustAutoOpaqueExplicit(_ir) => "inner".to_owned(),
                    // MirTypeDelegate::DynTrait(_) => return Some(lang.throw_unimplemented("")),
                }
            }
            Lang::RustLang(_) => match &self.mir {
                MirTypeDelegate::Array(_) => {
                    "flutter_rust_bridge::for_generated::from_vec_to_array(inner)".to_owned()
                }
                MirTypeDelegate::String => "String::from_utf8(inner).unwrap()".to_owned(),
                MirTypeDelegate::Char => "inner.chars().next().unwrap()".to_owned(),
                MirTypeDelegate::PrimitiveEnum(inner) => {
                    rust_decode_primitive_enum(inner, self.context.mir_pack, "inner")
                }
                MirTypeDelegate::Backtrace => {
                    return Some(format!("{};", lang.throw_unreachable("")));
                }
                MirTypeDelegate::AnyhowException => {
                    r#"flutter_rust_bridge::for_generated::anyhow::anyhow!("{}", inner)"#.to_owned()
                }
                MirTypeDelegate::Map(_) => "inner.into_iter().collect()".to_owned(),
                MirTypeDelegate::Set(_) => "inner.into_iter().collect()".to_owned(),
                MirTypeDelegate::Time(mir) => {
                    let naive_date_time = "chrono::DateTime::from_timestamp_micros(inner).expect(\"invalid or out-of-range datetime\").naive_utc()";
                    let utc = format!("chrono::DateTime::<chrono::Utc>::from_naive_utc_and_offset({naive_date_time}, chrono::Utc)");
                    let naive_date = format!("{naive_date_time}.date()");
                    match mir {
                        MirTypeDelegateTime::NaiveDate => naive_date.to_owned(),
                        MirTypeDelegateTime::NaiveDateTime => naive_date_time.to_owned(),
                        MirTypeDelegateTime::Utc => utc,
                        MirTypeDelegateTime::Local => {
                            format!("chrono::DateTime::<chrono::Local>::from({utc})")
                        }
                        MirTypeDelegateTime::Duration => {
                            "chrono::Duration::microseconds(inner)".to_owned()
                        }
                    }
                }
                MirTypeDelegate::Uuid => {
                    r#"uuid::Uuid::from_slice(&inner).expect("fail to decode uuid")"#.to_owned()
                }
                MirTypeDelegate::StreamSink(_) => "StreamSink::deserialize(inner)".to_owned(),
                MirTypeDelegate::BigPrimitive(_) => "inner.parse().unwrap()".to_owned(),
                MirTypeDelegate::RustAutoOpaqueExplicit(_ir) => {
                    "flutter_rust_bridge::for_generated::rust_auto_opaque_explicit_decode(inner)"
                        .to_owned()
                } // MirTypeDelegate::DynTrait(_ir) => lang.throw_unimplemented(""), // TODO
            },
        };

        Some(simple_delegate_decode(
            lang,
            &self.mir.get_delegate(),
            &wrapper_expr,
        ))
    }
}

pub(super) fn simple_delegate_encode(lang: &Lang, inner_ty: &MirType, inner_expr: &str) -> String {
    format!("{};", lang.call_encode(inner_ty, inner_expr))
}

pub(super) fn simple_delegate_decode(
    lang: &Lang,
    inner_ty: &MirType,
    wrapper_expr: &str,
) -> String {
    format!(
        "{var_decl} inner = {};
        return {wrapper_expr};",
        lang.call_decode(inner_ty),
        var_decl = lang.var_decl()
    )
}

pub(crate) fn rust_decode_primitive_enum(
    inner: &MirTypeDelegatePrimitiveEnum,
    mir_pack: &MirPack,
    var_name: &str,
) -> String {
    let enu = inner.mir.get(mir_pack);
    let variants = (enu.variants().iter().enumerate())
        .map(|(idx, variant)| format!("{} => {}::{},", idx, enu.name.rust_style(), variant.name))
        .collect_vec()
        .join("\n");

    format!(
        "match {var_name} {{
            {}
            _ => unreachable!(\"Invalid variant for {}: {{}}\", {var_name}),
        }}",
        variants, enu.name.name
    )
}

pub(crate) fn generate_unimplemented_in_sse_message(mir: &MirType) -> String {
    format!("The type {mir:?} is not yet supported in serialized mode, please use full_dep mode, and feel free to create an issue")
}

pub(crate) fn generate_set_to_list(
    mir: &MirTypeDelegateSet,
    context: ApiDartGeneratorContext,
    inner: &str,
) -> String {
    let mut ans = format!("{inner}.toList()");
    if let Primitive(_) = &*mir.inner {
        ans = format!(
            "{}.fromList({ans})",
            ApiDartGenerator::new(
                MirTypeDelegate::Set(mir.to_owned()).get_delegate().clone(),
                context
            )
            .dart_api_type()
        );
    }
    ans
}

pub(crate) fn generate_stream_sink_setup_and_serialize(
    mir: &MirTypeDelegateStreamSink,
    var_name: &str,
) -> String {
    let codec = mir.codec;
    let codec_lower = codec.to_string().to_case(Case::Snake);
    let inner_ty = mir.inner.safe_ident();

    let codec_code = format!(
        "{codec}Codec(decodeSuccessData: {codec_lower}_decode_{inner_ty}, decodeErrorData: null)"
    );

    format!("{var_name}.setupAndSerialize(codec: {codec_code})")
}
