import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';

CustomDropdownDecoration? decoration({headerFontSize,prefixIcon,bolderColor,fillColor}) => CustomDropdownDecoration(
  closedFillColor: fillColor?? whiteColor,
  expandedFillColor: whiteColor,
  closedBorder: Border.all(color: bolderColor??Colors.black),
  expandedBorder: Border.all(color: bolderColor ?? Colors.black),
  closedBorderRadius: BorderRadius.circular(10),
  expandedBorderRadius: BorderRadius.circular(10),
  prefixIcon: prefixIcon,
  closedSuffixIcon: const Icon(
    Icons.keyboard_arrow_down,
    color: Colors.black,
  ),
  expandedSuffixIcon: const Icon(
    Icons.keyboard_arrow_up,
    color: Colors.black,
  ),
  hintStyle: const TextStyle(
    color: primaryColor,
    fontSize: 14,
    fontFamily: "IBMPlexSans",
    fontWeight: FontWeight.w400,
  ),
  headerStyle: TextStyle(
    color: Colors.black,
    fontSize: headerFontSize ?? 16,
    fontWeight: FontWeight.w500,
  ),
  listItemStyle: const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: "IBMPlexSans",
    fontWeight: FontWeight.w600,
  ),
  listItemDecoration: ListItemDecoration(
    selectedColor: Colors.black,
    highlightColor: Colors.grey[800],
  ),
);
