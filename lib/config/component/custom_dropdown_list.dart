import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/constant.dart';

class CustomDropDownList extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;

  const CustomDropDownList({
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: const Icon(
        Icons.arrow_drop_down_circle,
        color: primaryColor,
      ),
      dropdownColor: Colors.white,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0,right: 10.0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2.0),
        ),
      ),
      value: selectedItem,
      onChanged: onChanged, // Use the provided onChanged function
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
