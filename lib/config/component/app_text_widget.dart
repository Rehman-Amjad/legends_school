import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


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
  AppTextWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w500,
    this.color = Colors.black,
    this.textAlign = TextAlign.center,
    this.textDecoration,
    this.fontSize = 12,
    this.softWrap = true,
    this.keyValue,
    this.overflow,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      // maxFontSize: fontSize,
      key: keyValue,
      // minFontSize: 8.0,
      //AppLocalizations.of(context)?.translate(text) ?? text,
      text,
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
