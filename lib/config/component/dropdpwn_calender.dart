import 'package:flutter/material.dart';
import 'package:legends_schools_admin/provider/constant/action_provider.dart';
import 'package:provider/provider.dart';

class DropdpwnCalender extends StatelessWidget {
  const DropdpwnCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ActionProvider>(
      builder: (context, dateProvider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dropdown Button
            DropdownButton<DateTime?>(
              value: dateProvider.selectedDate,
              hint: Text("Select Date"),
              onChanged: (value) async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: value ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (selectedDate != null) {
                  context.read<ActionProvider>().setDate(selectedDate);
                }
              },
              items: [
                if (dateProvider.selectedDate != null)
                  DropdownMenuItem(
                    value: dateProvider.selectedDate,
                    child: Text(
                      "${dateProvider.selectedDate!.day}/${dateProvider.selectedDate!.month}/${dateProvider.selectedDate!.year}",
                    ),
                  ),
              ],
            ),
            // Display Selected Date
            if (dateProvider.selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "Selected Date: ${dateProvider.selectedDate!.day}/${dateProvider.selectedDate!.month}/${dateProvider.selectedDate!.year}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
        );
      },
    );
  }
}
