use crate::binary::commands::{GenerateCommandArgs, GenerateCommandArgsPrimary};
use anyhow::{ensure, Context, Result};
use lib_flutter_rust_bridge_codegen::codegen::{Config, MetaConfig};
use log::debug;

pub(crate) fn compute_codegen_config(args: GenerateCommandArgsPrimary) -> Result<Config> {
    if args == Default::default() {
        debug!("compute_codegen_config: mode=from_files_auto");
        return Config::from_files_auto();
    }

    if let Some(config_file) = &args.config_file {
        debug!("compute_codegen_config: mode=config_file");
        ensure!(
            GenerateCommandArgsPrimary {
                config_file: None,
                ..args.clone()
            } == Default::default(),
            // This will stop the whole generator and tell the users, so we do not care about testing it
            // frb-coverage:ignore-start
            "Cannot use command line args and config file at the same time",
            // frb-coverage:ignore-end
        );
        return Config::from_config_file(config_file)?.context("Cannot find config_file");
    }

    debug!("compute_codegen_config: mode=from_naive_generate_command_args");
    ensure!(
        Config::from_files_auto().is_err(),
        // This will stop the whole generator and tell the users, so we do not care about testing it
        // frb-coverage:ignore-start
        "Cannot use command line args and config file at the same time",
        // frb-coverage:ignore-end
    );
    compute_codegen_config_from_naive_command_args(args)
}

pub(crate) fn compute_codegen_meta_config(args: &GenerateCommandArgs) -> MetaConfig {
    MetaConfig { watch: args.watch }
}

fn compute_codegen_config_from_naive_command_args(
    args: GenerateCommandArgsPrimary,
) -> Result<Config> {
    Ok(Config {
        base_dir: None,
        rust_input: args.rust_input.context("rust_input is required")?,
        dart_output: args.dart_output.context("dart_output is required")?,
        c_output: args.c_output,
        duplicated_c_output: args.duplicated_c_output,
        rust_root: args.rust_root,
        rust_output: args.rust_output,
        dart_entrypoint_class_name: args.dart_entrypoint_class_name,
        dart_format_line_length: args.dart_format_line_length,
        dart_preamble: args.dart_preamble,
        dart_enums_style: Some(!args.no_dart_enums_style),
        add_mod_to_lib: Some(!args.no_add_mod_to_lib),
        llvm_path: args.llvm_path,
        llvm_compiler_opts: args.llvm_compiler_opts,
        dart_root: args.dart_root,
        build_runner: Some(!args.no_build_runner),
        extra_headers: args.extra_headers,
        web: Some(!args.no_web),
        deps_check: Some(!args.no_deps_check),
        dart3: Some(!args.no_dart3),
        full_dep: Some(args.full_dep),
        local: Some(args.local),
        default_external_library_loader_web_prefix: args.default_external_library_loader_web_prefix,
        dump: args.dump,
        dump_all: Some(args.dump_all),
    })
}

#[cfg(test)]
mod tests {
    use crate::binary::commands::{Cli, Commands};
    use crate::binary::commands_parser::compute_codegen_config;
    use crate::binary::test_utils::set_cwd_test_fixture;
    use clap::Parser;
    use itertools::concat;
    use lib_flutter_rust_bridge_codegen::utils::logs::configure_opinionated_test_logging;
    use lib_flutter_rust_bridge_codegen::{codegen, if_then_some};
    use serial_test::serial;

    // need to run serially, otherwise working directory will override each other
    #[test]
    #[serial]
    fn test_compute_codegen_config_mode_from_files_auto_flutter_rust_bridge_yaml(
    ) -> anyhow::Result<()> {
        configure_opinionated_test_logging();
        set_cwd_test_fixture("binary/commands_parser/flutter_rust_bridge_yaml")?;

        let config = run_command_line(vec!["", "generate"])?;
        assert_eq!(config.rust_input, "hello.rs".to_string());
        assert!(!config.dart3.unwrap());

        Ok(())
    }

    #[test]
    #[serial]
    fn test_compute_codegen_config_mode_from_files_auto_pubspec_yaml() -> anyhow::Result<()> {
        configure_opinionated_test_logging();
        set_cwd_test_fixture("binary/commands_parser/pubspec_yaml")?;

        let config = run_command_line(vec!["", "generate"])?;
        assert_eq!(config.rust_input, "hello.rs".to_string());
        assert!(!config.dart3.unwrap());

        Ok(())
    }

    #[test]
    #[serial]
    fn test_compute_codegen_config_mode_from_files_auto_pubspec_yaml_faulty() -> anyhow::Result<()>
    {
        configure_opinionated_test_logging();
        set_cwd_test_fixture("binary/commands_parser/faulty_pubspec_yaml")?;

        let result = run_command_line(vec!["", "generate"]);
        assert!(result.is_err());
        assert!(result
            .unwrap_err()
            .source()
            .unwrap()
            .to_string()
            .contains("misspelled_dart3"));

        Ok(())
    }

    #[test]
    #[serial]
    fn test_compute_codegen_config_mode_config_file() -> anyhow::Result<()> {
        configure_opinionated_test_logging();
        set_cwd_test_fixture("binary/commands_parser/config_file")?;

        let config = run_command_line(vec!["", "generate", "--config-file", "hello.yaml"])?;
        assert_eq!(config.rust_input, "hello.rs".to_string());
        assert!(!config.dart3.unwrap());

        Ok(())
    }

    #[test]
    #[serial]
    fn test_compute_codegen_config_mode_config_file_faulty_file() -> anyhow::Result<()> {
        configure_opinionated_test_logging();
        set_cwd_test_fixture("binary/commands_parser/flutter_rust_bridge_yaml")?;
        let result = run_command_line(vec![
            "",
            "generate",
            "--config-file",
            "faulty_flutter_rust_bridge.yaml",
        ]);
        assert!(result.is_err());
        assert!(result
            .unwrap_err()
            .source()
            .unwrap()
            .to_string()
            .contains("misspelled_dart3"));
        Ok(())
    }

    #[test]
    #[serial]
    fn test_compute_codegen_config_mode_from_naive_generate_command_args() {
        configure_opinionated_test_logging();
        set_cwd_test_fixture("binary/commands_parser").unwrap(); // use whatever folder without config file

        // bool flags
        let common_args = vec![
            "",
            "generate",
            "--rust-input",
            "hello.rs",
            "--dart-output",
            "hello.dart",
            "--c-output",
            "hello.h",
        ];
        let config = run_command_line(common_args.clone()).expect("failed to parse cli args");
        assert_eq!(config.dart3, Some(true));
        assert_eq!(config.rust_input, "hello.rs".to_string());
        assert_eq!(
            run_command_line(concat([common_args.clone(), vec!["--no-dart3"]]))
                .expect("failed to parse cli args")
                .dart3,
            Some(false)
        );
    }

    fn run_command_line(args: Vec<&'static str>) -> anyhow::Result<codegen::Config> {
        let cli = Cli::parse_from(args);
        let args = if_then_some!(let Commands::Generate(args) = cli.command, args).unwrap();
        compute_codegen_config(args.primary)
    }
}
