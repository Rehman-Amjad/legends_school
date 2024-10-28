import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../constant.dart';
import '../../provider/constant/action_provider.dart';
import 'app_text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  double? width, height,fontSize;
  final double radius;
  final bool loader, oneColor;
  final Color textColor, borderColor, backgroundColor;
  final bool isShadow;
  FontWeight? fontWeight;
  Widget? prefixWidget,suffixWidget;

  ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    this.width,
    this.height,
    this.radius = 10.0,
    this.loader = false,
    this.oneColor = false,
    this.textColor = Colors.white,
    this.borderColor = primaryColor,
    this.backgroundColor = primaryColor,
    this.isShadow = true,
    this.fontWeight,
    this.prefixWidget,
    this.suffixWidget,
    this.fontSize,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<ActionProvider>(context).isLoading;
    return InkWell(
      onTap: isLoading ? null : onClicked,
      child: Container(
        width: width ?? 100.w,
        height: height ?? 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(width: oneColor ? 1.0 :0.0,color: oneColor ? borderColor :Colors.transparent),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            colors: [
              oneColor ? backgroundColor : (primaryColor),
              oneColor ? backgroundColor : (primaryColor),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: isShadow ? 2 : 0,
              blurRadius: isShadow ? 5 : 0,
              offset: Offset(isShadow ? 0 : 0, isShadow ? 3 : 0),
            ),
          ],
        ),
        child: isLoading
            ? const Center(
          child:  CircularProgressIndicator(
            color: primaryColor,
          ),
        )
            : Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(prefixWidget!=null)...[
                prefixWidget ?? const SizedBox.shrink(),
                SizedBox(width: 1.w,),
              ],
              AppTextWidget(
                text: text,
                fontSize:  fontSize ?? 15.0,
                color: textColor,
                fontWeight: fontWeight ?? FontWeight.w600,
              ),
              if(suffixWidget!=null)...[
                suffixWidget ?? const SizedBox.shrink(),
                SizedBox(width: 1.w,),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
