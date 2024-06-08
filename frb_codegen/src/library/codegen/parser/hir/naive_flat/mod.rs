use crate::codegen::dumper::Dumper;
use crate::codegen::ir::hir::naive_flat::pack::HirNaiveFlatPack;
use crate::codegen::ir::hir::tree::pack::HirTreePack;
use crate::codegen::parser::hir::internal_config::ParserHirInternalConfig;
use crate::codegen::ConfigDumpContent::Hir;

pub(crate) mod parser;
pub(crate) mod transformer;

pub(crate) fn parse(
    config: &ParserHirInternalConfig,
    hir_tree: HirTreePack,
    dumper: &Dumper,
) -> anyhow::Result<HirNaiveFlatPack> {
    let pack = parser::parse(hir_tree)?;
    dump(dumper, "1_parse_pack", &pack)?;

    let pack = transformer::move_third_party_override_transformer::transform(pack)?;
    dump(dumper, "2_move_third_party_override_transformer", &pack)?;

    let pack = transformer::filter_transformer::transform(pack, config)?;
    dump(dumper, "3_filter_transformer", &pack)?;

    Ok(pack)
}

fn dump(dumper: &Dumper, name: &str, pack: &HirNaiveFlatPack) -> anyhow::Result<()> {
    dumper.dump(Hir, &format!("hir_naive_flat/{name}.json"), pack)
}
