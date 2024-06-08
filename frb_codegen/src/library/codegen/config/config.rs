use crate::codegen::dumper::internal_config::ConfigDumpContent;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

/// Configuration for code generation
/// Refer to `GenerateCommandArgs` for documentations
#[derive(Debug, Serialize, Deserialize)]
#[serde(deny_unknown_fields)]
pub struct Config {
    pub base_dir: Option<String>,
    pub rust_input: String,
    pub dart_output: String,
    pub c_output: Option<String>,
    pub duplicated_c_output: Option<Vec<String>>,
    pub rust_root: Option<String>,
    pub rust_output: Option<String>,
    pub dart_entrypoint_class_name: Option<String>,
    pub dart_format_line_length: Option<u32>,
    pub dart_preamble: Option<String>,
    pub dart_enums_style: Option<bool>,
    pub add_mod_to_lib: Option<bool>,
    pub llvm_path: Option<Vec<String>>,
    pub llvm_compiler_opts: Option<String>,
    pub dart_root: Option<String>,
    pub build_runner: Option<bool>,
    pub extra_headers: Option<String>,
    pub web: Option<bool>,
    pub deps_check: Option<bool>,
    pub dart3: Option<bool>,
    pub full_dep: Option<bool>,
    pub local: Option<bool>,
    pub default_external_library_loader_web_prefix: Option<String>,
    pub dart_type_rename: Option<HashMap<String, String>>,
    pub stop_on_error: Option<bool>,
    pub dump: Option<Vec<ConfigDumpContent>>,
    pub dump_all: Option<bool>,
}

#[derive(Debug, Serialize, Deserialize, Default)]
pub struct MetaConfig {
    pub watch: bool,
}
