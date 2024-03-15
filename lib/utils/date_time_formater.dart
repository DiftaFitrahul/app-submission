import 'package:intl/intl.dart';

String dateTimeFormater(String time, String languageCode) {
  DateTime dateTime = DateTime.parse(time);
  final DateFormat formatter = DateFormat('h:mm a, dd MMMM yyyy', languageCode);
  return formatter.format(dateTime);
}
