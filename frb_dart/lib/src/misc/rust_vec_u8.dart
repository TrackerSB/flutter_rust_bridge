import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:flutter_rust_bridge/src/generalized_frb_rust_binding/generalized_frb_rust_binding.dart';

/// The Rust `std::Vec<u8>` on the Dart side.
/// Must call `dispose` manually, otherwise the memory will be leaked.
class RustVecU8 {
  /// Null = already disposed (to avoid accidential double free)
  ffi.Pointer<ffi.Uint8>? _ptr;

  /// {@macro flutter_rust_bridge.internal}
  final int length;

  /// {@macro flutter_rust_bridge.internal}
  final GeneralizedFrbRustBinding binding;

  /// {@macro flutter_rust_bridge.internal}
  RustVecU8(this.length, this.binding) : _ptr = binding.rustVecU8New(length);

  /// {@macro flutter_rust_bridge.internal}
  void dispose() {
    final ptr = _ptr!;
    _ptr = null;
    // Set ptr to null before calling free to avoid potential
    // double-free when error happens
    binding.rustVecU8Free(ptr, length);
  }

  /// {@macro flutter_rust_bridge.internal}
  void operator []=(int index, int value) {
    _ptr![index] = value;
  }

  /// {@macro flutter_rust_bridge.internal}
  void setRange(int start, int end, Iterable<E> iterable) {
    TODO;
  }
}
