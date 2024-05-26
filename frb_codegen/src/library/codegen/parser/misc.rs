use crate::codegen::ir::namespace::{Namespace, NamespacedName};
use crate::codegen::parser::source_graph::modules::StructOrEnumWrapper;
use crate::library::misc::consts::HANDLER_NAME;
use itertools::Itertools;
use std::collections::HashMap;
use std::path::{Path, PathBuf};

pub(crate) fn parse_has_executor(source_rust_content: &str) -> bool {
    source_rust_content.contains(&format!("static {HANDLER_NAME}"))
}

pub(crate) fn extract_src_types_in_paths<T: StructOrEnumWrapper<I>, I>(
    src_items: &HashMap<String, &T>,
    rust_input_paths: &[PathBuf],
    rust_crate_dir: &Path,
) -> anyhow::Result<Vec<NamespacedName>> {
    let interest_input_paths = (rust_input_paths.iter())
        .map(|p| Namespace::new_from_rust_crate_path(p, rust_crate_dir))
        .collect::<anyhow::Result<Vec<_>>>()?;

    Ok((src_items.iter())
        .filter_map(|(k, v)| {
            let namespace = v.inner().namespace();
            if interest_input_paths.contains(&namespace) {
                Some(NamespacedName::new(namespace, k.to_owned()))
            } else {
                None
            }
        })
        .collect_vec())
}
