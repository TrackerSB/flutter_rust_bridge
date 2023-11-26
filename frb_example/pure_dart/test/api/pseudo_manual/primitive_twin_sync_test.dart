// NOTE: This file is mimicking how a human developer writes tests,
// and is auto-generated from `primitive_test.dart` by frb_internal
// Please do not modify manually, but modify the origin and re-run frb_internal generator

// NOTE: This file is mimicking how a human developer writes tests,
// and is auto-generated by frb_internal
// Please do not modify manually, but modify the origin and re-run frb_internal generator

import 'package:frb_example_pure_dart/src/rust/api/pseudo_manual/primitive_twin_sync.dart';
import 'package:frb_example_pure_dart/src/rust/frb_generated.dart';
import 'package:test/test.dart';

import '../../test_utils.dart';

Future<void> main({bool skipRustLibInit = false}) async {
  if (!skipRustLibInit) await RustLib.init();

  group('primitive', () {
    addTestsIdentityFunctionCall(examplePrimitiveTypeI8TwinSync, <int>[0, -128, 127]);
    addTestsIdentityFunctionCall(examplePrimitiveTypeI16TwinSync, <int>[0, -32768, 32767]);
    addTestsIdentityFunctionCall(examplePrimitiveTypeI32TwinSync, <int>[0, -2147483648, 2147483647]);
    addTestsIdentityFunctionCall(examplePrimitiveTypeI64TwinSync,
        <BigInt>[BigInt.parse("0"), BigInt.parse("-9223372036854775808"), BigInt.parse("9223372036854775807")]);
    addTestsIdentityFunctionCall(examplePrimitiveTypeU8TwinSync, <int>[0, 255]);
    addTestsIdentityFunctionCall(examplePrimitiveTypeU16TwinSync, <int>[0, 65535]);
    addTestsIdentityFunctionCall(examplePrimitiveTypeU32TwinSync, <int>[0, 4294967295]);
    addTestsIdentityFunctionCall(
        examplePrimitiveTypeU64TwinSync, <BigInt>[BigInt.parse("0"), BigInt.parse("9223372036854775807")]);
    addTestsIdentityFunctionCall(examplePrimitiveTypeF32TwinSync, <double>[0, -42.5, 123456]);
    addTestsIdentityFunctionCall(examplePrimitiveTypeF64TwinSync, <double>[0, -42.5, 123456]);
    addTestsIdentityFunctionCall(examplePrimitiveTypeBoolTwinSync, <bool>[false, true]);
  });
}
