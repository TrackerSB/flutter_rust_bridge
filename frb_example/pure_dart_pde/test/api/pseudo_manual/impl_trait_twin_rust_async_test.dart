// NOTE: This file is mimicking how a human developer writes tests,
// and is auto-generated from `impl_trait_test.dart` by frb_internal
// Please do not modify manually, but modify the origin and re-run frb_internal generator

// AUTO-GENERATED FROM frb_example/pure_dart, DO NOT EDIT

import 'package:frb_example_pure_dart_pde/src/rust/api/pseudo_manual/impl_trait_twin_rust_async.dart';
import 'package:frb_example_pure_dart_pde/src/rust/frb_generated.dart';
import 'package:test/test.dart';

Future<void> main({bool skipRustLibInit = false}) async {
  if (!skipRustLibInit) await RustLib.init();

  test('impl class should extend trait class', () async {
    final one =
        await StructOneWithTraitTwinRustAsync.simpleTraitFnTwinRustAsync(
            value: 10);
    expect(one, isA<SimpleTraitTwinRustAsync>());
  });

  test('call methods', () async {
    final one =
        await StructOneWithTraitTwinRustAsync.simpleTraitFnTwinRustAsync(
            value: 10);
    expect(await one.simpleTraitFnReceiverBorrowTwinRustAsync(), 10);
  });

  test('trait default impl', () async {
    expect(
        await StructOneWithTraitTwinRustAsync
            .simpleTraitFnWithDefaultImplTwinRustAsync(),
        42);
  });
}
