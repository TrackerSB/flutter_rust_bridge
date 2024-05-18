// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.33.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import '../dart_opaque.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
part 'dart_opaque_twin_sync.freezed.dart';

// The type `DART_OPAQUE` is not used by any `pub` functions, thus it is ignored.

String asyncAcceptDartOpaqueTwinSync({required Object opaque, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncAsyncAcceptDartOpaqueTwinSync(
            opaque: opaque, hint: hint);

Object loopBackTwinSync({required Object opaque, dynamic hint}) =>
    RustLib.instance.api.crateApiPseudoManualDartOpaqueTwinSyncLoopBackTwinSync(
        opaque: opaque, hint: hint);

Object? loopBackOptionTwinSync({required Object opaque, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncLoopBackOptionTwinSync(
            opaque: opaque, hint: hint);

ObjectArray1 loopBackArrayTwinSync({required Object opaque, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncLoopBackArrayTwinSync(
            opaque: opaque, hint: hint);

List<Object> loopBackVecTwinSync({required Object opaque, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncLoopBackVecTwinSync(
            opaque: opaque, hint: hint);

void loopBackOptionGetTwinSync({Object? opaque, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncLoopBackOptionGetTwinSync(
            opaque: opaque, hint: hint);

void loopBackArrayGetTwinSync({required ObjectArray1 opaque, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncLoopBackArrayGetTwinSync(
            opaque: opaque, hint: hint);

void loopBackVecGetTwinSync({required List<Object> opaque, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncLoopBackVecGetTwinSync(
            opaque: opaque, hint: hint);

/// [DartWrapObject] cannot be obtained
/// on a thread other than the thread it was created on.
void panicUnwrapDartOpaqueTwinSync({required Object opaque, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncPanicUnwrapDartOpaqueTwinSync(
            opaque: opaque, hint: hint);

DartOpaqueNestedTwinSync createNestedDartOpaqueTwinSync(
        {required Object opaque1, required Object opaque2, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncCreateNestedDartOpaqueTwinSync(
            opaque1: opaque1, opaque2: opaque2, hint: hint);

void getNestedDartOpaqueTwinSync(
        {required DartOpaqueNestedTwinSync opaque, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncGetNestedDartOpaqueTwinSync(
            opaque: opaque, hint: hint);

EnumDartOpaqueTwinSync createEnumDartOpaqueTwinSync(
        {required Object opaque, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncCreateEnumDartOpaqueTwinSync(
            opaque: opaque, hint: hint);

void getEnumDartOpaqueTwinSync(
        {required EnumDartOpaqueTwinSync opaque, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncGetEnumDartOpaqueTwinSync(
            opaque: opaque, hint: hint);

void setStaticDartOpaqueTwinSync(
        {required int id, required Object opaque, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncSetStaticDartOpaqueTwinSync(
            id: id, opaque: opaque, hint: hint);

void dropStaticDartOpaqueTwinSync({required int id, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncDropStaticDartOpaqueTwinSync(
            id: id, hint: hint);

List<Object> cloneDartOpaqueTwinSync({required Object opaque, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualDartOpaqueTwinSyncCloneDartOpaqueTwinSync(
            opaque: opaque, hint: hint);

class DartOpaqueNestedTwinSync {
  final Object first;
  final Object second;

  const DartOpaqueNestedTwinSync({
    required this.first,
    required this.second,
  });

  @override
  int get hashCode => first.hashCode ^ second.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartOpaqueNestedTwinSync &&
          runtimeType == other.runtimeType &&
          first == other.first &&
          second == other.second;
}

@freezed
sealed class EnumDartOpaqueTwinSync with _$EnumDartOpaqueTwinSync {
  const EnumDartOpaqueTwinSync._();

  const factory EnumDartOpaqueTwinSync.primitive(
    int field0,
  ) = EnumDartOpaqueTwinSync_Primitive;
  const factory EnumDartOpaqueTwinSync.opaque(
    Object field0,
  ) = EnumDartOpaqueTwinSync_Opaque;
}
