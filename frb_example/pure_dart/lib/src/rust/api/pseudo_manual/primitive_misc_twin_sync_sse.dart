// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.33.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

int primitiveTypesTwinSyncSse(
        {required int myI32,
        required int myI64,
        required double myF64,
        required bool myBool,
        dynamic hint}) =>
    RustLib.instance.api.primitiveTypesTwinSyncSse(
        myI32: myI32, myI64: myI64, myF64: myF64, myBool: myBool, hint: hint);

int primitiveU32TwinSyncSse({required int myU32, dynamic hint}) =>
    RustLib.instance.api.primitiveU32TwinSyncSse(myU32: myU32, hint: hint);
