// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.36.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Future<String> borrowStringTwinSse({required String arg, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualOwnershipTwinSseBorrowStringTwinSse(
            arg: arg, hint: hint);

Future<String> borrowStrTwinSse({required String arg, dynamic hint}) => RustLib
    .instance.api
    .crateApiPseudoManualOwnershipTwinSseBorrowStrTwinSse(arg: arg, hint: hint);

Future<int> borrowI32TwinSse({required int arg, dynamic hint}) => RustLib
    .instance.api
    .crateApiPseudoManualOwnershipTwinSseBorrowI32TwinSse(arg: arg, hint: hint);

Future<SimpleStructForBorrowTwinSse> borrowStructTwinSse(
        {required SimpleStructForBorrowTwinSse arg, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualOwnershipTwinSseBorrowStructTwinSse(
            arg: arg, hint: hint);

class SimpleStructForBorrowTwinSse {
  final String one;

  const SimpleStructForBorrowTwinSse({
    required this.one,
  });

  @override
  int get hashCode => one.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimpleStructForBorrowTwinSse &&
          runtimeType == other.runtimeType &&
          one == other.one;
}
