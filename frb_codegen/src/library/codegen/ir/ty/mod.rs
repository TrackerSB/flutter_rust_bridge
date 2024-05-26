pub(crate) mod boxed;
pub(crate) mod dart_fn;
pub(crate) mod dart_opaque;
pub(crate) mod delegate;
pub(crate) mod dynamic;
pub(crate) mod enumeration;
pub(crate) mod general_list;
pub(crate) mod optional;
pub(crate) mod primitive;
pub(crate) mod primitive_list;
pub(crate) mod record;
pub(crate) mod rust_auto_opaque_implicit;
pub(crate) mod rust_opaque;
pub(crate) mod structure;

use crate::codegen::ir::namespace::Namespace;
use crate::codegen::ir::pack::{IrEnumPool, IrPack, IrStructPool};
use crate::codegen::ir::ty::delegate::IrTypeDelegate;
use crate::codegen::ir::ty::primitive::IrTypePrimitive;
use enum_dispatch::enum_dispatch;
use serde::ser::SerializeStruct;
use serde::{Serialize, Serializer};

crate::ir! {
#[no_serde]
// Remark: "Ty" instead of "Type", since "type" is a reserved word in Rust.
#[enum_dispatch(IrTypeTrait)]
pub enum IrType {
    // alphabetical order
    Boxed(boxed::IrTypeBoxed),
    DartFn(dart_fn::IrTypeDartFn),
    DartOpaque(dart_opaque::IrTypeDartOpaque),
    Delegate(delegate::IrTypeDelegate),
    Dynamic(dynamic::IrTypeDynamic),
    EnumRef(enumeration::IrTypeEnumRef),
    GeneralList(general_list::IrTypeGeneralList),
    Optional(optional::IrTypeOptional),
    Primitive(primitive::IrTypePrimitive),
    PrimitiveList(primitive_list::IrTypePrimitiveList),
    Record(record::IrTypeRecord),
    RustAutoOpaqueImplicit(rust_auto_opaque_implicit::IrTypeRustAutoOpaqueImplicit),
    RustOpaque(rust_opaque::IrTypeRustOpaque),
    StructRef(structure::IrTypeStructRef),
}
}

impl IrType {
    pub fn visit_types<F: FnMut(&IrType) -> bool>(&self, f: &mut F, ir_context: &impl IrContext) {
        if f(self) {
            return;
        }
        self.visit_children_types(f, ir_context);
    }

    #[inline]
    pub fn is_struct_or_enum_or_record(&self) -> bool {
        matches!(
            self,
            IrType::StructRef(_) | IrType::EnumRef(_) | IrType::Record(_)
        )
    }

    #[inline]
    pub fn is_primitive(&self) -> bool {
        self.as_primitive().is_some()
    }

    #[inline]
    pub fn is_array(&self) -> bool {
        matches!(self, IrType::Delegate(IrTypeDelegate::Array(_)))
    }
}

#[enum_dispatch]
pub trait IrTypeTrait {
    fn visit_children_types<F: FnMut(&IrType) -> bool>(
        &self,
        f: &mut F,
        ir_context: &impl IrContext,
    );

    /// A string that can be used as an identifier safely, i.e. without any special characters inside
    fn safe_ident(&self) -> String;

    /// Why `rust_api_type` is in `ir` while `dart_api_type` is in `generator::api_dart` -
    /// Because the former is intrinsic information of a parsed Rust type, while the latter is
    /// part of the code to be generated.
    fn rust_api_type(&self) -> String;

    #[inline]
    fn as_primitive(&self) -> Option<&IrTypePrimitive> {
        None
    }

    fn self_namespace(&self) -> Option<Namespace> {
        None
    }

    // TODO move
    fn cloned_getter_semantics_reasonable(&self) -> bool {
        false
    }
}

impl From<Box<IrType>> for IrType {
    fn from(val: Box<IrType>) -> Self {
        *val
    }
}

impl Serialize for IrType {
    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: Serializer,
    {
        let len = 3;
        let mut state = serializer.serialize_struct("IrType", len)?;

        fn ser<S: Serializer, T: Serialize + IrTypeTrait>(
            state: &mut <S as Serializer>::SerializeStruct,
            ty: &str,
            data: &T,
        ) -> Result<(), S::Error> {
            state.serialize_field("type", ty)?;
            state.serialize_field("safe_ident", &data.safe_ident())?;
            state.serialize_field("data", data)?;
            Ok(())
        }
        match self {
            IrType::Boxed(inner) => ser::<S, _>(&mut state, "Boxed", inner),
            IrType::DartFn(inner) => ser::<S, _>(&mut state, "DartFn", inner),
            IrType::DartOpaque(inner) => ser::<S, _>(&mut state, "DartOpaque", inner),
            IrType::Delegate(inner) => ser::<S, _>(&mut state, "Delegate", inner),
            IrType::Dynamic(inner) => ser::<S, _>(&mut state, "Dynamic", inner),
            IrType::EnumRef(inner) => ser::<S, _>(&mut state, "EnumRef", inner),
            IrType::GeneralList(inner) => ser::<S, _>(&mut state, "GeneralList", inner),
            IrType::Optional(inner) => ser::<S, _>(&mut state, "Optional", inner),
            IrType::Primitive(inner) => ser::<S, _>(&mut state, "Primitive", inner),
            IrType::PrimitiveList(inner) => ser::<S, _>(&mut state, "PrimitiveList", inner),
            IrType::Record(inner) => ser::<S, _>(&mut state, "Record", inner),
            IrType::RustAutoOpaqueImplicit(inner) => {
                ser::<S, _>(&mut state, "RustAutoOpaque", inner)
            }
            IrType::RustOpaque(inner) => ser::<S, _>(&mut state, "RustOpaque", inner),
            IrType::StructRef(inner) => ser::<S, _>(&mut state, "StructRef", inner),
        }?;

        state.end()
    }
}

pub(crate) trait IrContext {
    fn struct_pool(&self) -> &IrStructPool;

    fn enum_pool(&self) -> &IrEnumPool;
}

impl IrContext for IrPack {
    fn struct_pool(&self) -> &IrStructPool {
        &self.struct_pool
    }

    fn enum_pool(&self) -> &IrEnumPool {
        &self.enum_pool
    }
}
