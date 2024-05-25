use crate::codegen::generator::acc::Acc;
use crate::codegen::generator::misc::target::Target;
use crate::codegen::generator::wire::dart::spec_generator::codec::cst::base::*;
use crate::codegen::generator::wire::dart::spec_generator::codec::cst::encoder::ty::WireDartCodecCstGeneratorEncoderTrait;
use crate::codegen::ir::ty::primitive::IrTypePrimitive;
use crate::library::codegen::generator::api_dart::spec_generator::base::ApiDartGenerator;
use crate::library::codegen::generator::api_dart::spec_generator::info::ApiDartGeneratorInfoTrait;

impl<'a> WireDartCodecCstGeneratorEncoderTrait for PrimitiveWireDartCodecCstGenerator<'a> {
    fn generate_encode_func_body(&self) -> Acc<Option<String>> {
        match self.ir {
            IrTypePrimitive::I64 | IrTypePrimitive::Isize => Acc {
                io: Some("return raw.toInt();".into()),
                web: Some(CAST_NATIVE_BIG_INT.into()),
                ..Default::default()
            },
            IrTypePrimitive::U64 | IrTypePrimitive::Usize => Acc {
                io: Some("return raw.toSigned(64).toInt();".into()),
                web: Some(CAST_NATIVE_BIG_INT.into()),
                ..Default::default()
            },
            _ => "return raw;".into(),
        }
    }

    fn dart_wire_type(&self, target: Target) -> String {
        match &self.ir {
            IrTypePrimitive::I64
            | IrTypePrimitive::U64
            | IrTypePrimitive::Isize
            | IrTypePrimitive::Usize => match target {
                Target::Io => "int".into(),
                Target::Web => "Object".into(),
            },
            _ => ApiDartGenerator::new(self.ir.clone(), self.context.as_api_dart_context())
                .dart_api_type(),
        }
    }
}

const CAST_NATIVE_BIG_INT: &str = "return castNativeBigInt(raw);";

/// Representations of primitives within Dart's pointers, e.g. `ffi.Pointer<ffi.Uint8>`.
/// This is enforced on Dart's side, and should be used instead of `dart_wire_type`
/// whenever primitives are put behind a pointer.
pub fn dart_native_type_of_primitive(prim: &IrTypePrimitive) -> &'static str {
    match prim {
        IrTypePrimitive::U8 => "ffi.Uint8",
        IrTypePrimitive::I8 => "ffi.Int8",
        IrTypePrimitive::U16 => "ffi.Uint16",
        IrTypePrimitive::I16 => "ffi.Int16",
        IrTypePrimitive::U32 => "ffi.Uint32",
        IrTypePrimitive::I32 => "ffi.Int32",
        IrTypePrimitive::U64 => "ffi.Uint64",
        IrTypePrimitive::I64 => "ffi.Int64",
        IrTypePrimitive::Usize => "ffi.UintPtr",
        IrTypePrimitive::Isize => "ffi.IntPtr",
        IrTypePrimitive::F32 => "ffi.Float",
        IrTypePrimitive::F64 => "ffi.Double",
        IrTypePrimitive::Bool => "ffi.Bool",
        IrTypePrimitive::Unit => "ffi.Void",
    }
}
