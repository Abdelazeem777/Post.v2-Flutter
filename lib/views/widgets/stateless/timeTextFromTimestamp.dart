import 'package:flutter/material.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/dateTimeFormatHandler.dart';

class TimeTextFromTimestamp extends StatelessWidget {
  int _timestamp;
  TimeTextFromTimestamp(this._timestamp);
  @override
  Widget build(BuildContext context) {
    String time = DateTimeFormatHandler.getTimeFromTimestamp(_timestamp);
    return Text(
      time,
      style: TextStyle(color: AppColors.PRIMARY_COLOR, fontSize: 11),
    );
  }
}
