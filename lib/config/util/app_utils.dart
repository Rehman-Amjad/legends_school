import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../enum/toast_type.dart';

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

  void showWebToast({String? text, ToastType? toastType}) {
    // Define background color based on the ToastType
    Color backgroundColor;

    switch (toastType) {
      case ToastType.success:
        backgroundColor = Colors.green; // Success color
        break;
      case ToastType.error:
        backgroundColor = Colors.red; // Error color
        break;
      case ToastType.warning:
        backgroundColor = Colors.orange; // Warning color
        break;
      case ToastType.info:
      default:
        backgroundColor = Colors.green; // Info color (default)
        break;
    }

    // Show the toast
    ShadToaster.of(Get.context!).show(
      ShadToast(
        alignment: Alignment.topRight,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 5.0),
            Text(text ?? "Hello"),
          ],
        ),
        duration: const Duration(seconds: 3),
        animateIn: const [
          SlideEffect(
            delay: Duration(milliseconds: 100),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
            begin: Offset(1, 0),
            end: Offset(0, 0),
          ),
        ],
        animateOut: const [
          SlideEffect(
            delay: Duration(milliseconds: 100),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            begin: Offset(0, 0),
            end: Offset(1, 0),
          ),
        ],
        backgroundColor: backgroundColor,
        border: Border.all(
          color: backgroundColor
        ),// Set the background color dynamically
        titleStyle: const TextStyle(color: Colors.white),
      ),
    );
  }

   webAlertDialog({
     String? title,
     String? content,
     String? leftButtonTxt,
     String? rightButtonTxt,
     VoidCallback? rightPress,
     VoidCallback? leftPress,
   }){
    return showShadDialog(
      context: Get.context!,
      builder: (context) => ShadDialog.alert(
        title:  Text( title ?? 'Are you absolutely sure?'),
        description:  Padding(
          padding:const  EdgeInsets.only(bottom: 8),
          child: Text(
           content ?? 'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
          ),
        ),
        actions: [
          ShadButton.outline(
            onPressed: leftPress ?? () =>  Navigator.of(context).pop(false),
            child:  Text(leftButtonTxt ?? 'Cancel'),
          ),
          ShadButton(
            onPressed: rightPress ?? () =>  Navigator.of(context).pop(true),
            child:  Text(rightButtonTxt ?? 'Continue'),
          ),
        ],
      ),
    );
  }

  int? monthNameToNumber(String monthName) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final index = months.indexWhere(
          (month) => month.toLowerCase() == monthName.toLowerCase().trim(),
    );
    return index != -1 ? index + 1 : null; // Return null if the month name is invalid
  }

}