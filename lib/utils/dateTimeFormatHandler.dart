import 'package:flutter/cupertino.dart';

class DateTimeFormatHandler {
  @visibleForTesting
  static DateTime now = DateTime.now();

  static String getDurationFromTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    now = DateTime.now();
    return getDurationFromDateTime(dateTime);
  }

  static String getDurationFromDateTime(DateTime dateTime) {
    now = DateTime.now();
    if (_isDateTimeInTheFuture(dateTime))
      throw Exception("Invalid datetime: this Time didn't come yet");
    else if (_isNow(dateTime))
      return 'now';
    else if (_isLessThan1min(dateTime)) {
      int difference = DateTime.now().difference(dateTime).inSeconds;
      return '${difference}s';
    } else if (_isLessThan1hour(dateTime)) {
      int difference = DateTime.now().difference(dateTime).inMinutes;
      return '${difference}m';
    } else if (_isLessThan24hours(dateTime)) {
      int difference = DateTime.now().difference(dateTime).inHours;
      return '${difference}h';
    } else if (_isLessThan7Days(dateTime)) {
      int difference = DateTime.now().difference(dateTime).inDays;
      return '${difference}d';
    } else {
      return (dateTime.year == DateTime.now().year)
          ? '${getMonthName(dateTime.month)} ${dateTime.day}'
          : '${dateTime.year} ${getMonthName(dateTime.month)} ${dateTime.day}';
    }
  }

  static bool _isNow(DateTime dateTime) {
    DateTime earlier50sec = DateTime.now().subtract(Duration(seconds: 50));
    var forServerDelayError = Duration(seconds: 20);
    var timeNow = DateTime.now().add(forServerDelayError);
    return dateTime.isAfter(earlier50sec) && dateTime.isBefore(timeNow);
  }

  static bool _isLessThan1min(DateTime dateTime) {
    DateTime earlier1Min = DateTime.now().subtract(Duration(minutes: 1));
    return dateTime.isAfter(earlier1Min);
  }

  static bool _isLessThan1hour(DateTime dateTime) {
    DateTime earlier1hour = DateTime.now().subtract(Duration(hours: 1));
    return dateTime.isAfter(earlier1hour);
  }

  static bool _isLessThan24hours(DateTime dateTime) {
    DateTime earlier24hours = DateTime.now().subtract(Duration(hours: 24));
    return dateTime.isAfter(earlier24hours);
  }

  static bool _isLessThan7Days(DateTime dateTime) {
    DateTime earlier7Days = DateTime.now().subtract(Duration(days: 7));
    return dateTime.isAfter(earlier7Days);
  }

  static bool _isDateTimeInTheFuture(DateTime dateTime) =>
      dateTime.isAfter(DateTime.now().add(Duration(seconds: 15)));
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    case 12:
      return "Dec";
    default:
      throw Exception("Invalid month number: you exceed the limits [1:12].");
  }
}
