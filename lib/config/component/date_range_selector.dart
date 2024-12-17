import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/component/button_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/diary/diary_provider.dart';
import '../util/time_utils.dart';

class DateRangeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final diaryProvider = Provider.of<DiaryProvider>(context);

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            readOnly: true,
            controller: TextEditingController(
              text: diaryProvider.startDate != null
                  ? TimeUtils().formatDate(diaryProvider.startDate!)
                  : 'Start Date',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: diaryProvider.startDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                diaryProvider.setStartDate(picked);
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            readOnly: true,
            controller: TextEditingController(
              text: diaryProvider.endDate != null
                  ? TimeUtils().formatDate(diaryProvider.endDate!)
                  : 'End Date',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: diaryProvider.endDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                diaryProvider.setEndDate(picked);
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        ButtonWidget(text: "clear", onClicked: ()async{
          diaryProvider.clearDateFilter();
        })
      ],
    );
  }
}