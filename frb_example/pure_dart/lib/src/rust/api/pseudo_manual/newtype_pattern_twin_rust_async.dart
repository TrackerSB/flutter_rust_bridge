// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.39.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Future<NewTypeIntTwinRustAsync> handleNewtypeTwinRustAsync(
        {required NewTypeIntTwinRustAsync arg}) =>
    RustLib.instance.api
        .crateApiPseudoManualNewtypePatternTwinRustAsyncHandleNewtypeTwinRustAsync(
            arg: arg);

class NewTypeIntTwinRustAsync {
  final PlatformInt64 field0;

  const NewTypeIntTwinRustAsync({
    required this.field0,
  });

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewTypeIntTwinRustAsync &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}
