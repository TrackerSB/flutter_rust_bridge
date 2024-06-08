use crate::codegen::ir::mir::ty::delegate::{MirTypeDelegate, MirTypeDelegateBigPrimitive};
use crate::codegen::ir::mir::ty::primitive::MirTypePrimitive;
use crate::codegen::ir::mir::ty::MirType;
use crate::codegen::ir::mir::ty::MirType::Primitive;
use crate::codegen::parser::mir::parser::ty::unencodable::SplayedSegment;
use crate::codegen::parser::mir::parser::ty::TypeParserWithContext;

impl<'a, 'b, 'c> TypeParserWithContext<'a, 'b, 'c> {
    pub(crate) fn parse_type_path_data_primitive(
        &mut self,
        last_segment: &SplayedSegment,
    ) -> anyhow::Result<Option<MirType>> {
        Ok(Some(match last_segment {
            // TODO: change to "if let guard" https://github.com/rust-lang/rust/issues/51114
            (name, []) if matches!(parse_primitive(name), Some(..)) => {
                Primitive(parse_primitive(name).unwrap())
            }
            (name, []) if matches!(parse_big_primitive(name), Some(..)) => {
                parse_big_primitive(name).unwrap()
            }

            _ => return Ok(None),
        }))
    }
}

fn parse_primitive(s: &str) -> Option<MirTypePrimitive> {
    Some(match s {
        "u8" => MirTypePrimitive::U8,
        "i8" => MirTypePrimitive::I8,
        "u16" => MirTypePrimitive::U16,
        "i16" => MirTypePrimitive::I16,
        "u32" => MirTypePrimitive::U32,
        "i32" => MirTypePrimitive::I32,
        "u64" => MirTypePrimitive::U64,
        "i64" => MirTypePrimitive::I64,
        "f32" => MirTypePrimitive::F32,
        "f64" => MirTypePrimitive::F64,
        "bool" => MirTypePrimitive::Bool,
        "()" => MirTypePrimitive::Unit,
        "usize" => MirTypePrimitive::Usize,
        "isize" => MirTypePrimitive::Isize,
        _ => return None,
    })
}

fn parse_big_primitive(s: &str) -> Option<MirType> {
    Some(MirType::Delegate(MirTypeDelegate::BigPrimitive(match s {
        "i128" => MirTypeDelegateBigPrimitive::I128,
        "u128" => MirTypeDelegateBigPrimitive::U128,
        _ => return None,
    })))
}
