import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/component/app_text_widget.dart';

import 'custom_dropdown_list.dart';

class DropDownHeadBox extends StatelessWidget {
  final String labelText;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  DropDownHeadBox({super.key, required this.items, this.selectedItem, required this.onChanged, required this.labelText,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextWidget(text: labelText, color: Colors.black, fontSize: 16.0),
          SizedBox(height: 10.0),
          CustomDropDownList(items: items, selectedItem: selectedItem, onChanged: onChanged)
        ],
      ),
    );
  }
}
