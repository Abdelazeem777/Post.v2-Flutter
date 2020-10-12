import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:post/utils/dateTimeFormatHandler.dart';
import 'package:matcher/matcher.dart' as matcher;

main() {
  DateTime now = DateTimeFormatHandler.now;
  test('test the current time (Now)', () {
    DateTime nowTime = now;
    int nowTimestamp = nowTime.millisecondsSinceEpoch;
    String result =
        DateTimeFormatHandler.getDurationFromTimestamp(nowTimestamp);
    expect(result, 'now');
  });

  test('test time before 50 sec', () {
    DateTime before50SecTime = now.subtract(Duration(seconds: 50));
    int before50SecTimestamp = before50SecTime.millisecondsSinceEpoch;
    String result =
        DateTimeFormatHandler.getDurationFromTimestamp(before50SecTimestamp);
    expect(result, '50s');
  });
  test('test time before 15 min', () {
    DateTime before15MinTime = now.subtract(Duration(minutes: 15));
    int before15MinTimestamp = before15MinTime.millisecondsSinceEpoch;
    String result =
        DateTimeFormatHandler.getDurationFromTimestamp(before15MinTimestamp);
    expect(result, '15m');
  });
  test('test time before 4 hours', () {
    DateTime before4HoursTime = now.subtract(Duration(hours: 4));
    int before4HoursTimestamp = before4HoursTime.millisecondsSinceEpoch;
    String result =
        DateTimeFormatHandler.getDurationFromTimestamp(before4HoursTimestamp);
    expect(result, '4h');
  });
  test('test time before 2 days', () {
    DateTime before2DaysTime = now.subtract(Duration(days: 2));
    int before2DaysTimestamp = before2DaysTime.millisecondsSinceEpoch;
    String result =
        DateTimeFormatHandler.getDurationFromTimestamp(before2DaysTimestamp);
    expect(result, '2d');
  });
  test('test time before 10 days', () {
    DateTime before10DaysTime = now.subtract(Duration(days: 10));
    int before10DaysTimestamp = before10DaysTime.millisecondsSinceEpoch;
    String result =
        DateTimeFormatHandler.getDurationFromTimestamp(before10DaysTimestamp);
    expect(result,
        '${getMonthName(before10DaysTime.month)} ${before10DaysTime.day}');
  });
  test('test time before 90 days', () {
    DateTime before90DaysTime = now.subtract(Duration(days: 90));
    int before90DaysTimestamp = before90DaysTime.millisecondsSinceEpoch;
    String result =
        DateTimeFormatHandler.getDurationFromTimestamp(before90DaysTimestamp);
    expect(result,
        '${getMonthName(before90DaysTime.month)} ${before90DaysTime.day}');
  });
  test('test time before 450 days', () {
    DateTime before450DaysTime = now.subtract(Duration(days: 450));
    int before450DaysTimestamp = before450DaysTime.millisecondsSinceEpoch;
    String result =
        DateTimeFormatHandler.getDurationFromTimestamp(before450DaysTimestamp);
    expect(result,
        '${before450DaysTime.year} ${getMonthName(before450DaysTime.month)} ${before450DaysTime.day}');
  });

  test('test time (failure) after 5 min ', () {
    DateTime nowTime = now.add(Duration(minutes: 5));
    int nowTimestamp = nowTime.millisecondsSinceEpoch;

    expect(() => DateTimeFormatHandler.getDurationFromTimestamp(nowTimestamp),
        throwsA(const matcher.TypeMatcher<Exception>()));
  });
}
