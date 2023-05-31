// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.77.1.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';
import 'bridge_generated_shares.dart';
export 'bridge_generated_shares.dart';
import 'bridge_generated_shares.io.dart';
import 'dart:ffi' as ffi;

class BridgeGeneratedSharesPlatform extends FlutterRustBridgeBase<BridgeGeneratedSharesWire> {
  BridgeGeneratedSharesPlatform(ffi.DynamicLibrary dylib) : super(BridgeGeneratedSharesWire(dylib));

// Section: api2wire

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_String(String raw) {
    return api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  @protected
  ffi.Pointer<wire_float_32_list> api2wire_ZeroCopyBuffer_Float32List(Float32List raw) {
    return api2wire_float_32_list(raw);
  }

  @protected
  ffi.Pointer<wire_CrossSharedStructInBlock1And2> api2wire_box_autoadd_cross_shared_struct_in_block_1_and_2(
      CrossSharedStructInBlock1And2 raw) {
    final ptr = inner.new_box_autoadd_cross_shared_struct_in_block_1_and_2();
    api_fill_to_wire_cross_shared_struct_in_block_1_and_2(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_CrossSharedStructInBlock2And3> api2wire_box_autoadd_cross_shared_struct_in_block_2_and_3(
      CrossSharedStructInBlock2And3 raw) {
    final ptr = inner.new_box_autoadd_cross_shared_struct_in_block_2_and_3();
    api_fill_to_wire_cross_shared_struct_in_block_2_and_3(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<ffi.Double> api2wire_box_autoadd_f64(double raw) {
    return inner.new_box_autoadd_f64(api2wire_f64(raw));
  }

  @protected
  ffi.Pointer<ffi.Int32> api2wire_box_autoadd_i32(int raw) {
    return inner.new_box_autoadd_i32(api2wire_i32(raw));
  }

  @protected
  ffi.Pointer<wire_SharedStructInAllBlocks> api2wire_box_autoadd_shared_struct_in_all_blocks(
      SharedStructInAllBlocks raw) {
    final ptr = inner.new_box_autoadd_shared_struct_in_all_blocks();
    api_fill_to_wire_shared_struct_in_all_blocks(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_SharedStructInBlock1And2> api2wire_box_autoadd_shared_struct_in_block_1_and_2(
      SharedStructInBlock1And2 raw) {
    final ptr = inner.new_box_autoadd_shared_struct_in_block_1_and_2();
    api_fill_to_wire_shared_struct_in_block_1_and_2(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_SharedStructInBlock2And3> api2wire_box_autoadd_shared_struct_in_block_2_and_3(
      SharedStructInBlock2And3 raw) {
    final ptr = inner.new_box_autoadd_shared_struct_in_block_2_and_3();
    api_fill_to_wire_shared_struct_in_block_2_and_3(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_SharedStructOnlyForSyncTest> api2wire_box_autoadd_shared_struct_only_for_sync_test(
      SharedStructOnlyForSyncTest raw) {
    final ptr = inner.new_box_autoadd_shared_struct_only_for_sync_test();
    api_fill_to_wire_shared_struct_only_for_sync_test(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_EnumType> api2wire_box_enum_type(EnumType raw) {
    final ptr = inner.new_box_enum_type();
    api_fill_to_wire_enum_type(raw, ptr.ref);
    return ptr;
  }

  @protected
  ffi.Pointer<wire_float_32_list> api2wire_float_32_list(Float32List raw) {
    final ans = inner.new_float_32_list(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }

  @protected
  ffi.Pointer<wire_list_enum_type> api2wire_list_enum_type(List<EnumType> raw) {
    final ans = inner.new_list_enum_type(raw.length);
    for (var i = 0; i < raw.length; ++i) {
      api_fill_to_wire_enum_type(raw[i], ans.ref.ptr[i]);
    }
    return ans;
  }

  @protected
  ffi.Pointer<ffi.Int32> api2wire_opt_box_autoadd_i32(int? raw) {
    return raw == null ? ffi.nullptr : api2wire_box_autoadd_i32(raw);
  }

  @protected
  ffi.Pointer<wire_list_enum_type> api2wire_opt_list_enum_type(List<EnumType>? raw) {
    return raw == null ? ffi.nullptr : api2wire_list_enum_type(raw);
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_opt_uint_8_list(Uint8List? raw) {
    return raw == null ? ffi.nullptr : api2wire_uint_8_list(raw);
  }

  @protected
  int api2wire_u64(int raw) {
    return raw;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_u8_array_3(U8Array3 raw) {
    final ans = inner.new_uint_8_list(3);
    ans.ref.ptr.asTypedList(3).setAll(0, raw);
    return ans;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }

// Section: finalizer

// Section: api_fill_to_wire

  void api_fill_to_wire_box_autoadd_cross_shared_struct_in_block_1_and_2(
      CrossSharedStructInBlock1And2 apiObj, ffi.Pointer<wire_CrossSharedStructInBlock1And2> wireObj) {
    api_fill_to_wire_cross_shared_struct_in_block_1_and_2(apiObj, wireObj.ref);
  }

  void api_fill_to_wire_box_autoadd_cross_shared_struct_in_block_2_and_3(
      CrossSharedStructInBlock2And3 apiObj, ffi.Pointer<wire_CrossSharedStructInBlock2And3> wireObj) {
    api_fill_to_wire_cross_shared_struct_in_block_2_and_3(apiObj, wireObj.ref);
  }

  void api_fill_to_wire_box_autoadd_shared_struct_in_all_blocks(
      SharedStructInAllBlocks apiObj, ffi.Pointer<wire_SharedStructInAllBlocks> wireObj) {
    api_fill_to_wire_shared_struct_in_all_blocks(apiObj, wireObj.ref);
  }

  void api_fill_to_wire_box_autoadd_shared_struct_in_block_1_and_2(
      SharedStructInBlock1And2 apiObj, ffi.Pointer<wire_SharedStructInBlock1And2> wireObj) {
    api_fill_to_wire_shared_struct_in_block_1_and_2(apiObj, wireObj.ref);
  }

  void api_fill_to_wire_box_autoadd_shared_struct_in_block_2_and_3(
      SharedStructInBlock2And3 apiObj, ffi.Pointer<wire_SharedStructInBlock2And3> wireObj) {
    api_fill_to_wire_shared_struct_in_block_2_and_3(apiObj, wireObj.ref);
  }

  void api_fill_to_wire_box_autoadd_shared_struct_only_for_sync_test(
      SharedStructOnlyForSyncTest apiObj, ffi.Pointer<wire_SharedStructOnlyForSyncTest> wireObj) {
    api_fill_to_wire_shared_struct_only_for_sync_test(apiObj, wireObj.ref);
  }

  void api_fill_to_wire_box_enum_type(EnumType apiObj, ffi.Pointer<wire_EnumType> wireObj) {
    api_fill_to_wire_enum_type(apiObj, wireObj.ref);
  }

  void api_fill_to_wire_cross_shared_struct_in_block_1_and_2(
      CrossSharedStructInBlock1And2 apiObj, wire_CrossSharedStructInBlock1And2 wireObj) {
    wireObj.name = api2wire_String(apiObj.name);
  }

  void api_fill_to_wire_cross_shared_struct_in_block_2_and_3(
      CrossSharedStructInBlock2And3 apiObj, wire_CrossSharedStructInBlock2And3 wireObj) {
    wireObj.name = api2wire_String(apiObj.name);
  }

  void api_fill_to_wire_enum_type(EnumType apiObj, wire_EnumType wireObj) {
    if (apiObj is EnumType_Empty) {
      wireObj.tag = 0;
      return;
    }
    if (apiObj is EnumType_Primitives) {
      var pre_int32 = api2wire_i32(apiObj.int32);
      var pre_float64 = api2wire_f64(apiObj.float64);
      var pre_boolean = api2wire_bool(apiObj.boolean);
      wireObj.tag = 1;
      wireObj.kind = inner.inflate_EnumType_Primitives();
      wireObj.kind.ref.Primitives.ref.int32 = pre_int32;
      wireObj.kind.ref.Primitives.ref.float64 = pre_float64;
      wireObj.kind.ref.Primitives.ref.boolean = pre_boolean;
      return;
    }
    if (apiObj is EnumType_Nested) {
      var pre_field0 = api2wire_box_enum_type(apiObj.field0);
      wireObj.tag = 2;
      wireObj.kind = inner.inflate_EnumType_Nested();
      wireObj.kind.ref.Nested.ref.field0 = pre_field0;
      return;
    }
    if (apiObj is EnumType_Optional) {
      var pre_field0 = api2wire_opt_box_autoadd_i32(apiObj.field0);
      var pre_field1 = api2wire_opt_uint_8_list(apiObj.field1);
      wireObj.tag = 3;
      wireObj.kind = inner.inflate_EnumType_Optional();
      wireObj.kind.ref.Optional.ref.field0 = pre_field0;
      wireObj.kind.ref.Optional.ref.field1 = pre_field1;
      return;
    }
    if (apiObj is EnumType_Buffer) {
      var pre_field0 = api2wire_ZeroCopyBuffer_Float32List(apiObj.field0);
      wireObj.tag = 4;
      wireObj.kind = inner.inflate_EnumType_Buffer();
      wireObj.kind.ref.Buffer.ref.field0 = pre_field0;
      return;
    }
    if (apiObj is EnumType_Enums) {
      var pre_field0 = api2wire_weekdays(apiObj.field0);
      wireObj.tag = 5;
      wireObj.kind = inner.inflate_EnumType_Enums();
      wireObj.kind.ref.Enums.ref.field0 = pre_field0;
      return;
    }
    if (apiObj is EnumType_BytesArray) {
      var pre_field0 = api2wire_u8_array_3(apiObj.field0);
      wireObj.tag = 6;
      wireObj.kind = inner.inflate_EnumType_BytesArray();
      wireObj.kind.ref.BytesArray.ref.field0 = pre_field0;
      return;
    }
  }

  void api_fill_to_wire_shared_struct_in_all_blocks(
      SharedStructInAllBlocks apiObj, wire_SharedStructInAllBlocks wireObj) {
    wireObj.id = api2wire_i32(apiObj.id);
    wireObj.num = api2wire_f64(apiObj.num);
    wireObj.name = api2wire_String(apiObj.name);
    wireObj.enum_list = api2wire_opt_list_enum_type(apiObj.enumList);
  }

  void api_fill_to_wire_shared_struct_in_block_1_and_2(
      SharedStructInBlock1And2 apiObj, wire_SharedStructInBlock1And2 wireObj) {
    wireObj.id = api2wire_i32(apiObj.id);
    wireObj.num = api2wire_f64(apiObj.num);
    wireObj.name = api2wire_String(apiObj.name);
  }

  void api_fill_to_wire_shared_struct_in_block_2_and_3(
      SharedStructInBlock2And3 apiObj, wire_SharedStructInBlock2And3 wireObj) {
    wireObj.id = api2wire_i32(apiObj.id);
    wireObj.num = api2wire_f64(apiObj.num);
    wireObj.name = api2wire_String(apiObj.name);
  }

  void api_fill_to_wire_shared_struct_only_for_sync_test(
      SharedStructOnlyForSyncTest apiObj, wire_SharedStructOnlyForSyncTest wireObj) {
    wireObj.name = api2wire_String(apiObj.name);
    wireObj.score = api2wire_f64(apiObj.score);
  }
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint

/// generated by flutter_rust_bridge
class BridgeGeneratedSharesWire implements FlutterRustBridgeWireBase {
  @internal
  late final dartApi = DartApiDl(init_frb_dart_api_dl);

  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName) _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  BridgeGeneratedSharesWire(ffi.DynamicLibrary dynamicLibrary) : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  BridgeGeneratedSharesWire.fromLookup(ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName) lookup)
      : _lookup = lookup;

  void store_dart_post_cobject(
    DartPostCObjectFnType ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DartPostCObjectFnType)>>('store_dart_post_cobject');
  late final _store_dart_post_cobject = _store_dart_post_cobjectPtr.asFunction<void Function(DartPostCObjectFnType)>();

  Object get_dart_object(
    int ptr,
  ) {
    return _get_dart_object(
      ptr,
    );
  }

  late final _get_dart_objectPtr = _lookup<ffi.NativeFunction<ffi.Handle Function(ffi.UintPtr)>>('get_dart_object');
  late final _get_dart_object = _get_dart_objectPtr.asFunction<Object Function(int)>();

  void drop_dart_object(
    int ptr,
  ) {
    return _drop_dart_object(
      ptr,
    );
  }

  late final _drop_dart_objectPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.UintPtr)>>('drop_dart_object');
  late final _drop_dart_object = _drop_dart_objectPtr.asFunction<void Function(int)>();

  int new_dart_opaque(
    Object handle,
  ) {
    return _new_dart_opaque(
      handle,
    );
  }

  late final _new_dart_opaquePtr = _lookup<ffi.NativeFunction<ffi.UintPtr Function(ffi.Handle)>>('new_dart_opaque');
  late final _new_dart_opaque = _new_dart_opaquePtr.asFunction<int Function(Object)>();

  int init_frb_dart_api_dl(
    ffi.Pointer<ffi.Void> obj,
  ) {
    return _init_frb_dart_api_dl(
      obj,
    );
  }

  late final _init_frb_dart_api_dlPtr =
      _lookup<ffi.NativeFunction<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>>('init_frb_dart_api_dl');
  late final _init_frb_dart_api_dl = _init_frb_dart_api_dlPtr.asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  ffi.Pointer<wire_CrossSharedStructInBlock1And2> new_box_autoadd_cross_shared_struct_in_block_1_and_2() {
    return _new_box_autoadd_cross_shared_struct_in_block_1_and_2();
  }

  late final _new_box_autoadd_cross_shared_struct_in_block_1_and_2Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_CrossSharedStructInBlock1And2> Function()>>(
          'new_box_autoadd_cross_shared_struct_in_block_1_and_2');
  late final _new_box_autoadd_cross_shared_struct_in_block_1_and_2 =
      _new_box_autoadd_cross_shared_struct_in_block_1_and_2Ptr
          .asFunction<ffi.Pointer<wire_CrossSharedStructInBlock1And2> Function()>();

  ffi.Pointer<wire_CrossSharedStructInBlock2And3> new_box_autoadd_cross_shared_struct_in_block_2_and_3() {
    return _new_box_autoadd_cross_shared_struct_in_block_2_and_3();
  }

  late final _new_box_autoadd_cross_shared_struct_in_block_2_and_3Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_CrossSharedStructInBlock2And3> Function()>>(
          'new_box_autoadd_cross_shared_struct_in_block_2_and_3');
  late final _new_box_autoadd_cross_shared_struct_in_block_2_and_3 =
      _new_box_autoadd_cross_shared_struct_in_block_2_and_3Ptr
          .asFunction<ffi.Pointer<wire_CrossSharedStructInBlock2And3> Function()>();

  ffi.Pointer<ffi.Double> new_box_autoadd_f64(
    double value,
  ) {
    return _new_box_autoadd_f64(
      value,
    );
  }

  late final _new_box_autoadd_f64Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Double> Function(ffi.Double)>>('new_box_autoadd_f64');
  late final _new_box_autoadd_f64 = _new_box_autoadd_f64Ptr.asFunction<ffi.Pointer<ffi.Double> Function(double)>();

  ffi.Pointer<ffi.Int32> new_box_autoadd_i32(
    int value,
  ) {
    return _new_box_autoadd_i32(
      value,
    );
  }

  late final _new_box_autoadd_i32Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Int32> Function(ffi.Int32)>>('new_box_autoadd_i32');
  late final _new_box_autoadd_i32 = _new_box_autoadd_i32Ptr.asFunction<ffi.Pointer<ffi.Int32> Function(int)>();

  ffi.Pointer<wire_SharedStructInAllBlocks> new_box_autoadd_shared_struct_in_all_blocks() {
    return _new_box_autoadd_shared_struct_in_all_blocks();
  }

  late final _new_box_autoadd_shared_struct_in_all_blocksPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_SharedStructInAllBlocks> Function()>>(
          'new_box_autoadd_shared_struct_in_all_blocks');
  late final _new_box_autoadd_shared_struct_in_all_blocks = _new_box_autoadd_shared_struct_in_all_blocksPtr
      .asFunction<ffi.Pointer<wire_SharedStructInAllBlocks> Function()>();

  ffi.Pointer<wire_SharedStructInBlock1And2> new_box_autoadd_shared_struct_in_block_1_and_2() {
    return _new_box_autoadd_shared_struct_in_block_1_and_2();
  }

  late final _new_box_autoadd_shared_struct_in_block_1_and_2Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_SharedStructInBlock1And2> Function()>>(
          'new_box_autoadd_shared_struct_in_block_1_and_2');
  late final _new_box_autoadd_shared_struct_in_block_1_and_2 = _new_box_autoadd_shared_struct_in_block_1_and_2Ptr
      .asFunction<ffi.Pointer<wire_SharedStructInBlock1And2> Function()>();

  ffi.Pointer<wire_SharedStructInBlock2And3> new_box_autoadd_shared_struct_in_block_2_and_3() {
    return _new_box_autoadd_shared_struct_in_block_2_and_3();
  }

  late final _new_box_autoadd_shared_struct_in_block_2_and_3Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_SharedStructInBlock2And3> Function()>>(
          'new_box_autoadd_shared_struct_in_block_2_and_3');
  late final _new_box_autoadd_shared_struct_in_block_2_and_3 = _new_box_autoadd_shared_struct_in_block_2_and_3Ptr
      .asFunction<ffi.Pointer<wire_SharedStructInBlock2And3> Function()>();

  ffi.Pointer<wire_SharedStructOnlyForSyncTest> new_box_autoadd_shared_struct_only_for_sync_test() {
    return _new_box_autoadd_shared_struct_only_for_sync_test();
  }

  late final _new_box_autoadd_shared_struct_only_for_sync_testPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_SharedStructOnlyForSyncTest> Function()>>(
          'new_box_autoadd_shared_struct_only_for_sync_test');
  late final _new_box_autoadd_shared_struct_only_for_sync_test = _new_box_autoadd_shared_struct_only_for_sync_testPtr
      .asFunction<ffi.Pointer<wire_SharedStructOnlyForSyncTest> Function()>();

  ffi.Pointer<wire_EnumType> new_box_enum_type() {
    return _new_box_enum_type();
  }

  late final _new_box_enum_typePtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_EnumType> Function()>>('new_box_enum_type');
  late final _new_box_enum_type = _new_box_enum_typePtr.asFunction<ffi.Pointer<wire_EnumType> Function()>();

  ffi.Pointer<wire_float_32_list> new_float_32_list(
    int len,
  ) {
    return _new_float_32_list(
      len,
    );
  }

  late final _new_float_32_listPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_float_32_list> Function(ffi.Int32)>>('new_float_32_list');
  late final _new_float_32_list = _new_float_32_listPtr.asFunction<ffi.Pointer<wire_float_32_list> Function(int)>();

  ffi.Pointer<wire_list_enum_type> new_list_enum_type(
    int len,
  ) {
    return _new_list_enum_type(
      len,
    );
  }

  late final _new_list_enum_typePtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_list_enum_type> Function(ffi.Int32)>>('new_list_enum_type');
  late final _new_list_enum_type = _new_list_enum_typePtr.asFunction<ffi.Pointer<wire_list_enum_type> Function(int)>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list(
    int len,
  ) {
    return _new_uint_8_list(
      len,
    );
  }

  late final _new_uint_8_listPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_uint_8_list> Function(ffi.Int32)>>('new_uint_8_list');
  late final _new_uint_8_list = _new_uint_8_listPtr.asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  ffi.Pointer<EnumTypeKind> inflate_EnumType_Primitives() {
    return _inflate_EnumType_Primitives();
  }

  late final _inflate_EnumType_PrimitivesPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<EnumTypeKind> Function()>>('inflate_EnumType_Primitives');
  late final _inflate_EnumType_Primitives =
      _inflate_EnumType_PrimitivesPtr.asFunction<ffi.Pointer<EnumTypeKind> Function()>();

  ffi.Pointer<EnumTypeKind> inflate_EnumType_Nested() {
    return _inflate_EnumType_Nested();
  }

  late final _inflate_EnumType_NestedPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<EnumTypeKind> Function()>>('inflate_EnumType_Nested');
  late final _inflate_EnumType_Nested = _inflate_EnumType_NestedPtr.asFunction<ffi.Pointer<EnumTypeKind> Function()>();

  ffi.Pointer<EnumTypeKind> inflate_EnumType_Optional() {
    return _inflate_EnumType_Optional();
  }

  late final _inflate_EnumType_OptionalPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<EnumTypeKind> Function()>>('inflate_EnumType_Optional');
  late final _inflate_EnumType_Optional =
      _inflate_EnumType_OptionalPtr.asFunction<ffi.Pointer<EnumTypeKind> Function()>();

  ffi.Pointer<EnumTypeKind> inflate_EnumType_Buffer() {
    return _inflate_EnumType_Buffer();
  }

  late final _inflate_EnumType_BufferPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<EnumTypeKind> Function()>>('inflate_EnumType_Buffer');
  late final _inflate_EnumType_Buffer = _inflate_EnumType_BufferPtr.asFunction<ffi.Pointer<EnumTypeKind> Function()>();

  ffi.Pointer<EnumTypeKind> inflate_EnumType_Enums() {
    return _inflate_EnumType_Enums();
  }

  late final _inflate_EnumType_EnumsPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<EnumTypeKind> Function()>>('inflate_EnumType_Enums');
  late final _inflate_EnumType_Enums = _inflate_EnumType_EnumsPtr.asFunction<ffi.Pointer<EnumTypeKind> Function()>();

  ffi.Pointer<EnumTypeKind> inflate_EnumType_BytesArray() {
    return _inflate_EnumType_BytesArray();
  }

  late final _inflate_EnumType_BytesArrayPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<EnumTypeKind> Function()>>('inflate_EnumType_BytesArray');
  late final _inflate_EnumType_BytesArray =
      _inflate_EnumType_BytesArrayPtr.asFunction<ffi.Pointer<EnumTypeKind> Function()>();

  void free_WireSyncReturn(
    WireSyncReturn ptr,
  ) {
    return _free_WireSyncReturn(
      ptr,
    );
  }

  late final _free_WireSyncReturnPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturn)>>('free_WireSyncReturn');
  late final _free_WireSyncReturn = _free_WireSyncReturnPtr.asFunction<void Function(WireSyncReturn)>();
}

final class _Dart_Handle extends ffi.Opaque {}

final class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_CrossSharedStructInBlock1And2 extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> name;
}

final class wire_CrossSharedStructInBlock2And3 extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> name;
}

final class wire_EnumType_Empty extends ffi.Opaque {}

final class wire_EnumType_Primitives extends ffi.Struct {
  @ffi.Int32()
  external int int32;

  @ffi.Double()
  external double float64;

  @ffi.Bool()
  external bool boolean;
}

final class wire_EnumType_Nested extends ffi.Struct {
  external ffi.Pointer<wire_EnumType> field0;
}

final class wire_EnumType extends ffi.Struct {
  @ffi.Int32()
  external int tag;

  external ffi.Pointer<EnumTypeKind> kind;
}

final class EnumTypeKind extends ffi.Union {
  external ffi.Pointer<wire_EnumType_Empty> Empty;

  external ffi.Pointer<wire_EnumType_Primitives> Primitives;

  external ffi.Pointer<wire_EnumType_Nested> Nested;

  external ffi.Pointer<wire_EnumType_Optional> Optional;

  external ffi.Pointer<wire_EnumType_Buffer> Buffer;

  external ffi.Pointer<wire_EnumType_Enums> Enums;

  external ffi.Pointer<wire_EnumType_BytesArray> BytesArray;
}

final class wire_EnumType_Optional extends ffi.Struct {
  external ffi.Pointer<ffi.Int32> field0;

  external ffi.Pointer<wire_uint_8_list> field1;
}

final class wire_EnumType_Buffer extends ffi.Struct {
  external ffi.Pointer<wire_float_32_list> field0;
}

final class wire_float_32_list extends ffi.Struct {
  external ffi.Pointer<ffi.Float> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_EnumType_Enums extends ffi.Struct {
  @ffi.Int32()
  external int field0;
}

final class wire_EnumType_BytesArray extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> field0;
}

final class wire_list_enum_type extends ffi.Struct {
  external ffi.Pointer<wire_EnumType> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_SharedStructInAllBlocks extends ffi.Struct {
  @ffi.Int32()
  external int id;

  @ffi.Double()
  external double num;

  external ffi.Pointer<wire_uint_8_list> name;

  external ffi.Pointer<wire_list_enum_type> enum_list;
}

final class wire_SharedStructInBlock1And2 extends ffi.Struct {
  @ffi.Int32()
  external int id;

  @ffi.Double()
  external double num;

  external ffi.Pointer<wire_uint_8_list> name;
}

final class wire_SharedStructInBlock2And3 extends ffi.Struct {
  @ffi.Int32()
  external int id;

  @ffi.Double()
  external double num;

  external ffi.Pointer<wire_uint_8_list> name;
}

final class wire_SharedStructOnlyForSyncTest extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> name;

  @ffi.Double()
  external double score;
}

typedef DartPostCObjectFnType
    = ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(DartPort port_id, ffi.Pointer<ffi.Void> message)>>;
typedef DartPort = ffi.Int64;
