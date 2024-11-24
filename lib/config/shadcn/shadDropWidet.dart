import 'package:flutter/material.dart';

class Shaddropwidet extends StatelessWidget {
  const Shaddropwidet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ConstrainedBox(
        //   constraints: const BoxConstraints(maxWidth: 600),
        //   child:  ShadDatePicker(
        //     closeOnSelection: false,
        //     backgroundColor: primaryColor,
        //     placeholder: AppTextWidget(
        //       text: "choose date",
        //       color: Colors.white.withOpacity(0.4),
        //     ),
        //     icon: const Icon(Icons.calendar_month,color: Colors.white,),
        //
        //     // Customize the selected text color
        //     selectedDayButtonTextStyle: const TextStyle(
        //       color: Colors.black, // The text color of the selected day
        //       fontWeight: FontWeight.bold, // Optional: bold selected text
        //     ),
        //
        //     // Customize the arrow button color in the dropdown
        //     navigationButtonIconSize: 24, // Size of the navigation arrow
        //
        //     // Dropdown background color (popover background)
        //     popoverDecoration: const ShadDecoration(
        //       color: primaryColor, // Dropdown background color
        //     ),
        //
        //     // Calendar header text color customization
        //     calendarHeaderTextStyle: const TextStyle(
        //       color: Colors.white, // Header text color
        //       fontWeight: FontWeight.bold, // Customize header text style
        //     ),
        //
        //     // Weekday text color customization
        //     weekdaysTextStyle: const TextStyle(
        //       color: Colors.white, // Weekday text color
        //     ),
        //     onChanged: (date) {
        //       // Handle date change
        //       print("Date selected: ${TimeUtils().getMonthYearFromCalender(date.toString())}");
        //     },
        //
        //
        //
        //   )
        //
        //   ,
        // )
      ],
    );
  }
}
