// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.36.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../auxiliary/sample_types.dart';
import '../../frb_generated.dart';
import '../mirror.dart';
import 'mirror_twin_sync_sse.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Future<ApplicationSettings> getAppSettingsTwinRustAsyncSse({dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseGetAppSettingsTwinRustAsyncSse(
            hint: hint);

Future<ApplicationSettings> getFallibleAppSettingsTwinRustAsyncSse(
        {dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseGetFallibleAppSettingsTwinRustAsyncSse(
            hint: hint);

Future<bool> isAppEmbeddedTwinRustAsyncSse(
        {required ApplicationSettings appSettings, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseIsAppEmbeddedTwinRustAsyncSse(
            appSettings: appSettings, hint: hint);

Stream<ApplicationSettings> appSettingsStreamTwinRustAsyncSse({dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseAppSettingsStreamTwinRustAsyncSse(
            hint: hint);

Stream<List<ApplicationSettings>> appSettingsVecStreamTwinRustAsyncSse(
        {dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseAppSettingsVecStreamTwinRustAsyncSse(
            hint: hint);

Stream<MirrorStructTwinRustAsyncSse> mirrorStructStreamTwinRustAsyncSse(
        {dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseMirrorStructStreamTwinRustAsyncSse(
            hint: hint);

Stream<(ApplicationSettings, RawStringEnumMirrored)>
    mirrorTupleStreamTwinRustAsyncSse({dynamic hint}) => RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseMirrorTupleStreamTwinRustAsyncSse(
            hint: hint);

Future<ApplicationMessage> getMessageTwinRustAsyncSse({dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseGetMessageTwinRustAsyncSse(
            hint: hint);

Future<Numbers> repeatNumberTwinRustAsyncSse(
        {required int num, required BigInt times, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseRepeatNumberTwinRustAsyncSse(
            num: num, times: times, hint: hint);

Future<Sequences> repeatSequenceTwinRustAsyncSse(
        {required int seq, required BigInt times, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseRepeatSequenceTwinRustAsyncSse(
            seq: seq, times: times, hint: hint);

Future<int?> firstNumberTwinRustAsyncSse(
        {required Numbers nums, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseFirstNumberTwinRustAsyncSse(
            nums: nums, hint: hint);

Future<int?> firstSequenceTwinRustAsyncSse(
        {required Sequences seqs, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseFirstSequenceTwinRustAsyncSse(
            seqs: seqs, hint: hint);

Future<RawStringMirrored> testRawStringMirroredTwinRustAsyncSse(
        {dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseTestRawStringMirroredTwinRustAsyncSse(
            hint: hint);

Future<NestedRawStringMirrored> testNestedRawStringMirroredTwinRustAsyncSse(
        {dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseTestNestedRawStringMirroredTwinRustAsyncSse(
            hint: hint);

Future<RawStringEnumMirrored> testRawStringEnumMirroredTwinRustAsyncSse(
        {required bool nested, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseTestRawStringEnumMirroredTwinRustAsyncSse(
            nested: nested, hint: hint);

Future<ListOfNestedRawStringMirrored>
    testListOfRawNestedStringMirroredTwinRustAsyncSse({dynamic hint}) => RustLib
        .instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseTestListOfRawNestedStringMirroredTwinRustAsyncSse(
            hint: hint);

Future<List<RawStringMirrored>> testFallibleOfRawStringMirroredTwinRustAsyncSse(
        {dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseTestFallibleOfRawStringMirroredTwinRustAsyncSse(
            hint: hint);

Future<List<RawStringEnumMirrored>>
    testListOfNestedEnumsMirroredTwinRustAsyncSse({dynamic hint}) => RustLib
        .instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseTestListOfNestedEnumsMirroredTwinRustAsyncSse(
            hint: hint);

Future<ContainsMirroredSubStructTwinRustAsyncSse>
    testContainsMirroredSubStructTwinRustAsyncSse({dynamic hint}) => RustLib
        .instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseTestContainsMirroredSubStructTwinRustAsyncSse(
            hint: hint);

Future<StructWithHashMap> testHashmapWithMirroredValueTwinRustAsyncSse(
        {dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseTestHashmapWithMirroredValueTwinRustAsyncSse(
            hint: hint);

Stream<ApplicationMode> mirrorEnumStreamTwinRustAsyncSse({dynamic hint}) => RustLib
    .instance.api
    .crateApiPseudoManualMirrorTwinRustAsyncSseMirrorEnumStreamTwinRustAsyncSse(
        hint: hint);

Stream<ApplicationMode?> mirrorOptionEnumStreamTwinRustAsyncSse(
        {dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseMirrorOptionEnumStreamTwinRustAsyncSse(
            hint: hint);

Stream<List<ApplicationMode>> mirrorVecEnumStreamTwinRustAsyncSse(
        {dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseMirrorVecEnumStreamTwinRustAsyncSse(
            hint: hint);

Stream<Map<int, ApplicationMode>> mirrorMapEnumStreamTwinRustAsyncSse(
        {dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseMirrorMapEnumStreamTwinRustAsyncSse(
            hint: hint);

Stream<Set<ApplicationMode>> mirrorSetEnumStreamTwinRustAsyncSse(
        {dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseMirrorSetEnumStreamTwinRustAsyncSse(
            hint: hint);

Stream<ApplicationModeArray2> mirrorArrayEnumStreamTwinRustAsyncSse(
        {dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualMirrorTwinRustAsyncSseMirrorArrayEnumStreamTwinRustAsyncSse(
            hint: hint);

class AnotherTwinRustAsyncSse {
  final String a;

  const AnotherTwinRustAsyncSse({
    required this.a,
  });

  @override
  int get hashCode => a.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnotherTwinRustAsyncSse &&
          runtimeType == other.runtimeType &&
          a == other.a;
}

class ContainsMirroredSubStructTwinRustAsyncSse {
  final RawStringMirrored test;
  final AnotherTwinRustAsyncSse test2;

  const ContainsMirroredSubStructTwinRustAsyncSse({
    required this.test,
    required this.test2,
  });

  @override
  int get hashCode => test.hashCode ^ test2.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContainsMirroredSubStructTwinRustAsyncSse &&
          runtimeType == other.runtimeType &&
          test == other.test &&
          test2 == other.test2;
}

class MirrorStructTwinRustAsyncSse {
  final ApplicationSettings a;
  final MyStruct b;
  final List<MyEnum> c;
  final List<ApplicationSettings> d;

  const MirrorStructTwinRustAsyncSse({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
  });

  @override
  int get hashCode => a.hashCode ^ b.hashCode ^ c.hashCode ^ d.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MirrorStructTwinRustAsyncSse &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b &&
          c == other.c &&
          d == other.d;
}
