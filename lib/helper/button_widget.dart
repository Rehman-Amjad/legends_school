import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/helper/my_color.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  var backgroundColor;
  final width,height;

   ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    this.backgroundColor,
    required this.width,
   required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>

      InkWell(
        onTap: onClicked,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: backgroundColor!=null ? backgroundColor : MyColor().mainColor,
          ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
    ),
  ),
      );
}