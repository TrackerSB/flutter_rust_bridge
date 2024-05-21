// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.35.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'misc_no_twin_example_a.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Future<void> sameFunctionNameInDifferentFiles({dynamic hint}) =>
    RustLib.instance.api
        .crateApiMiscNoTwinExampleBSameFunctionNameInDifferentFiles(hint: hint);

// Rust type: RustOpaqueNom<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<StructInMiscNoTwinExampleB>>
@sealed
class StructInMiscNoTwinExampleB extends RustOpaque {
  StructInMiscNoTwinExampleB.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  StructInMiscNoTwinExampleB.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: RustLib.instance.api
        .rust_arc_increment_strong_count_StructInMiscNoTwinExampleB,
    rustArcDecrementStrongCount: RustLib.instance.api
        .rust_arc_decrement_strong_count_StructInMiscNoTwinExampleB,
    rustArcDecrementStrongCountPtr: RustLib.instance.api
        .rust_arc_decrement_strong_count_StructInMiscNoTwinExampleBPtr,
  );

  Future<StructInMiscNoTwinExampleA> getStructInMiscNoTwinExampleA(
          {dynamic hint}) =>
      RustLib.instance.api
          .crateApiMiscNoTwinExampleBStructInMiscNoTwinExampleBGetStructInMiscNoTwinExampleA(
              that: this, hint: hint);

  Future<void> sampleFunctionB({dynamic hint}) => RustLib.instance.api
      .crateApiMiscNoTwinExampleBStructInMiscNoTwinExampleBSampleFunctionB(
          that: this, hint: hint);
}

class StructWithImplBlockInAnotherFileDependency {
  const StructWithImplBlockInAnotherFileDependency();

  @override
  int get hashCode => 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StructWithImplBlockInAnotherFileDependency &&
          runtimeType == other.runtimeType;
}
