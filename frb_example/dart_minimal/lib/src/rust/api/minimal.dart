// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.37.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<MyAudioParam>>
abstract class MyAudioParam implements RustOpaqueInterface {
  Future<String> myMethod();

  factory MyAudioParam({required String value}) =>
      RustLib.instance.api.crateApiMinimalMyAudioParamNew(value: value);
}

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<MyNode>>
abstract class MyNode implements RustOpaqueInterface {
  factory MyNode() => RustLib.instance.api.crateApiMinimalMyNodeNew();

  Future<MyAudioParam> paramOne();
}
