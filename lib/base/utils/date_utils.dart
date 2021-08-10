import 'package:intl/intl.dart';

class DateConstants {
  static const String apiDateFormat = "yyyy-MM-dd HH:mm:ss";
  static const String commonDateFormat = "yyyy-MM-dd";
  static const String commonTimeFormat = "hh:mm a";
  static const String eventDateFormat = "dd MMM,yyyy";
  static const String getDay = "dd";
  static const String getMonth = "MMM";
}

String dateToString(DateTime date,
    {String dateFormat = DateConstants.commonDateFormat}) {
  return DateFormat(dateFormat).format(date);
}

DateTime stringToDate(String dateString,
    {String dateFormat = DateConstants.apiDateFormat}) {
  try {
    return DateFormat(dateFormat).parse(dateString);
  } on Exception catch (_) {
    return DateTime.now();
  }
}

// convert date from API response to app date format
String getConvertedDate(String dateString,
    {String dateFormat = DateConstants.commonDateFormat}) {
  try {
    var dateTime =
        DateFormat(DateConstants.commonDateFormat).parse(dateString, true);
    var formattedDate = DateFormat(dateFormat).format(dateTime.toLocal());
    return formattedDate;
  } on Exception catch (_) {
    return "";
  }
}

// convert date from API response to app time format
String getConvertedTime(String dateString) {
  try {
    var dateTime =
        DateFormat(DateConstants.apiDateFormat).parse(dateString, true);
    var formattedDate =
        DateFormat(DateConstants.commonTimeFormat).format(dateTime.toLocal());
    return formattedDate;
  } on Exception catch (_) {
    return "";
  }
}
