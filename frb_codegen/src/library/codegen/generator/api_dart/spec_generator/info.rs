use crate::codegen::generator::api_dart::spec_generator::base::*;
use crate::codegen::ir::ty::delegate::{
    IrTypeDelegate, IrTypeDelegateArray, IrTypeDelegateArrayMode, IrTypeDelegatePrimitiveEnum,
    IrTypeDelegateTime,
};
use crate::codegen::ir::ty::general_list::IrTypeGeneralList;
use crate::codegen::ir::ty::primitive::IrTypePrimitive;
use crate::codegen::ir::ty::{IrType, IrTypeTrait};
use convert_case::{Case, Casing};
use enum_dispatch::enum_dispatch;
use itertools::Itertools;

#[enum_dispatch]
pub(crate) trait ApiDartGeneratorInfoTrait {
    fn dart_api_type(&self) -> String;

    fn dart_import(&self) -> Option<String> {
        None
    }
}

impl<'a> ApiDartGeneratorInfoTrait for BoxedApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        let inner = ApiDartGenerator::new(self.ir.inner.clone(), self.context);
        inner.dart_api_type()
    }
}

impl<'a> ApiDartGeneratorInfoTrait for DartFnApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        format!(
            "FutureOr<{}> Function({})",
            ApiDartGenerator::new(self.ir.output.clone(), self.context).dart_api_type(),
            (self.ir.inputs.iter())
                .map(|x| ApiDartGenerator::new(x.clone(), self.context).dart_api_type())
                .join(", "),
        )
    }
}

impl<'a> ApiDartGeneratorInfoTrait for DartOpaqueApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        "Object".to_owned()
    }
}

impl<'a> ApiDartGeneratorInfoTrait for DelegateApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        match &self.ir {
            IrTypeDelegate::Array(array) => array.dart_api_type(self.context),
            IrTypeDelegate::String => "String".to_string(),
            // IrTypeDelegate::StringList => "List<String>".to_owned(),
            // IrTypeDelegate::ZeroCopyBufferVecPrimitive(_) => {
            //     ApiDartGenerator::new(self.ir.get_delegate(), self.context).dart_api_type()
            // }
            IrTypeDelegate::PrimitiveEnum(IrTypeDelegatePrimitiveEnum { ir, .. }) => {
                ApiDartGenerator::new(IrType::EnumRef(ir.clone()), self.context).dart_api_type()
            }
            IrTypeDelegate::Time(ir) => match ir {
                IrTypeDelegateTime::Local
                | IrTypeDelegateTime::Utc
                | IrTypeDelegateTime::NaiveDate
                | IrTypeDelegateTime::NaiveDateTime => "DateTime".to_string(),
                IrTypeDelegateTime::Duration => "Duration".to_string(),
            },
            // IrTypeDelegate::TimeList(
            //     IrTypeDelegateTime::Local | IrTypeDelegateTime::Utc | IrTypeDelegateTime::Naive,
            // ) => "List<DateTime>".to_string(),
            // IrTypeDelegate::TimeList(IrTypeDelegateTime::Duration) => "List<Duration>".to_string(),
            IrTypeDelegate::Uuid => "UuidValue".to_owned(),
            // IrTypeDelegate::Uuids => "List<UuidValue>".to_owned(),
            IrTypeDelegate::Backtrace => "String".to_string(),
            IrTypeDelegate::AnyhowException => "AnyhowException".to_string(),
            IrTypeDelegate::Map(ir) => format!(
                "Map<{}, {}>",
                ApiDartGenerator::new(*ir.key.clone(), self.context).dart_api_type(),
                ApiDartGenerator::new(*ir.value.clone(), self.context).dart_api_type(),
            ),
            IrTypeDelegate::Set(ir) => format!(
                "Set<{}>",
                ApiDartGenerator::new(*ir.inner.clone(), self.context).dart_api_type(),
            ),
            IrTypeDelegate::StreamSink(ir) => format!(
                "RustStreamSink<{}>",
                ApiDartGenerator::new(*ir.inner.clone(), self.context).dart_api_type(),
            ),
        }
    }

    fn dart_import(&self) -> Option<String> {
        match &self.ir {
            IrTypeDelegate::Uuid /*| IrTypeDelegate::Uuids*/ => {
                Some("import 'package:uuid/uuid.dart';".to_owned())
            }
            _ => None,
        }
    }
}

impl IrTypeDelegateArray {
    pub(crate) fn dart_api_type(&self, context: ApiDartGeneratorContext) -> String {
        let length = self.length;
        match &self.mode {
            IrTypeDelegateArrayMode::General(general) => {
                format!(
                    "{}Array{length}",
                    ApiDartGenerator::new(general.clone(), context).dart_api_type()
                )
            }
            IrTypeDelegateArrayMode::Primitive(primitive) => {
                format!(
                    "{}Array{length}",
                    primitive.safe_ident().to_case(Case::Pascal)
                )
            }
        }
    }
}

impl<'a> ApiDartGeneratorInfoTrait for DynamicApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        "dynamic".to_owned()
    }
}

impl<'a> ApiDartGeneratorInfoTrait for EnumRefApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        self.ir.ident.0.name.to_string()
    }
}

impl<'a> ApiDartGeneratorInfoTrait for GeneralListApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        let inner = ApiDartGenerator::new(self.ir.inner.clone(), self.context);
        format!("List<{}>", inner.dart_api_type())
    }
}

impl<'a> ApiDartGeneratorInfoTrait for OptionalApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        let inner = ApiDartGenerator::new(self.ir.inner.clone(), self.context);
        format!("{}?", inner.dart_api_type())
    }
}

impl<'a> ApiDartGeneratorInfoTrait for PrimitiveApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        match &self.ir {
            IrTypePrimitive::U8
            | IrTypePrimitive::I8
            | IrTypePrimitive::U16
            | IrTypePrimitive::I16
            | IrTypePrimitive::U32
            | IrTypePrimitive::I32
            | IrTypePrimitive::Usize
            | IrTypePrimitive::Isize
            | IrTypePrimitive::U64
            | IrTypePrimitive::I64 => "int",
            IrTypePrimitive::F32 | IrTypePrimitive::F64 => "double",
            IrTypePrimitive::Bool => "bool",
            IrTypePrimitive::Unit => "void",
        }
        .to_owned()
    }
}

impl<'a> ApiDartGeneratorInfoTrait for PrimitiveListApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        if self.ir.strict_dart_type {
            match &self.ir.primitive {
                IrTypePrimitive::U8 => "Uint8List",
                IrTypePrimitive::I8 => "Int8List",
                IrTypePrimitive::U16 => "Uint16List",
                IrTypePrimitive::I16 => "Int16List",
                IrTypePrimitive::U32 => "Uint32List",
                IrTypePrimitive::I32 => "Int32List",
                IrTypePrimitive::U64 => "Uint64List",
                IrTypePrimitive::I64 => "Int64List",
                IrTypePrimitive::F32 => "Float32List",
                IrTypePrimitive::F64 => "Float64List",
                // frb-coverage:ignore-start
                _ => panic!("does not support {:?} yet", &self.ir.primitive),
                // frb-coverage:ignore-end
            }
            .to_string()
        } else {
            ApiDartGenerator::new(
                IrTypeGeneralList {
                    inner: Box::new(IrType::Primitive(self.ir.primitive.clone())),
                },
                self.context,
            )
            .dart_api_type()
        }
    }
}

impl<'a> ApiDartGeneratorInfoTrait for RecordApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        let values = (self.ir.values.iter())
            .map(|ty| ApiDartGenerator::new(ty.clone(), self.context).dart_api_type())
            .collect_vec()
            .join(",");
        let extra_comma = if self.ir.values.len() == 1 { "," } else { "" };
        format!("({values}{extra_comma})")
    }
}

impl<'a> ApiDartGeneratorInfoTrait for RustAutoOpaqueApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        let inner = ApiDartGenerator::new(self.ir.inner.clone(), self.context);
        inner.dart_api_type()
    }
}

impl<'a> ApiDartGeneratorInfoTrait for RustOpaqueApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        self.ir.sanitized_type()
    }
}

impl<'a> ApiDartGeneratorInfoTrait for StructRefApiDartGenerator<'a> {
    fn dart_api_type(&self) -> String {
        self.ir.ident.0.name.to_string()
    }

    fn dart_import(&self) -> Option<String> {
        let st = self.ir.get(self.context.ir_pack);
        Some(
            st.dart_metadata
                .iter()
                .flat_map(|it| &it.library)
                .map(|it| it.to_code())
                .join("\n"),
        )
    }
}
