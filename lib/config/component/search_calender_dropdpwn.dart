import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/constant/drop_down_provider.dart';
import '../constant/constant_widget.dart';

class SearchCalenderDropdown extends StatelessWidget {
  const SearchCalenderDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final dropP = Provider.of<DropdownProvider>(context);
    return Row(
      children: [
        Container(
          width: 250,
          child: CustomDropdown<String>(
            hintText: 'Choose Month',
            items: dropP.months,
            initialItem: dropP.selectedMonth,
            onChanged: (category) {
              if (category != null) {
                dropP.updateSelectedMonth(category);
              }
            },
            validateOnChange: true,
            validator: (value){
              if(value ==null){
                return "Select Month";
              }
              return null;
            },
            decoration: decoration(
              bolderColor: Colors.transparent,
              headerFontSize: 14.0,
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 20,),
        Container(
          width: 250,
          child: CustomDropdown<String>(
            hintText: 'Choose Year',
            items: dropP.years,
            initialItem: dropP.selectedYear,
            onChanged: (category) {
              if (category != null) {
                dropP.updateSelectedYear(category);
              }
            },
            validateOnChange: true,
            validator: (value){
              if(value ==null){
                return "Select Year";
              }
              return null;
            },
            decoration: decoration(
              bolderColor: Colors.transparent,
              headerFontSize: 14.0,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
