import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomInputField extends StatelessWidget {
  var labelText, hintText;
  var controller = TextEditingController();
  var emptyMessage;
  final Function(dynamic)? onChange;

  MyCustomInputField(this.labelText, this.hintText, this.controller,
      {super.key, required, this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChange,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return emptyMessage;
        }
        return null;
      },
      decoration: InputDecoration(
          label: Text(labelText),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
    );
  }
}
