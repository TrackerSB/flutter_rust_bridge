// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.39.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

HideDataAnotherTwinSse? syncOptionRustOpaqueTwinSse() => RustLib.instance.api
    .crateApiPseudoManualRustOpaqueSyncTwinSseSyncOptionRustOpaqueTwinSse();

HideDataAnotherTwinSse syncCreateOpaqueTwinSse() => RustLib.instance.api
    .crateApiPseudoManualRustOpaqueSyncTwinSseSyncCreateOpaqueTwinSse();

NonCloneDataTwinSse syncCreateNonCloneTwinSse() => RustLib.instance.api
    .crateApiPseudoManualRustOpaqueSyncTwinSseSyncCreateNonCloneTwinSse();

/// Structure for testing the sync-mode RustOpaque code generator.
/// FrbOpaqueSyncReturn must be only return type.
/// FrbOpaqueSyncReturn must be without wrapper like Option<> Vec<> etc.
FrbOpaqueSyncReturnTwinSse frbSyncGeneratorTestTwinSse() => RustLib.instance.api
    .crateApiPseudoManualRustOpaqueSyncTwinSseFrbSyncGeneratorTestTwinSse();

// Rust type: RustOpaqueNom<FrbOpaqueSyncReturnTwinSse>
abstract class FrbOpaqueSyncReturnTwinSse implements RustOpaqueInterface {}

// Rust type: RustOpaqueNom<HideDataAnotherTwinSse>
abstract class HideDataAnotherTwinSse implements RustOpaqueInterface {}

// Rust type: RustOpaqueNom<NonCloneDataTwinSse>
abstract class NonCloneDataTwinSse implements RustOpaqueInterface {}
