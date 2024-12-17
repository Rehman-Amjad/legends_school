
import 'package:intl/intl.dart';

class TimeUtils{

  String getMonthYearFromTimestamp({int? timestamp}) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp ?? DateTime.now().millisecondsSinceEpoch);
    // Format the DateTime to "YYYY-MM"
    String formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  String getMonthYearFromCalender(String date){
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy-MM').format(dateTime);
    return formattedDate;
  }

  String formatTimestamp(String timestamp) {
    try {
      int milliseconds = int.parse(timestamp);
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
      String formattedDate = DateFormat('d MMMM yyyy').format(dateTime);
      return formattedDate;
    } catch (e) {
      return 'Invalid Date';
    }
  }

  String formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }


}