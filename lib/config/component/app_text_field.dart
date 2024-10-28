import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../constant.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool borderSides;
  final double? radius;
  final VoidCallback? press;
  // final int? maxLine;
  // final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText,readOnly;
  final Color? fillColor, borderColor, borderSideColor, focusBorderColor;
  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.borderSides = false,
    this.onFieldSubmitted,
    this.onChanged,
    this.focusNode,
    this.radius,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType,
    this.inputFormatters,
    this.fillColor,
    this.borderColor,
    this.borderSideColor,
    this.focusBorderColor,
    this.suffixIcon,
    this.press,
    // this.maxLine,
    this.prefixIcon,
    // this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onChanged: onChanged,
      onTap: press,
      // maxLines: maxLine,
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
          borderSide:  BorderSide(color: borderSideColor ?? darkGrey, width: 2),
          borderRadius: BorderRadius.circular(radius ?? 5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide:  BorderSide(color: focusBorderColor ?? primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide:  const BorderSide(color: primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide:  BorderSide(color: borderColor ?? Colors.grey.shade200),
        ),
        fillColor: fillColor ?? customGrey,
        focusColor: Colors.blueGrey,
        hintStyle: const TextStyle(fontSize: 12.0, color: Colors.grey,fontWeight: FontWeight.w500),
      ),
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
