// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.25.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Stream<String> funcStreamReturnErrorTwinRustAsyncSse({dynamic hint}) =>
    RustLib.instance.api.funcStreamReturnErrorTwinRustAsyncSse(hint: hint);

Stream<String> funcStreamReturnPanicTwinRustAsyncSse({dynamic hint}) =>
    RustLib.instance.api.funcStreamReturnPanicTwinRustAsyncSse(hint: hint);

Stream<int> funcStreamSinkArgPositionTwinRustAsyncSse(
        {required int a, required int b, dynamic hint}) =>
    RustLib.instance.api
        .funcStreamSinkArgPositionTwinRustAsyncSse(a: a, b: b, hint: hint);

Stream<MyStreamEntryTwinRustAsyncSse> handleStreamOfStructTwinRustAsyncSse(
        {dynamic hint}) =>
    RustLib.instance.api.handleStreamOfStructTwinRustAsyncSse(hint: hint);

Stream<LogTwinRustAsyncSse> handleStreamSinkAt1TwinRustAsyncSse(
        {required int key, required int max, dynamic hint}) =>
    RustLib.instance.api
        .handleStreamSinkAt1TwinRustAsyncSse(key: key, max: max, hint: hint);

Stream<LogTwinRustAsyncSse> handleStreamSinkAt2TwinRustAsyncSse(
        {required int key, required int max, dynamic hint}) =>
    RustLib.instance.api
        .handleStreamSinkAt2TwinRustAsyncSse(key: key, max: max, hint: hint);

Stream<LogTwinRustAsyncSse> handleStreamSinkAt3TwinRustAsyncSse(
        {required int key, required int max, dynamic hint}) =>
    RustLib.instance.api
        .handleStreamSinkAt3TwinRustAsyncSse(key: key, max: max, hint: hint);

class LogTwinRustAsyncSse {
  final int key;
  final int value;

  const LogTwinRustAsyncSse({
    required this.key,
    required this.value,
  });

  @override
  int get hashCode => key.hashCode ^ value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogTwinRustAsyncSse &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          value == other.value;
}

class MyStreamEntryTwinRustAsyncSse {
  final String hello;

  const MyStreamEntryTwinRustAsyncSse({
    required this.hello,
  });

  @override
  int get hashCode => hello.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyStreamEntryTwinRustAsyncSse &&
          runtimeType == other.runtimeType &&
          hello == other.hello;
}
