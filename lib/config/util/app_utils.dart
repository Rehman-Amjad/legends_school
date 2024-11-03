import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils{
  void showToast({required String text,Color? bgColor,Color? textColor}){
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: bgColor ??  Colors.red,
        textColor: textColor ?? Colors.white,
        fontSize: 16.0);
  }
}