import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../constant.dart';

class CustomRichText extends StatelessWidget {
  final String firstText,secondText;
  final VoidCallback? press;
  double firstSize,secondSize;
  FontWeight? firstWeight,secondWeight;
  TextDecoration? decoration;
  Color? firstColor,secondColor;
  TextAlign? textAlign;
  CustomRichText({super.key,
    required this.firstText,
    required this.secondText,
     this.press,
    this.firstSize = 18.0,
    this.secondSize = 18.0,
    this.firstWeight,
    this.secondWeight,
    this.decoration,
    this.firstColor,
    this.secondColor,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: textAlign ?? TextAlign.start,
        text: TextSpan(
          text: firstText,
          style:  TextStyle(color: firstColor ?? Colors.black,
              fontSize: firstSize,
              fontWeight: firstWeight ?? FontWeight.bold,
              fontFamily: 'IBMPlexSans'
          ),
          children: <InlineSpan>[
            const WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: SizedBox(width: 5.0)),
            TextSpan(
              text: secondText,
              style:  TextStyle(color: secondColor ?? primaryColor,
                  fontSize: secondSize,
                  fontWeight: secondWeight ?? FontWeight.normal,
                  fontFamily: "IBMPlexSans",
                  decoration: decoration ?? TextDecoration.none
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = press,
            ),
          ],
        )
    );
  }
}
