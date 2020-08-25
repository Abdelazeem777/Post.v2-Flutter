class DateTimeFormatHandler {
  static String _formattedDateTime;

  ///TODO: Add the ability to know the passed time by sec, min, hours and  if it's more than 3 days then it should return the date
  static String getTime(DateTime dateTime) {
    dateTime = DateTime.now().subtract(dateTime.timeZoneOffset);
    _formattedDateTime = dateTime.toString();

    return _formattedDateTime;
  }
}
