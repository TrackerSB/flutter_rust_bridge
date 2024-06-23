// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Future<int> castedPrimitiveI64TwinNormal({required int arg}) =>
    RustLib.instance.api
        .crateApiCastedPrimitiveCastedPrimitiveI64TwinNormal(arg: arg);

Future<int> castedPrimitiveU64TwinNormal({required int arg}) =>
    RustLib.instance.api
        .crateApiCastedPrimitiveCastedPrimitiveU64TwinNormal(arg: arg);

Future<int> castedPrimitiveIsizeTwinNormal({required int arg}) =>
    RustLib.instance.api
        .crateApiCastedPrimitiveCastedPrimitiveIsizeTwinNormal(arg: arg);

Future<int> castedPrimitiveUsizeTwinNormal({required int arg}) =>
    RustLib.instance.api
        .crateApiCastedPrimitiveCastedPrimitiveUsizeTwinNormal(arg: arg);

Future<void> castedPrimitiveMultiArgTwinNormal(
        {required int a, required int b, required int c, required BigInt d}) =>
    RustLib.instance.api
        .crateApiCastedPrimitiveCastedPrimitiveMultiArgTwinNormal(
            a: a, b: b, c: c, d: d);

Future<StructWithCastedPrimitiveTwinNormal>
    functionForStructWithCastedPrimitiveTwinNormal(
            {required StructWithCastedPrimitiveTwinNormal arg}) =>
        RustLib.instance.api
            .crateApiCastedPrimitiveFunctionForStructWithCastedPrimitiveTwinNormal(
                arg: arg);

class StructWithCastedPrimitiveTwinNormal {
  final int fieldI64;
  final int fieldU64;
  final int fieldI32;
  final Uint8List fieldVecU8;

  const StructWithCastedPrimitiveTwinNormal({
    required this.fieldI64,
    required this.fieldU64,
    required this.fieldI32,
    required this.fieldVecU8,
  });

  @override
  int get hashCode =>
      fieldI64.hashCode ^
      fieldU64.hashCode ^
      fieldI32.hashCode ^
      fieldVecU8.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StructWithCastedPrimitiveTwinNormal &&
          runtimeType == other.runtimeType &&
          fieldI64 == other.fieldI64 &&
          fieldU64 == other.fieldU64 &&
          fieldI32 == other.fieldI32 &&
          fieldVecU8 == other.fieldVecU8;
}