// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.20.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'pseudo_manual/rust_auto_opaque_twin_rust_async.dart';

Future<void> rustAutoOpaqueArgOwnTwinNormal(
        {required NonCloneSimpleTwinNormal arg,
        required int expect,
        dynamic hint}) =>
    RustLib.instance.api
        .rustAutoOpaqueArgOwnTwinNormal(arg: arg, expect: expect, hint: hint);

Future<void> rustAutoOpaqueArgBorrowTwinNormal(
        {required NonCloneSimpleTwinNormal arg,
        required int expect,
        dynamic hint}) =>
    RustLib.instance.api.rustAutoOpaqueArgBorrowTwinNormal(
        arg: arg, expect: expect, hint: hint);

Future<void> rustAutoOpaqueArgMutBorrowTwinNormal(
        {required NonCloneSimpleTwinNormal arg,
        required int expect,
        required int adder,
        dynamic hint}) =>
    RustLib.instance.api.rustAutoOpaqueArgMutBorrowTwinNormal(
        arg: arg, expect: expect, adder: adder, hint: hint);

Future<NonCloneSimpleTwinNormal> rustAutoOpaqueReturnOwnTwinNormal(
        {required int initial, dynamic hint}) =>
    RustLib.instance.api
        .rustAutoOpaqueReturnOwnTwinNormal(initial: initial, hint: hint);

Future<NonCloneSimpleTwinNormal> rustAutoOpaqueArgOwnAndReturnOwnTwinNormal(
        {required NonCloneSimpleTwinNormal arg, dynamic hint}) =>
    RustLib.instance.api
        .rustAutoOpaqueArgOwnAndReturnOwnTwinNormal(arg: arg, hint: hint);

Future<void> rustAutoOpaqueTwoArgsTwinNormal(
        {required NonCloneSimpleTwinNormal a,
        required NonCloneSimpleTwinNormal b,
        dynamic hint}) =>
    RustLib.instance.api
        .rustAutoOpaqueTwoArgsTwinNormal(a: a, b: b, hint: hint);

Future<void> rustAutoOpaqueNormalAndOpaqueArgTwinNormal(
        {required NonCloneSimpleTwinNormal a,
        required String b,
        dynamic hint}) =>
    RustLib.instance.api
        .rustAutoOpaqueNormalAndOpaqueArgTwinNormal(a: a, b: b, hint: hint);

/// "+" inside the type signature
Future<void> rustAutoOpaquePlusSignArgTwinNormal(
        {required BoxMyTraitTwinNormal arg, dynamic hint}) =>
    RustLib.instance.api
        .rustAutoOpaquePlusSignArgTwinNormal(arg: arg, hint: hint);

Future<BoxMyTraitTwinNormal> rustAutoOpaquePlusSignReturnTwinNormal(
        {dynamic hint}) =>
    RustLib.instance.api.rustAutoOpaquePlusSignReturnTwinNormal(hint: hint);

Future<void> rustAutoOpaqueCallableArgTwinNormal(
        {required BoxFnStringString arg, dynamic hint}) =>
    RustLib.instance.api
        .rustAutoOpaqueCallableArgTwinNormal(arg: arg, hint: hint);

Future<BoxFnStringString> rustAutoOpaqueCallableReturnTwinNormal(
        {dynamic hint}) =>
    RustLib.instance.api.rustAutoOpaqueCallableReturnTwinNormal(hint: hint);

Future<void> rustAutoOpaqueTraitObjectArgOwnTwinNormal(
        {required BoxHelloTraitTwinNormal arg,
        required String expect,
        dynamic hint}) =>
    RustLib.instance.api.rustAutoOpaqueTraitObjectArgOwnTwinNormal(
        arg: arg, expect: expect, hint: hint);

Future<void> rustAutoOpaqueTraitObjectArgBorrowTwinNormal(
        {required BoxHelloTraitTwinNormal arg,
        required String expect,
        dynamic hint}) =>
    RustLib.instance.api.rustAutoOpaqueTraitObjectArgBorrowTwinNormal(
        arg: arg, expect: expect, hint: hint);

Future<void> rustAutoOpaqueTraitObjectArgMutBorrowTwinNormal(
        {required BoxHelloTraitTwinNormal arg,
        required String expect,
        dynamic hint}) =>
    RustLib.instance.api.rustAutoOpaqueTraitObjectArgMutBorrowTwinNormal(
        arg: arg, expect: expect, hint: hint);

Future<BoxHelloTraitTwinNormal> rustAutoOpaqueTraitObjectReturnOwnOneTwinNormal(
        {dynamic hint}) =>
    RustLib.instance.api
        .rustAutoOpaqueTraitObjectReturnOwnOneTwinNormal(hint: hint);

Future<BoxHelloTraitTwinNormal> rustAutoOpaqueTraitObjectReturnOwnTwoTwinNormal(
        {dynamic hint}) =>
    RustLib.instance.api
        .rustAutoOpaqueTraitObjectReturnOwnTwoTwinNormal(hint: hint);

Future<void> rustAutoOpaqueStructWithGoodAndOpaqueFieldArgOwnTwinNormal(
        {required StructWithGoodAndOpaqueFieldTwinNormal arg, dynamic hint}) =>
    RustLib.instance.api
        .rustAutoOpaqueStructWithGoodAndOpaqueFieldArgOwnTwinNormal(
            arg: arg, hint: hint);

Future<StructWithGoodAndOpaqueFieldTwinNormal>
    rustAutoOpaqueStructWithGoodAndOpaqueFieldReturnOwnTwinNormal(
            {dynamic hint}) =>
        RustLib.instance.api
            .rustAutoOpaqueStructWithGoodAndOpaqueFieldReturnOwnTwinNormal(
                hint: hint);

Future<void> rustAutoOpaqueArgVecOwnTwinNormal(
        {required List<NonCloneSimpleTwinNormal> arg,
        required List<int> expect,
        dynamic hint}) =>
    RustLib.instance.api.rustAutoOpaqueArgVecOwnTwinNormal(
        arg: arg, expect: expect, hint: hint);

Future<List<NonCloneSimpleTwinNormal>> rustAutoOpaqueReturnVecOwnTwinNormal(
        {dynamic hint}) =>
    RustLib.instance.api.rustAutoOpaqueReturnVecOwnTwinNormal(hint: hint);

Future<void> rustAutoOpaqueExplicitArgTwinNormal(
        {required NonCloneSimpleTwinNormal arg,
        required int expect,
        dynamic hint}) =>
    RustLib.instance.api.rustAutoOpaqueExplicitArgTwinNormal(
        arg: arg, expect: expect, hint: hint);

Future<void> rustAutoOpaqueExplicitStructTwinNormal(
        {required StructWithExplicitAutoOpaqueFieldTwinNormal arg,
        dynamic hint}) =>
    RustLib.instance.api
        .rustAutoOpaqueExplicitStructTwinNormal(arg: arg, hint: hint);

Future<NonCloneSimpleTwinNormal> rustAutoOpaqueExplicitReturnTwinNormal(
        {required int initial, dynamic hint}) =>
    RustLib.instance.api
        .rustAutoOpaqueExplicitReturnTwinNormal(initial: initial, hint: hint);

Future<(OpaqueOneTwinNormal, OpaqueTwoTwinNormal)>
    rustAutoOpaqueReturnOpaqueOneAndTwoTwinNormal({dynamic hint}) =>
        RustLib.instance.api
            .rustAutoOpaqueReturnOpaqueOneAndTwoTwinNormal(hint: hint);

Future<OpaqueTwoTwinNormal> rustAutoOpaqueReturnOpaqueTwoTwinNormal(
        {dynamic hint}) =>
    RustLib.instance.api.rustAutoOpaqueReturnOpaqueTwoTwinNormal(hint: hint);

Future<int> rustAutoOpaqueBorrowAndMutBorrowTwinNormal(
        {required NonCloneSimpleTwinNormal borrow,
        required NonCloneSimpleTwinNormal mutBorrow,
        dynamic hint}) =>
    RustLib.instance.api.rustAutoOpaqueBorrowAndMutBorrowTwinNormal(
        borrow: borrow, mutBorrow: mutBorrow, hint: hint);

Future<int> rustAutoOpaqueBorrowAndBorrowTwinNormal(
        {required NonCloneSimpleTwinNormal a,
        required NonCloneSimpleTwinNormal b,
        dynamic hint}) =>
    RustLib.instance.api
        .rustAutoOpaqueBorrowAndBorrowTwinNormal(a: a, b: b, hint: hint);

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::rust_async::RwLock<Box < dyn HelloTraitTwinNormal >>>
@sealed
class BoxHelloTraitTwinNormal extends RustOpaque {
  BoxHelloTraitTwinNormal.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  BoxHelloTraitTwinNormal.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: RustLib
        .instance.api.rust_arc_increment_strong_count_BoxHelloTraitTwinNormal,
    rustArcDecrementStrongCount: RustLib
        .instance.api.rust_arc_decrement_strong_count_BoxHelloTraitTwinNormal,
    rustArcDecrementStrongCountPtr: RustLib.instance.api
        .rust_arc_decrement_strong_count_BoxHelloTraitTwinNormalPtr,
  );
}

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::rust_async::RwLock<Box < dyn MyTraitTwinNormal + Send + Sync >>>
@sealed
class BoxMyTraitTwinNormal extends RustOpaque {
  BoxMyTraitTwinNormal.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  BoxMyTraitTwinNormal.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: RustLib
        .instance.api.rust_arc_increment_strong_count_BoxMyTraitTwinNormal,
    rustArcDecrementStrongCount: RustLib
        .instance.api.rust_arc_decrement_strong_count_BoxMyTraitTwinNormal,
    rustArcDecrementStrongCountPtr: RustLib
        .instance.api.rust_arc_decrement_strong_count_BoxMyTraitTwinNormalPtr,
  );
}

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::rust_async::RwLock<NonCloneSimpleTwinNormal>>
@sealed
class NonCloneSimpleTwinNormal extends RustOpaque {
  NonCloneSimpleTwinNormal.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  NonCloneSimpleTwinNormal.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: RustLib
        .instance.api.rust_arc_increment_strong_count_NonCloneSimpleTwinNormal,
    rustArcDecrementStrongCount: RustLib
        .instance.api.rust_arc_decrement_strong_count_NonCloneSimpleTwinNormal,
    rustArcDecrementStrongCountPtr: RustLib.instance.api
        .rust_arc_decrement_strong_count_NonCloneSimpleTwinNormalPtr,
  );

  Future<void> instanceMethodArgBorrowTwinNormal({dynamic hint}) =>
      RustLib.instance.api
          .nonCloneSimpleTwinNormalInstanceMethodArgBorrowTwinNormal(
        that: this,
      );

  Future<void> instanceMethodArgMutBorrowTwinNormal({dynamic hint}) =>
      RustLib.instance.api
          .nonCloneSimpleTwinNormalInstanceMethodArgMutBorrowTwinNormal(
        that: this,
      );

  Future<void> instanceMethodArgOwnTwinNormal({dynamic hint}) =>
      RustLib.instance.api
          .nonCloneSimpleTwinNormalInstanceMethodArgOwnTwinNormal(
        that: this,
      );

  Future<int> get instanceMethodGetterTwinNormal => RustLib.instance.api
          .nonCloneSimpleTwinNormalInstanceMethodGetterTwinNormal(
        that: this,
      );

  Future<NonCloneSimpleTwinNormal> instanceMethodReturnOwnTwinNormal(
          {dynamic hint}) =>
      RustLib.instance.api
          .nonCloneSimpleTwinNormalInstanceMethodReturnOwnTwinNormal(
        that: this,
      );

  /// named constructor
  static Future<NonCloneSimpleTwinNormal> newCustomNameTwinNormal(
          {dynamic hint}) =>
      RustLib.instance.api
          .nonCloneSimpleTwinNormalNewCustomNameTwinNormal(hint: hint);

  /// unnamed constructor
  static Future<NonCloneSimpleTwinNormal> newTwinNormal({dynamic hint}) =>
      RustLib.instance.api.nonCloneSimpleTwinNormalNewTwinNormal(hint: hint);

  /// constructor with Result
  static Future<NonCloneSimpleTwinNormal> newWithResultTwinNormal(
          {dynamic hint}) =>
      RustLib.instance.api
          .nonCloneSimpleTwinNormalNewWithResultTwinNormal(hint: hint);

  static Future<void> staticMethodArgBorrowTwinNormal(
          {required NonCloneSimpleTwinNormal arg, dynamic hint}) =>
      RustLib.instance.api
          .nonCloneSimpleTwinNormalStaticMethodArgBorrowTwinNormal(
              arg: arg, hint: hint);

  static Future<void> staticMethodArgMutBorrowTwinNormal(
          {required NonCloneSimpleTwinNormal arg, dynamic hint}) =>
      RustLib.instance.api
          .nonCloneSimpleTwinNormalStaticMethodArgMutBorrowTwinNormal(
              arg: arg, hint: hint);

  static Future<void> staticMethodArgOwnTwinNormal(
          {required NonCloneSimpleTwinNormal arg, dynamic hint}) =>
      RustLib.instance.api.nonCloneSimpleTwinNormalStaticMethodArgOwnTwinNormal(
          arg: arg, hint: hint);

  static Future<NonCloneSimpleTwinNormal> staticMethodReturnOwnTwinNormal(
          {dynamic hint}) =>
      RustLib.instance.api
          .nonCloneSimpleTwinNormalStaticMethodReturnOwnTwinNormal(hint: hint);
}

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::rust_async::RwLock<OpaqueOneTwinNormal>>
@sealed
class OpaqueOneTwinNormal extends RustOpaque {
  OpaqueOneTwinNormal.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  OpaqueOneTwinNormal.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: RustLib
        .instance.api.rust_arc_increment_strong_count_OpaqueOneTwinNormal,
    rustArcDecrementStrongCount: RustLib
        .instance.api.rust_arc_decrement_strong_count_OpaqueOneTwinNormal,
    rustArcDecrementStrongCountPtr: RustLib
        .instance.api.rust_arc_decrement_strong_count_OpaqueOneTwinNormalPtr,
  );
}

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::rust_async::RwLock<OpaqueTwoTwinNormal>>
@sealed
class OpaqueTwoTwinNormal extends RustOpaque {
  OpaqueTwoTwinNormal.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  OpaqueTwoTwinNormal.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: RustLib
        .instance.api.rust_arc_increment_strong_count_OpaqueTwoTwinNormal,
    rustArcDecrementStrongCount: RustLib
        .instance.api.rust_arc_decrement_strong_count_OpaqueTwoTwinNormal,
    rustArcDecrementStrongCountPtr: RustLib
        .instance.api.rust_arc_decrement_strong_count_OpaqueTwoTwinNormalPtr,
  );
}

class StructWithExplicitAutoOpaqueFieldTwinNormal {
  final NonCloneSimpleTwinNormal autoOpaque;
  final int normal;

  const StructWithExplicitAutoOpaqueFieldTwinNormal({
    required this.autoOpaque,
    required this.normal,
  });

  @override
  int get hashCode => autoOpaque.hashCode ^ normal.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StructWithExplicitAutoOpaqueFieldTwinNormal &&
          runtimeType == other.runtimeType &&
          autoOpaque == other.autoOpaque &&
          normal == other.normal;
}

class StructWithGoodAndOpaqueFieldTwinNormal {
  final String good;
  final NonCloneSimpleTwinNormal opaque;

  const StructWithGoodAndOpaqueFieldTwinNormal({
    required this.good,
    required this.opaque,
  });

  @override
  int get hashCode => good.hashCode ^ opaque.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StructWithGoodAndOpaqueFieldTwinNormal &&
          runtimeType == other.runtimeType &&
          good == other.good &&
          opaque == other.opaque;
}
