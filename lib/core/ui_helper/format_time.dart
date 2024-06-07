import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

String formatDateTime(String time, String format) {
  final DateTime dateTime = DateTime.parse(time);
  return DateFormat(format).format(dateTime);
}

String timeagoFormat(
  String time,
) {
  final DateTime dateTime = DateTime.parse(time);

  final DateTime now = DateTime.now();
  final Duration diff = now.difference(dateTime);
  if (diff.inHours > 24 * 6) {
    return formatDateTime(time, 'dd MMM yyyy hh:mm a');
  }
  return timeago.format(
    dateTime,
    locale: 'en',
  );
}
