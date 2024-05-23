// NOTE: This file is mimicking how a human developer writes tests,
// and is auto-generated from `basic_test.dart` by frb_internal
// Please do not modify manually, but modify the origin and re-run frb_internal generator

// NOTE: This file is mimicking how a human developer writes tests,
// and is auto-generated by frb_internal
// Please do not modify manually, but modify the origin and re-run frb_internal generator

import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:frb_example_pure_dart/src/rust/api/pseudo_manual/basic_twin_rust_async.dart';
import 'package:frb_example_pure_dart/src/rust/frb_generated.dart';
import 'package:test/test.dart';
import '../../test_utils.dart';
import 'dart:typed_data';

Future<void> main({bool skipRustLibInit = false}) async {
  if (!skipRustLibInit) await RustLib.init();

  group('basic', () {
    addTestsIdentityFunctionCall(
        exampleBasicTypeI8TwinRustAsync, <int>[0, -128, 127, 79, -79]);
    addTestsIdentityFunctionCall(exampleBasicTypeI16TwinRustAsync,
        <int>[0, -32768, 32767, 12345, -12345]);
    addTestsIdentityFunctionCall(exampleBasicTypeI32TwinRustAsync,
        <int>[0, -2147483648, 2147483647, 1234567890, -1234567890]);
    addTestsIdentityFunctionCall(
        exampleBasicTypeI64TwinRustAsync, <PlatformInt64>[
      PlatformInt64.parse("0"),
      PlatformInt64.parse("-9007199254740992"),
      PlatformInt64.parse("9007199254740992"),
      PlatformInt64.parse("-9223372036854775808"),
      PlatformInt64.parse("9223372036854775807"),
      PlatformInt64.parse("1234567890123456789"),
      PlatformInt64.parse("-1234567890123456789")
    ]);
    addTestsIdentityFunctionCall(exampleBasicTypeI128TwinRustAsync, <BigInt>[
      BigInt.parse("0"),
      BigInt.parse("-9007199254740992"),
      BigInt.parse("9007199254740992"),
      BigInt.parse("-9223372036854775808"),
      BigInt.parse("9223372036854775807"),
      BigInt.parse("-170141183460469231731687303715884105728"),
      BigInt.parse("170141183460469231731687303715884105727")
    ]);
    addTestsIdentityFunctionCall(
        exampleBasicTypeU8TwinRustAsync, <int>[0, 255, 123]);
    addTestsIdentityFunctionCall(
        exampleBasicTypeU16TwinRustAsync, <int>[0, 65535, 12345]);
    addTestsIdentityFunctionCall(
        exampleBasicTypeU32TwinRustAsync, <int>[0, 4294967295, 2468013579]);
    addTestsIdentityFunctionCall(exampleBasicTypeU64TwinRustAsync, <BigInt>[
      BigInt.parse("0"),
      BigInt.parse("9007199254740992"),
      BigInt.parse("9223372036854775807"),
      BigInt.parse("18446744073709551615"),
      BigInt.parse("12345678901234456789")
    ]);
    addTestsIdentityFunctionCall(exampleBasicTypeU128TwinRustAsync, <BigInt>[
      BigInt.parse("0"),
      BigInt.parse("9007199254740992"),
      BigInt.parse("18446744073709551615"),
      BigInt.parse("340282366920938463463374607431768211455")
    ]);
    addTestsIdentityFunctionCall(
        exampleBasicTypeIsizeTwinRustAsync, <PlatformInt64>[
      PlatformInt64.parse("0"),
      PlatformInt64.parse("-2147483648"),
      PlatformInt64.parse("2147483647"),
      PlatformInt64.parse("-1234234567"),
      PlatformInt64.parse("1234234567"),
      if (!kIsWeb) PlatformInt64.parse("-9007199254740992"),
      if (!kIsWeb) PlatformInt64.parse("9007199254740992"),
      if (!kIsWeb) PlatformInt64.parse("-9223372036854775808"),
      if (!kIsWeb) PlatformInt64.parse("9223372036854775807"),
      if (!kIsWeb) PlatformInt64.parse("-12345678901234456789"),
      if (!kIsWeb) PlatformInt64.parse("12345678901234456789")
    ]);
    addTestsIdentityFunctionCall(exampleBasicTypeUsizeTwinRustAsync, <BigInt>[
      BigInt.parse("0"),
      BigInt.parse("4294967295"),
      BigInt.parse("1234234567"),
      if (!kIsWeb) BigInt.parse("9007199254740992"),
      if (!kIsWeb) BigInt.parse("9223372036854775807"),
      if (!kIsWeb) BigInt.parse("18446744073709551615"),
      if (!kIsWeb) BigInt.parse("12345678901234456789")
    ]);
    addTestsIdentityFunctionCall(
        exampleBasicTypeF32TwinRustAsync, <double>[0, -42.5, 123456]);
    addTestsIdentityFunctionCall(
        exampleBasicTypeF64TwinRustAsync, <double>[0, -42.5, 123456]);
    addTestsIdentityFunctionCall(
        exampleBasicTypeBoolTwinRustAsync, <bool>[false, true]);
    addTestsIdentityFunctionCall(
        exampleBasicTypeStringTwinRustAsync, <String>["", "hello", "😂"]);
    addTestsIdentityFunctionCall(
        exampleBasicTypeBytesTwinRustAsync, <Uint8List>[
      Uint8List.fromList([]),
      Uint8List.fromList([255, 0]),
      Uint8List.fromList([10, 20, 30, 40])
    ]);
    addTestsIdentityFunctionCall(
        exampleBasicTypeBasicPrimitiveEnumTwinRustAsyncTwinRustAsync,
        <BasicPrimitiveEnumTwinRustAsync>[
          BasicPrimitiveEnumTwinRustAsync.apple,
          BasicPrimitiveEnumTwinRustAsync.orange
        ]);
    addTestsIdentityFunctionCall(
        exampleBasicTypeBasicGeneralEnumTwinRustAsyncTwinRustAsync,
        <BasicGeneralEnumTwinRustAsync>[
          BasicGeneralEnumTwinRustAsync.apple(field: "one"),
          BasicGeneralEnumTwinRustAsync.orange()
        ]);
    addTestsIdentityFunctionCall(
        exampleBasicTypeBasicStructTwinRustAsyncTwinRustAsync,
        <BasicStructTwinRustAsync>[
          BasicStructTwinRustAsync(apple: null, orange: null),
          BasicStructTwinRustAsync(apple: "one", orange: 42)
        ]);
  });
}
