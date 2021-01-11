import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:post/models/enums/reactTypeEnum.dart';

void main() {
  test("convert enum to string", () {
    var result = EnumToString.convertToString(ReactType.Love);
    expect(result, "Love");
  });
  test('convert string to enum', () {
    var result = EnumToString.fromString(ReactType.values, 'Love');
    expect(result, ReactType.Love);
  });
  test('convert wrong string to enum', () {
    var result = EnumToString.fromString(ReactType.values, 'ReactType.Love');
    expect(result, null);
  });
}
