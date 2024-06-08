use crate::codegen::config::internal_config::ControllerInternalConfig;
use crate::codegen::generator::misc::target::TargetOrCommonMap;
use crate::codegen::MetaConfig;
use std::path::{Path, PathBuf};

pub(super) fn parse(
    meta_config: &MetaConfig,
    rust_crate_dir: &Path,
    rust_output_path: &TargetOrCommonMap<PathBuf>,
) -> anyhow::Result<ControllerInternalConfig> {
    let watching_paths = vec![
        // The whole crate needs to be watched, because e.g. when a struct definition changes
        // in a non-input file, it may still cause the generated code to change.
        rust_crate_dir.join("src"),
    ];
    let exclude_paths = rust_output_path.clone().into_vec();

    Ok(ControllerInternalConfig {
        watch: meta_config.watch,
        watching_paths,
        exclude_paths,
        max_count: None,
    })
}
