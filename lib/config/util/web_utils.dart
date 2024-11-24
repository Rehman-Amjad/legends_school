
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class WebUtils{

  Future<bool?> errorToast(String message)
  {
    return  Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  String formatTimeMonthYear(int timestamp) {
    // Convert the timestamp to DateTime
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    // Format the date to "MMMM yyyy" (e.g., "September 2024")
    return DateFormat('MMMM yyyy').format(date);
  }

  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'en_PK', symbol: '₨', decimalDigits: 2);
    return formatter.format(amount);
  }

  String formatCNIC(String cnic) {
    final cleaned = cnic.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length != 13) {
      throw const FormatException("Invalid CNIC Number");
    }
    return '${cleaned.substring(0, 5)}-${cleaned.substring(5, 12)}-${cleaned.substring(12)}';
  }


}