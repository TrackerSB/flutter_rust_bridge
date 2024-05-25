use crate::codegen::generator::wire::dart::spec_generator::codec::dco::base::*;
use crate::codegen::generator::wire::dart::spec_generator::codec::dco::decoder::misc::gen_decode_simple_type_cast;
use crate::codegen::generator::wire::dart::spec_generator::codec::dco::decoder::ty::WireDartCodecDcoGeneratorDecoderTrait;
use crate::codegen::ir::ty::delegate::{
    IrTypeDelegate, IrTypeDelegateArrayMode, IrTypeDelegatePrimitiveEnum, IrTypeDelegateTime,
};
use crate::library::codegen::generator::api_dart::spec_generator::base::ApiDartGenerator;
use crate::library::codegen::generator::api_dart::spec_generator::info::ApiDartGeneratorInfoTrait;
use crate::library::codegen::ir::ty::IrTypeTrait;

impl<'a> WireDartCodecDcoGeneratorDecoderTrait for DelegateWireDartCodecDcoGenerator<'a> {
    fn generate_impl_decode_body(&self) -> String {
        match &self.ir {
            IrTypeDelegate::Array(array) => match &array.mode {
                IrTypeDelegateArrayMode::General(general) => format!(
                    r"return {}((raw as List<dynamic>).map(dco_decode_{}).toList());",
                    ApiDartGenerator::new(self.ir.clone(), self.context.as_api_dart_context())
                        .dart_api_type(),
                    general.safe_ident(),
                ),
                IrTypeDelegateArrayMode::Primitive(_) => format!(
                    r"return {}(dco_decode_{}(raw));",
                    ApiDartGenerator::new(self.ir.clone(), self.context.as_api_dart_context())
                        .dart_api_type(),
                    array.get_delegate().safe_ident(),
                ),
            },

            // IrTypeDelegate::ZeroCopyBufferVecPrimitive(
            //     IrTypePrimitive::I64 | IrTypePrimitive::U64,
            // ) => {
            //     format!(
            //         "return dco_decode_{}(raw);",
            //         self.ir.get_delegate().safe_ident()
            //     )
            // }
            IrTypeDelegate::String
            | IrTypeDelegate::Backtrace
            /*| IrTypeDelegate::ZeroCopyBufferVecPrimitive(_)*/ => {
                gen_decode_simple_type_cast(self.ir.clone().into(), self.context)
            }
            IrTypeDelegate::Char => {
                "return String.fromCharCode(raw);".to_owned()
            }
            // IrTypeDelegate::StringList => {
            //     "return (raw as List<dynamic>).cast<String>();".to_owned()
            // }
            IrTypeDelegate::PrimitiveEnum(IrTypeDelegatePrimitiveEnum { ir, .. }) => {
                format!(
                    "return {}.values[raw as int];",
                    ApiDartGenerator::new(ir.clone(), self.context.as_api_dart_context())
                        .dart_api_type()
                ) // here `as int` is neccessary in strict dynamic mode
            }
            IrTypeDelegate::Time(ir) => {
                if ir == &IrTypeDelegateTime::Duration {
                    "return dcoDecodeDuration(dco_decode_i_64(raw).toInt());".to_owned()
                } else {
                    format!(
                        "return dcoDecodeTimestamp(ts: dco_decode_i_64(raw).toInt(), isUtc: {is_utc});",
                        is_utc = matches!(ir, IrTypeDelegateTime::NaiveDate | IrTypeDelegateTime::NaiveDateTime | IrTypeDelegateTime::Utc)
                    )
                }
            }
            // IrTypeDelegate::TimeList(t) => {
            //     format!(
            //         "return (raw as List<dynamic>).map(dco_decode_{}).toList();",
            //         IrTypeDelegate::Time(*t).safe_ident()
            //     )
            // }
            IrTypeDelegate::Uuid => {
                "return UuidValue.fromByteList(dco_decode_list_prim_u_8_strict(raw));".to_owned()
            }
            // IrTypeDelegate::Uuids => ...,
            IrTypeDelegate::AnyhowException => "return AnyhowException(raw as String);".to_owned(),
            IrTypeDelegate::Map(_) => format!(
                "return Map.fromEntries(dco_decode_{}(raw).map((e) => MapEntry(e.$1, e.$2)));",
                self.ir.get_delegate().safe_ident(),
            ),
            IrTypeDelegate::Set(_) => format!(
                "return Set.from(dco_decode_{}(raw));",
                self.ir.get_delegate().safe_ident(),
            ),
            IrTypeDelegate::StreamSink(_) => "throw UnimplementedError();".to_owned(),
            IrTypeDelegate::BigPrimitive(_) => {
                "return BigInt.parse(raw);".to_owned()
            }
            IrTypeDelegate::RustAutoOpaqueExplicit(ir) => format!(r"return dco_decode_{}(raw);", ir.inner.safe_ident())
        }
    }
}
