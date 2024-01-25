import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomInputField extends StatelessWidget {

  var labelText,hintText;
  var controller = TextEditingController();
  var emptyMessage;


  MyCustomInputField(
      this.labelText,
      this.hintText,
      this.controller, {super.key,required}
      );



  @override
  Widget build(BuildContext context) {
    return TextFormField(
    controller: controller,
      validator: (value){
      if(value == null || value.isEmpty)
          {
            return emptyMessage;
          }
      return null;
  },
      decoration: InputDecoration(
        label: Text(labelText),
        hintText: hintText,
        hintStyle: TextStyle(
      fontSize: 12
  ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
      ),
    );
  }
}
