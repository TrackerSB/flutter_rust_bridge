// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.39.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:collection/collection.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
part 'method_twin_sync_sse.freezed.dart';

SumWithTwinSyncSse getSumStructTwinSyncSse() => RustLib.instance.api
    .crateApiPseudoManualMethodTwinSyncSseGetSumStructTwinSyncSse();

SumWithTwinSyncSseArray3 getSumArrayTwinSyncSse(
        {required int a, required int b, required int c}) =>
    RustLib.instance.api
        .crateApiPseudoManualMethodTwinSyncSseGetSumArrayTwinSyncSse(
            a: a, b: b, c: c);

// Rust type: RustOpaqueNom<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<StaticGetterOnlyTwinSyncSse>>
abstract class StaticGetterOnlyTwinSyncSse implements RustOpaqueInterface {
  static int get staticGetterTwinSyncSse => RustLib.instance.api
      .crateApiPseudoManualMethodTwinSyncSseStaticGetterOnlyTwinSyncSseStaticGetterTwinSyncSse();
}

class ConcatenateWithTwinSyncSse {
  final String a;

  const ConcatenateWithTwinSyncSse({
    required this.a,
  });

  static String concatenateStaticTwinSyncSse(
          {required String a, required String b}) =>
      RustLib.instance.api
          .crateApiPseudoManualMethodTwinSyncSseConcatenateWithTwinSyncSseConcatenateStaticTwinSyncSse(
              a: a, b: b);

  String concatenateTwinSyncSse({required String b}) => RustLib.instance.api
      .crateApiPseudoManualMethodTwinSyncSseConcatenateWithTwinSyncSseConcatenateTwinSyncSse(
          that: this, b: b);

  static Stream<int> handleSomeStaticStreamSinkSingleArgTwinSyncSse() => RustLib
      .instance.api
      .crateApiPseudoManualMethodTwinSyncSseConcatenateWithTwinSyncSseHandleSomeStaticStreamSinkSingleArgTwinSyncSse();

  static Stream<Log2TwinSyncSse> handleSomeStaticStreamSinkTwinSyncSse(
          {required int key, required int max}) =>
      RustLib.instance.api
          .crateApiPseudoManualMethodTwinSyncSseConcatenateWithTwinSyncSseHandleSomeStaticStreamSinkTwinSyncSse(
              key: key, max: max);

  Stream<int> handleSomeStreamSinkAt1TwinSyncSse() => RustLib.instance.api
          .crateApiPseudoManualMethodTwinSyncSseConcatenateWithTwinSyncSseHandleSomeStreamSinkAt1TwinSyncSse(
        that: this,
      );

  Stream<Log2TwinSyncSse> handleSomeStreamSinkTwinSyncSse(
          {required int key, required int max}) =>
      RustLib.instance.api
          .crateApiPseudoManualMethodTwinSyncSseConcatenateWithTwinSyncSseHandleSomeStreamSinkTwinSyncSse(
              that: this, key: key, max: max);

  static ConcatenateWithTwinSyncSse newTwinSyncSse({required String a}) => RustLib
      .instance.api
      .crateApiPseudoManualMethodTwinSyncSseConcatenateWithTwinSyncSseNewTwinSyncSse(
          a: a);

  String get simpleGetterTwinSyncSse => RustLib.instance.api
          .crateApiPseudoManualMethodTwinSyncSseConcatenateWithTwinSyncSseSimpleGetterTwinSyncSse(
        that: this,
      );

  @override
  int get hashCode => a.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConcatenateWithTwinSyncSse &&
          runtimeType == other.runtimeType &&
          a == other.a;
}

class Log2TwinSyncSse {
  final int key;
  final String value;

  const Log2TwinSyncSse({
    required this.key,
    required this.value,
  });

  @override
  int get hashCode => key.hashCode ^ value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Log2TwinSyncSse &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          value == other.value;
}

class MyCallableTwinSyncSse {
  final String one;

  const MyCallableTwinSyncSse({
    required this.one,
  });

  String call({required String two}) => RustLib.instance.api
      .crateApiPseudoManualMethodTwinSyncSseMyCallableTwinSyncSseCall(
          that: this, two: two);

  @override
  int get hashCode => one.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyCallableTwinSyncSse &&
          runtimeType == other.runtimeType &&
          one == other.one;
}

@freezed
sealed class SimpleEnumTwinSyncSse with _$SimpleEnumTwinSyncSse {
  const SimpleEnumTwinSyncSse._();

  const factory SimpleEnumTwinSyncSse.first() = SimpleEnumTwinSyncSse_First;
  const factory SimpleEnumTwinSyncSse.second(
    String field0,
  ) = SimpleEnumTwinSyncSse_Second;

  static SimpleEnumTwinSyncSse returnSelfTwinSyncSse({required String one}) =>
      RustLib.instance.api
          .crateApiPseudoManualMethodTwinSyncSseSimpleEnumTwinSyncSseReturnSelfTwinSyncSse(
              one: one);

  String simpleMethodTwinSyncSse() => RustLib.instance.api
          .crateApiPseudoManualMethodTwinSyncSseSimpleEnumTwinSyncSseSimpleMethodTwinSyncSse(
        that: this,
      );
}

enum SimplePrimitiveEnumTwinSyncSse {
  first,
  second,
  ;

  int simpleMethodTwinSyncSse() => RustLib.instance.api
          .crateApiPseudoManualMethodTwinSyncSseSimplePrimitiveEnumTwinSyncSseSimpleMethodTwinSyncSse(
        that: this,
      );
}

class SimpleStructTwinSyncSse {
  final String one;

  const SimpleStructTwinSyncSse({
    required this.one,
  });

  static String argSelfTwinSyncSse(
          {required SimpleStructTwinSyncSse a,
          required SimpleStructTwinSyncSse b}) =>
      RustLib.instance.api
          .crateApiPseudoManualMethodTwinSyncSseSimpleStructTwinSyncSseArgSelfTwinSyncSse(
              a: a, b: b);

  String receiverBorrowTwinSyncSse() => RustLib.instance.api
          .crateApiPseudoManualMethodTwinSyncSseSimpleStructTwinSyncSseReceiverBorrowTwinSyncSse(
        that: this,
      );

  String receiverOwnTwinSyncSse() => RustLib.instance.api
          .crateApiPseudoManualMethodTwinSyncSseSimpleStructTwinSyncSseReceiverOwnTwinSyncSse(
        that: this,
      );

  static SimpleStructTwinSyncSse returnSelfTwinSyncSse({required String one}) =>
      RustLib.instance.api
          .crateApiPseudoManualMethodTwinSyncSseSimpleStructTwinSyncSseReturnSelfTwinSyncSse(
              one: one);

  static List<String> vecSelfTwinSyncSse(
          {required List<SimpleStructTwinSyncSse> arg}) =>
      RustLib.instance.api
          .crateApiPseudoManualMethodTwinSyncSseSimpleStructTwinSyncSseVecSelfTwinSyncSse(
              arg: arg);

  @override
  int get hashCode => one.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimpleStructTwinSyncSse &&
          runtimeType == other.runtimeType &&
          one == other.one;
}

class StaticOnlyTwinSyncSse {
  final String one;

  const StaticOnlyTwinSyncSse({
    required this.one,
  });

  static int staticMethodTwinSyncSse({required int a}) => RustLib.instance.api
      .crateApiPseudoManualMethodTwinSyncSseStaticOnlyTwinSyncSseStaticMethodTwinSyncSse(
          a: a);

  @override
  int get hashCode => one.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StaticOnlyTwinSyncSse &&
          runtimeType == other.runtimeType &&
          one == other.one;
}

class SumWithTwinSyncSse {
  final int x;

  const SumWithTwinSyncSse({
    required this.x,
  });

  int sumTwinSyncSse({required int y, required int z}) => RustLib.instance.api
      .crateApiPseudoManualMethodTwinSyncSseSumWithTwinSyncSseSumTwinSyncSse(
          that: this, y: y, z: z);

  @override
  int get hashCode => x.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SumWithTwinSyncSse &&
          runtimeType == other.runtimeType &&
          x == other.x;
}

class SumWithTwinSyncSseArray3 extends NonGrowableListView<SumWithTwinSyncSse> {
  static const arraySize = 3;

  @internal
  List<SumWithTwinSyncSse> get inner => _inner;
  final List<SumWithTwinSyncSse> _inner;

  SumWithTwinSyncSseArray3(this._inner)
      : assert(_inner.length == arraySize),
        super(_inner);

  SumWithTwinSyncSseArray3.init(SumWithTwinSyncSse fill)
      : this(List<SumWithTwinSyncSse>.filled(arraySize, fill));
}
