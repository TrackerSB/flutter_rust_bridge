// FRB_INTERNAL_GENERATOR: {"forbiddenDuplicatorModes": ["sync"]}

import 'package:frb_example_pure_dart/src/rust/api/inside_macro.dart';
import 'package:frb_example_pure_dart/src/rust/frb_generated.dart';
import 'package:test/test.dart';

import '../test_utils.dart';

Future<void> main({bool skipRustLibInit = false}) async {
  if (!skipRustLibInit) await RustLib.init();

  addTestsIdentityFunctionCall(funcMacroStruct, [const MacroStruct(data: 42)]);

  test("macro struct", () async {
    var x = await anotherMacroStruct();
    expect(x.data, 123);
    x.nonFinalData = 321;
    expect(x.nonFinalData, 321);
  });
}
