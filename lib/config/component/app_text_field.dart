import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../constant.dart';
import 'app_text_widget.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final Color? labelTextColor,fillColor,borderColor;
  final double? labelTextSize;
  final FontWeight? labelFontWeight;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool borderSides;
  final double? radius;
  final int? maxLine;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final VoidCallback? press;
  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.borderSides = false,
    this.onFieldSubmitted,
    this.focusNode,
    this.radius,
    this.press,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.suffixIcon,
    this.maxLine,
    this.prefixIcon,
    this.maxLength,
    this.labelText,
    this.labelTextSize,
    this.labelFontWeight,
    this.labelTextColor,
    this.fillColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(labelText !=null)...[
          AppTextWidget(
            text: labelText ?? "",
            fontSize: labelTextSize ?? 16,
            color: labelTextColor ?? Colors.black,
            fontWeight: labelFontWeight ?? FontWeight.bold,
          ),
          SizedBox(height: 10,),
        ],
        TextFormField(
          onTap: press,
          maxLines: maxLine ?? 1,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500
          ),
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          cursorColor: Colors.black,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            filled: true,
            border: OutlineInputBorder(
              borderSide:  BorderSide(color:borderColor ?? Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(radius ?? 5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 5),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 5),
              borderSide: const BorderSide(color: Colors.black),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 5),
              borderSide:  BorderSide(color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 5),
              borderSide:  BorderSide(color: borderColor ?? Colors.grey),
            ),
            fillColor: fillColor ??  Colors.white,
            focusColor: Colors.blueGrey,
            hintStyle: const TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('+');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 3) {
      newText.write('${newValue.text.substring(0, usedSubstringIndex = 2)} ');
      if (newValue.selection.end >= 2) selectionIndex += 1;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
