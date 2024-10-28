
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/component/app_text_field.dart';
import 'package:legends_schools_admin/config/component/app_text_widget.dart';

class TextFieldHeadBox extends StatelessWidget {
  final String labelText,hintText;
  final TextEditingController controller;
  final VoidCallback? press;
  TextFieldHeadBox({super.key, required this.labelText, required this.hintText, required this.controller, this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextWidget(text: labelText, color: Colors.black, fontSize: 16.0),
          SizedBox(height: 10.0),
          AppTextField(press: press,hintText: hintText, controller: controller)
        ],
      ),
    );
  }
}
