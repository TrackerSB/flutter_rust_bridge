// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.37.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

HideDataAnotherTwinMoi? syncOptionRustOpaqueTwinMoi() => RustLib.instance.api
    .crateApiPseudoManualRustOpaqueSyncTwinMoiSyncOptionRustOpaqueTwinMoi();

HideDataAnotherTwinMoi syncCreateOpaqueTwinMoi() => RustLib.instance.api
    .crateApiPseudoManualRustOpaqueSyncTwinMoiSyncCreateOpaqueTwinMoi();

NonCloneDataTwinMoi syncCreateNonCloneTwinMoi() => RustLib.instance.api
    .crateApiPseudoManualRustOpaqueSyncTwinMoiSyncCreateNonCloneTwinMoi();

/// Structure for testing the sync-mode RustOpaque code generator.
/// FrbOpaqueSyncReturn must be only return type.
/// FrbOpaqueSyncReturn must be without wrapper like Option<> Vec<> etc.
FrbOpaqueSyncReturnTwinMoi frbSyncGeneratorTestTwinMoi() => RustLib.instance.api
    .crateApiPseudoManualRustOpaqueSyncTwinMoiFrbSyncGeneratorTestTwinMoi();

// Rust type: RustOpaqueMoi<FrbOpaqueSyncReturnTwinMoi>
abstract class FrbOpaqueSyncReturnTwinMoi {
  void dispose();

  bool get isDisposed;
}

// Rust type: RustOpaqueMoi<HideDataAnotherTwinMoi>
abstract class HideDataAnotherTwinMoi {
  void dispose();

  bool get isDisposed;
}

// Rust type: RustOpaqueMoi<NonCloneDataTwinMoi>
abstract class NonCloneDataTwinMoi {
  void dispose();

  bool get isDisposed;
}
