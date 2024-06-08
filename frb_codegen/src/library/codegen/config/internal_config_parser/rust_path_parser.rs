use crate::codegen::config::internal_config_parser::dart_path_parser::compute_path_map;
use crate::codegen::config::internal_config_parser::rust_path_migrator::ConfigRustRootAndRustInput;
use crate::codegen::generator::misc::target::TargetOrCommonMap;
use crate::codegen::parser::mir::internal_config::RustInputNamespacePack;
use crate::utils::crate_name::CrateName;
use crate::utils::namespace::Namespace;
use crate::utils::path_utils::canonicalize_with_error_message;
use anyhow::Context;
use itertools::Itertools;
use std::path::{Path, PathBuf};

pub(super) struct RustInputInfo {
    pub rust_crate_dir: PathBuf,
    pub third_party_crate_names: Vec<CrateName>,
    pub rust_input_namespace_pack: RustInputNamespacePack,
    pub rust_output_path: TargetOrCommonMap<PathBuf>,
}

pub(super) fn compute_rust_path_info(
    migrated_rust_input: &ConfigRustRootAndRustInput,
    base_dir: &Path,
    config_rust_output: &Option<String>,
) -> anyhow::Result<RustInputInfo> {
    let rust_input_namespace_prefixes_raw =
        compute_rust_input_namespace_prefixes_raw(&migrated_rust_input.rust_input);
    let rust_crate_dir = compute_rust_crate_dir(base_dir, &migrated_rust_input.rust_root)?;
    let rust_output_path = compute_rust_output_path(config_rust_output, base_dir, &rust_crate_dir)?;

    let rust_output_path_namespace =
        Namespace::new_from_rust_crate_path(&rust_output_path.common, &rust_crate_dir)?;

    Ok(RustInputInfo {
        rust_crate_dir,
        third_party_crate_names: compute_third_party_crate_names(
            &rust_input_namespace_prefixes_raw,
        ),
        rust_input_namespace_pack: RustInputNamespacePack {
            rust_input_namespace_prefixes: tidy_rust_input_namespace_prefixes(
                &rust_input_namespace_prefixes_raw,
            ),
            early_skip_namespace_prefixes: vec![rust_output_path_namespace],
        },
        rust_output_path,
    })
}

fn compute_rust_input_namespace_prefixes_raw(raw_rust_input: &str) -> Vec<Namespace> {
    raw_rust_input
        .split(',')
        .map(|s| Namespace::new_raw(s.to_owned()))
        .collect_vec()
}

fn tidy_rust_input_namespace_prefixes(raw: &[Namespace]) -> Vec<Namespace> {
    raw.iter()
        .map(|x| Namespace::new_raw(x.joined_path.replace('-', "_")))
        .collect_vec()
}

fn compute_rust_crate_dir(base_dir: &Path, rust_root: &str) -> anyhow::Result<PathBuf> {
    canonicalize_with_error_message(&base_dir.join(rust_root))
}

fn compute_rust_output_path(
    config_rust_output: &Option<String>,
    base_dir: &Path,
    rust_crate_dir: &Path,
) -> anyhow::Result<TargetOrCommonMap<PathBuf>> {
    let path_common = base_dir.join(
        (config_rust_output.clone().map(PathBuf::from))
            .unwrap_or_else(|| fallback_rust_output_path(rust_crate_dir)),
    );
    compute_path_map(&path_common).context("rust_output: is wrong: ")
}

fn fallback_rust_output_path(rust_crate_dir: &Path) -> PathBuf {
    rust_crate_dir.join("src").join("frb_generated.rs")
}

fn compute_third_party_crate_names(
    rust_input_namespace_prefixes_raw: &[Namespace],
) -> Vec<CrateName> {
    rust_input_namespace_prefixes_raw
        .iter()
        .map(|x| x.path()[0])
        .filter(|x| *x != CrateName::SELF_CRATE)
        .dedup()
        .sorted()
        .map(|x| CrateName::new(x.to_owned()))
        .collect_vec()
}
