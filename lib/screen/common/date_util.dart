import 'package:intl/intl.dart';

class DateUtil {
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');

  static String getDate(DateTime selectedDate) {
   return formatter.format(selectedDate);
  }

  static String getDateWithMonthName(String date) {
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm");
    DateFormat outputFormat = DateFormat("MMMM dd, yyyy hh:mm aaa");
    DateTime parseDate = format.parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    return outputFormat.format(inputDate).toString();
  }

  static String getTime(DateTime dateTime) {
    DateFormat outputFormat = DateFormat("HH:mm");
    return outputFormat.format(dateTime);
  }

  static String getFormattedDate(String date) {
    DateFormat format = DateFormat("yyyy-MM-dd");
    DateFormat outputFormat = DateFormat("MMMM dd, yyyy");
    DateTime parseDate = format.parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    return outputFormat.format(inputDate).toString();
  }
}