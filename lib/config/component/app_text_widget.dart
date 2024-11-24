import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  int? maxLine;
  final bool softWrap;
  final Color color;
  final ValueKey? keyValue;
  TextDecoration? textDecoration;
  TextOverflow? overflow;
  final bool isSelectable; // New parameter to control selectable behavior

  AppTextWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w500,
    this.color = Colors.black,
    this.textAlign = TextAlign.center,
    this.textDecoration,
    this.fontSize = 16,
    this.softWrap = true,
    this.keyValue,
    this.overflow,
    this.maxLine,
    this.isSelectable = false, // Default is false (non-selectable text)
  });

  @override
  Widget build(BuildContext context) {
    if (isSelectable) {
      // Return SelectableText if isSelectable is true
      return SelectableText(
        text,
        key: keyValue,
        textAlign: textAlign,
        maxLines: maxLine,
        style: TextStyle(
          decoration: textDecoration ?? TextDecoration.none,
          decorationColor: Colors.black,
          fontWeight: fontWeight,
          fontSize: fontSize,
          fontFamily: "IBMPlexSans",
          color: color,
        ),
      );
    } else {
      // Return normal Text widget if isSelectable is false
      return Text(
        text,
        key: keyValue,
        textAlign: textAlign,
        softWrap: softWrap,
        maxLines: maxLine,
        overflow: overflow ?? TextOverflow.clip,
        style: TextStyle(
          decoration: textDecoration ?? TextDecoration.none,
          decorationColor: Colors.black,
          fontWeight: fontWeight,
          fontSize: fontSize,
          fontFamily: "IBMPlexSans",
          color: color,
        ),
      );
    }
  }
}
