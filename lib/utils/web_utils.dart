
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

}