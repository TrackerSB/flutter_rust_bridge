// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.36.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

String borrowStringTwinSyncSse({required String arg, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualOwnershipTwinSyncSseBorrowStringTwinSyncSse(
            arg: arg, hint: hint);

String borrowStrTwinSyncSse({required String arg, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualOwnershipTwinSyncSseBorrowStrTwinSyncSse(
            arg: arg, hint: hint);

int borrowI32TwinSyncSse({required int arg, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualOwnershipTwinSyncSseBorrowI32TwinSyncSse(
            arg: arg, hint: hint);

SimpleStructForBorrowTwinSyncSse borrowStructTwinSyncSse(
        {required SimpleStructForBorrowTwinSyncSse arg, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualOwnershipTwinSyncSseBorrowStructTwinSyncSse(
            arg: arg, hint: hint);

class SimpleStructForBorrowTwinSyncSse {
  final String one;

  const SimpleStructForBorrowTwinSyncSse({
    required this.one,
  });

  @override
  int get hashCode => one.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimpleStructForBorrowTwinSyncSse &&
          runtimeType == other.runtimeType &&
          one == other.one;
}
