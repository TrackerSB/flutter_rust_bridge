import 'dart:async';

import 'package:frb_example_dart_minimal/src/rust/frb_generated.dart';
import 'package:js/js.dart';

@JS("wasm_bindgen.my_rust_function")
external void my_rust_function();

Future<void> main() async {
  print('Action: Init rust (before)');
  await RustLib.init();
  print('Action: Init rust (after)');

  print('Dart before call my_rust_function');
  my_rust_function();
  print('Dart after call my_rust_function');

  // print('Action: Configure tests (before)');
  // test('dart call minimalAdder', () async {
  //   print('Action: Call rust (before)');
  //   expect(await minimalAdder(a: 100, b: 200), 300);
  //   print('Action: Call rust (after)');
  // });
  // print('Action: Configure tests (end)');
  //
  // test('temp', () async {
  //   final input = Uint64List(1)..[0] = BigInt.parse('123456789012345678');
  //   expect(await f(a: input), input);
  // });
}
