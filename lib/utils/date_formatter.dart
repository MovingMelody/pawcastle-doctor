import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String get date => _formatDate(this.toString());

  String _formatDate(String date) {
    DateTime now = DateTime.parse(date);
    final DateFormat time = DateFormat('jm');
    final DateFormat customDate = DateFormat('MMM dd');
    final String formattedTime = time.format(now);
    final String formattedDate = customDate.format(now);
    return formattedDate + ", " + formattedTime;
  }

  bool isExpired() {
    var duration = DateTime.now().difference(this);
    return duration.inMilliseconds > 60000;
  }

  String get timestamp => this.millisecondsSinceEpoch.toString();

  // You can only withdraw money in 8hrs intervals
  bool canWithdraw(String epoch) {
    if (epoch.isEmpty) return true;

    var date = DateConverter.getDate(epochString: epoch);
    var duration = difference(date);

    return duration.inHours >= 8;
  }
}

class DateConverter {
  static String getTimestamp({int? epochInt, String? epochString}) {
    var date = DateTime.fromMillisecondsSinceEpoch(
        (epochInt ?? int.parse(epochString!)));
    return date.toString();
  }

  static DateTime getDate({int? epochInt, String? epochString}) {
    return DateTime.fromMillisecondsSinceEpoch(
        (epochInt ?? int.parse(epochString!)));
  }

  static String formatted({int? epochInt, String? epochString}) {
    return DateTime.fromMillisecondsSinceEpoch(
            (epochInt ?? int.parse(epochString!)))
        .date;
  }
}
