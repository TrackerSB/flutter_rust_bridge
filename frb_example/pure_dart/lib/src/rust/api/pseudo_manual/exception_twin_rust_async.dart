// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.39.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
part 'exception_twin_rust_async.freezed.dart';

Future<int> funcReturnErrorTwinRustAsync() => RustLib.instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncFuncReturnErrorTwinRustAsync();

Future<int> funcTypeFalliblePanicTwinRustAsync() => RustLib.instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncFuncTypeFalliblePanicTwinRustAsync();

Future<int> funcTypeInfalliblePanicTwinRustAsync() => RustLib.instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncFuncTypeInfalliblePanicTwinRustAsync();

Future<int> customEnumErrorReturnOkTwinRustAsync({required int arg}) => RustLib
    .instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncCustomEnumErrorReturnOkTwinRustAsync(
        arg: arg);

Future<void> customEnumErrorPanicTwinRustAsync() => RustLib.instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncCustomEnumErrorPanicTwinRustAsync();

Future<int> customEnumErrorReturnErrorTwinRustAsync() => RustLib.instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncCustomEnumErrorReturnErrorTwinRustAsync();

Future<void> customNestedErrorReturnErrorTwinRustAsync(
        {required CustomNestedErrorOuterTwinRustAsync arg}) =>
    RustLib.instance.api
        .crateApiPseudoManualExceptionTwinRustAsyncCustomNestedErrorReturnErrorTwinRustAsync(
            arg: arg);

Future<void> customStructErrorReturnErrorTwinRustAsync(
        {required CustomStructErrorTwinRustAsync arg}) =>
    RustLib.instance.api
        .crateApiPseudoManualExceptionTwinRustAsyncCustomStructErrorReturnErrorTwinRustAsync(
            arg: arg);

Future<int> returnErrCustomErrorTwinRustAsync() => RustLib.instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncReturnErrCustomErrorTwinRustAsync();

Future<int> returnOkCustomErrorTwinRustAsync() => RustLib.instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncReturnOkCustomErrorTwinRustAsync();

Future<int> returnErrorVariantTwinRustAsync({required int variant}) => RustLib
    .instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncReturnErrorVariantTwinRustAsync(
        variant: variant);

Future<void> returnCustomNestedError1TwinRustAsync() => RustLib.instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncReturnCustomNestedError1TwinRustAsync();

Future<void> returnCustomNestedError1Variant1TwinRustAsync() => RustLib
    .instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncReturnCustomNestedError1Variant1TwinRustAsync();

Future<void> returnCustomNestedError2TwinRustAsync() => RustLib.instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncReturnCustomNestedError2TwinRustAsync();

Future<void> returnCustomStructErrorTwinRustAsync() => RustLib.instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncReturnCustomStructErrorTwinRustAsync();

Future<int> returnCustomStructOkTwinRustAsync() => RustLib.instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncReturnCustomStructOkTwinRustAsync();

Future<void> throwAnyhowTwinRustAsync() => RustLib.instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncThrowAnyhowTwinRustAsync();

Future<void> panicWithCustomResultTwinRustAsync() => RustLib.instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncPanicWithCustomResultTwinRustAsync();

Future<Stream<String>> streamSinkThrowAnyhowTwinRustAsync() => RustLib
    .instance.api
    .crateApiPseudoManualExceptionTwinRustAsyncStreamSinkThrowAnyhowTwinRustAsync();

@freezed
sealed class CustomEnumErrorTwinRustAsync
    with _$CustomEnumErrorTwinRustAsync
    implements FrbException {
  const CustomEnumErrorTwinRustAsync._();

  @Implements<FrbBacktracedException>()
  const factory CustomEnumErrorTwinRustAsync.one({
    required String message,
    required String backtrace,
  }) = CustomEnumErrorTwinRustAsync_One;
  @Implements<FrbBacktracedException>()
  const factory CustomEnumErrorTwinRustAsync.two({
    required int message,
    required String backtrace,
  }) = CustomEnumErrorTwinRustAsync_Two;
}

@freezed
sealed class CustomErrorTwinRustAsync
    with _$CustomErrorTwinRustAsync
    implements FrbException {
  const CustomErrorTwinRustAsync._();

  @Implements<FrbBacktracedException>()
  const factory CustomErrorTwinRustAsync.error0({
    required String e,
    required String backtrace,
  }) = CustomErrorTwinRustAsync_Error0;
  @Implements<FrbBacktracedException>()
  const factory CustomErrorTwinRustAsync.error1({
    required int e,
    required String backtrace,
  }) = CustomErrorTwinRustAsync_Error1;
}

@freezed
sealed class CustomNestedError1TwinRustAsync
    with _$CustomNestedError1TwinRustAsync
    implements FrbException {
  const CustomNestedError1TwinRustAsync._();

  const factory CustomNestedError1TwinRustAsync.customNested1(
    String field0,
  ) = CustomNestedError1TwinRustAsync_CustomNested1;
  const factory CustomNestedError1TwinRustAsync.errorNested(
    CustomNestedError2TwinRustAsync field0,
  ) = CustomNestedError1TwinRustAsync_ErrorNested;
}

@freezed
sealed class CustomNestedError2TwinRustAsync
    with _$CustomNestedError2TwinRustAsync {
  const CustomNestedError2TwinRustAsync._();

  const factory CustomNestedError2TwinRustAsync.customNested2(
    String field0,
  ) = CustomNestedError2TwinRustAsync_CustomNested2;
  const factory CustomNestedError2TwinRustAsync.customNested2Number(
    int field0,
  ) = CustomNestedError2TwinRustAsync_CustomNested2Number;
}

@freezed
sealed class CustomNestedErrorInnerTwinRustAsync
    with _$CustomNestedErrorInnerTwinRustAsync {
  const CustomNestedErrorInnerTwinRustAsync._();

  const factory CustomNestedErrorInnerTwinRustAsync.three(
    String field0,
  ) = CustomNestedErrorInnerTwinRustAsync_Three;
  const factory CustomNestedErrorInnerTwinRustAsync.four(
    int field0,
  ) = CustomNestedErrorInnerTwinRustAsync_Four;
}

@freezed
sealed class CustomNestedErrorOuterTwinRustAsync
    with _$CustomNestedErrorOuterTwinRustAsync {
  const CustomNestedErrorOuterTwinRustAsync._();

  const factory CustomNestedErrorOuterTwinRustAsync.one(
    String field0,
  ) = CustomNestedErrorOuterTwinRustAsync_One;
  const factory CustomNestedErrorOuterTwinRustAsync.two(
    CustomNestedErrorInnerTwinRustAsync field0,
  ) = CustomNestedErrorOuterTwinRustAsync_Two;
}

class CustomStructErrorAnotherTwinRustAsync implements FrbException {
  final String message;

  const CustomStructErrorAnotherTwinRustAsync({
    required this.message,
  });

  @override
  int get hashCode => message.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomStructErrorAnotherTwinRustAsync &&
          runtimeType == other.runtimeType &&
          message == other.message;
}

class CustomStructErrorTwinRustAsync {
  final String a;

  const CustomStructErrorTwinRustAsync({
    required this.a,
  });

  @override
  int get hashCode => a.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomStructErrorTwinRustAsync &&
          runtimeType == other.runtimeType &&
          a == other.a;
}

class CustomStructTwinRustAsync {
  final String message;

  const CustomStructTwinRustAsync({
    required this.message,
  });

  static Future<CustomStructTwinRustAsync> newTwinRustAsync(
          {required String message}) =>
      RustLib.instance.api
          .crateApiPseudoManualExceptionTwinRustAsyncCustomStructTwinRustAsyncNewTwinRustAsync(
              message: message);

  Future<void> nonstaticReturnCustomStructErrorTwinRustAsync() =>
      RustLib.instance.api
          .crateApiPseudoManualExceptionTwinRustAsyncCustomStructTwinRustAsyncNonstaticReturnCustomStructErrorTwinRustAsync(
        that: this,
      );

  Future<int> nonstaticReturnCustomStructOkTwinRustAsync() =>
      RustLib.instance.api
          .crateApiPseudoManualExceptionTwinRustAsyncCustomStructTwinRustAsyncNonstaticReturnCustomStructOkTwinRustAsync(
        that: this,
      );

  static Future<void> staticReturnCustomStructErrorTwinRustAsync() => RustLib
      .instance.api
      .crateApiPseudoManualExceptionTwinRustAsyncCustomStructTwinRustAsyncStaticReturnCustomStructErrorTwinRustAsync();

  static Future<int> staticReturnCustomStructOkTwinRustAsync() => RustLib
      .instance.api
      .crateApiPseudoManualExceptionTwinRustAsyncCustomStructTwinRustAsyncStaticReturnCustomStructOkTwinRustAsync();

  @override
  int get hashCode => message.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomStructTwinRustAsync &&
          runtimeType == other.runtimeType &&
          message == other.message;
}

class SomeStructTwinRustAsync {
  final int value;

  const SomeStructTwinRustAsync({
    required this.value,
  });

  static Future<SomeStructTwinRustAsync> newTwinRustAsync(
          {required int value}) =>
      RustLib.instance.api
          .crateApiPseudoManualExceptionTwinRustAsyncSomeStructTwinRustAsyncNewTwinRustAsync(
              value: value);

  Future<int> nonStaticReturnErrCustomErrorTwinRustAsync() =>
      RustLib.instance.api
          .crateApiPseudoManualExceptionTwinRustAsyncSomeStructTwinRustAsyncNonStaticReturnErrCustomErrorTwinRustAsync(
        that: this,
      );

  Future<int> nonStaticReturnOkCustomErrorTwinRustAsync() =>
      RustLib.instance.api
          .crateApiPseudoManualExceptionTwinRustAsyncSomeStructTwinRustAsyncNonStaticReturnOkCustomErrorTwinRustAsync(
        that: this,
      );

  static Future<int> staticReturnErrCustomErrorTwinRustAsync() => RustLib
      .instance.api
      .crateApiPseudoManualExceptionTwinRustAsyncSomeStructTwinRustAsyncStaticReturnErrCustomErrorTwinRustAsync();

  static Future<int> staticReturnOkCustomErrorTwinRustAsync() => RustLib
      .instance.api
      .crateApiPseudoManualExceptionTwinRustAsyncSomeStructTwinRustAsyncStaticReturnOkCustomErrorTwinRustAsync();

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SomeStructTwinRustAsync &&
          runtimeType == other.runtimeType &&
          value == other.value;
}
