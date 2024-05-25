// NOTE: This file is mimicking how a human developer writes tests,
// and is auto-generated from `type_alias_test.dart` by frb_internal
// Please do not modify manually, but modify the origin and re-run frb_internal generator

import 'package:frb_example_pure_dart/src/rust/api/pseudo_manual/type_alias_twin_sync_sse.dart';
import 'package:frb_example_pure_dart/src/rust/auxiliary/sample_types.dart';
import 'package:frb_example_pure_dart/src/rust/frb_generated.dart';
import 'package:test/test.dart';

Future<void> main({bool skipRustLibInit = false}) async {
  if (!skipRustLibInit) await RustLib.init();

  test('dart call handle_type_id', () async {
    final id = await handleTypeAliasIdTwinSyncSse(input: BigInt.from(42));
    expect(id.toInt(), 42);
  });

  test('dart call handle_type_nest_alias_id', () async {
    final id = await handleTypeNestAliasIdTwinSyncSse(input: BigInt.from(42));
    expect(id.toInt(), 42);
  });

  test('dart call handle_type_model', () async {
    final testModel =
        await handleTypeAliasModelTwinSyncSse(input: BigInt.from(42));
    expect(testModel.id.toInt(), 42);
    expect(testModel.name, "TestModel");
    expect(testModel.aliasEnum, MyEnum.False);
    expect(testModel.aliasStruct.content, true);
  });
}
