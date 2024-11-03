import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constant.dart';
import '../color/my_color.dart';
import 'app_text_widget.dart';
import '../../provider/constant/action_provider.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Future<void> Function() onClicked;
  double? width, height;
  final double radius,fontSize;
  final bool loader, oneColor;
  final Color textColor, borderColor, backgroundColor;
  final bool isShadow,isIcon;
  final IconData? prefixIcon; // Optional prefix icon
  int? index; // Add an index to distinguish between buttons
  FontWeight? fontWeight;

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
    this.isIcon = false,
    this.fontSize = 15.0,
    this.prefixIcon, // Initialize the prefix icon
    this.fontWeight, // Initialize the prefix icon
    this.index, // Initialize the index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hoverProvider = Provider.of<ActionProvider>(context);

    return MouseRegion(
      onEnter: (_) => hoverProvider.onHover(index ?? 0, true),
      onExit: (_) => hoverProvider.onHover(index ?? 0, false),
      child: InkWell(
        onTap: onClicked,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              width: width ?? 200,
              height: height ?? 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(
                  width: oneColor ? 1.0 : 0.0,
                  color: oneColor ? borderColor : Colors.transparent,
                ),
                color: hoverProvider.isLoading(index ?? 0) ? Colors.grey : backgroundColor,
                boxShadow: isShadow
                    ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ]
                    : null,
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  if (hoverProvider.isHovered(index ?? 0) && !hoverProvider.isLoading(index ?? 0))
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  Center(
                    child: hoverProvider.isLoading(index ?? 0)
                        ? const CircularProgressIndicator(
                      color: AppColor.appBackgroundColor,
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (prefixIcon != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              prefixIcon,
                              color: textColor,
                            ),
                          ),
                        AppTextWidget(
                          text: text,
                          fontSize: fontSize,
                          color: hoverProvider.isHovered(index ?? 0) ? Colors.white : textColor,
                          fontWeight: fontWeight ?? FontWeight.w900,
                        ),
                        if(isIcon)
                          AnimatedOpacity(
                            opacity: hoverProvider.isHovered(index ?? 0) ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.arrow_forward,
                                color: textColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
