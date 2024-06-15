// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.39.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Future<void> rustCallDartSimpleTwinRustAsyncSse(
        {required FutureOr<void> Function() callback}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartFnTwinRustAsyncSseRustCallDartSimpleTwinRustAsyncSse(
            callback: callback);

Future<void> rustCallDartOneArgTwinRustAsyncSse(
        {required FutureOr<void> Function(String) callback}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartFnTwinRustAsyncSseRustCallDartOneArgTwinRustAsyncSse(
            callback: callback);

Future<void> rustCallDartTwoArgsTwinRustAsyncSse(
        {required FutureOr<void> Function(
                String, DemoStructForRustCallDartTwinRustAsyncSse)
            callback}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartFnTwinRustAsyncSseRustCallDartTwoArgsTwinRustAsyncSse(
            callback: callback);

Future<void> rustCallDartReturnTwinRustAsyncSse(
        {required FutureOr<String> Function() callback}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartFnTwinRustAsyncSseRustCallDartReturnTwinRustAsyncSse(
            callback: callback);

Future<void> rustCallDartLoopbackTwinRustAsyncSse(
        {required FutureOr<DemoStructForRustCallDartTwinRustAsyncSse> Function(
                DemoStructForRustCallDartTwinRustAsyncSse)
            callback}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartFnTwinRustAsyncSseRustCallDartLoopbackTwinRustAsyncSse(
            callback: callback);

Future<void> rustCallDartWithDartOpaqueArgTwinRustAsyncSse(
        {required Object input,
        required FutureOr<void> Function(Object) callback}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartFnTwinRustAsyncSseRustCallDartWithDartOpaqueArgTwinRustAsyncSse(
            input: input, callback: callback);

Future<Object> rustCallDartWithDartOpaqueResultTwinRustAsyncSse(
        {required FutureOr<Object> Function() callback}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartFnTwinRustAsyncSseRustCallDartWithDartOpaqueResultTwinRustAsyncSse(
            callback: callback);

Future<void> rustCallDartMultiTimesTwinRustAsyncSse(
        {required FutureOr<void> Function() callback, required int numTimes}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartFnTwinRustAsyncSseRustCallDartMultiTimesTwinRustAsyncSse(
            callback: callback, numTimes: numTimes);

Future<void> rustCallDartReturnResultTwinRustAsyncSse(
        {required FutureOr<String> Function(String) callback,
        String? expectOutput}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartFnTwinRustAsyncSseRustCallDartReturnResultTwinRustAsyncSse(
            callback: callback, expectOutput: expectOutput);

class DemoStructForRustCallDartTwinRustAsyncSse {
  final String name;

  const DemoStructForRustCallDartTwinRustAsyncSse({
    required this.name,
  });

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DemoStructForRustCallDartTwinRustAsyncSse &&
          runtimeType == other.runtimeType &&
          name == other.name;
}
