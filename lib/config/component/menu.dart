import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legends_schools_admin/config/enum/form_type.dart';
import 'package:legends_schools_admin/provider/registration/registration_provider.dart';
import 'package:provider/provider.dart';

import '../../Model/menu_modal.dart';
import '../../constant.dart';
import '../../provider/menu/menu_provider.dart';
import '../../responsive.dart';
import '../res/app_assets.dart';
import '../res/app_string.dart';

class Menu extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;


  const Menu({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<MenuModel> menu = [
      MenuModel(icon: 'assets/svg/home.svg', title: AppString.dashboard),
      MenuModel(
        icon: 'assets/svg/profile.svg',
        title: "Student Admissions",
        subItems: [
          MenuModel(icon: 'assets/svg/profile.svg', title: AppString.newAdmission),
          MenuModel(icon: 'assets/svg/profile.svg', title: AppString.admissionList),
        ],
      ),
      MenuModel(
        icon: 'assets/svg/profile.svg',
        title: "Fee",
        subItems: [
          MenuModel(icon: 'assets/svg/profile.svg', title: AppString.feeStructure),
          MenuModel(icon: 'assets/svg/profile.svg', title: AppString.feeSlip),
        ],
      ),
      MenuModel(
        icon: 'assets/svg/exercise.svg',
        title: "Student Management",
        subItems: [
          MenuModel(icon: 'assets/svg/profile.svg', title: AppString.studentSearch),
          MenuModel(icon: 'assets/svg/profile.svg', title: AppString.studentCard),
          MenuModel(icon: 'assets/svg/profile.svg', title: AppString.studentPromotion),
          MenuModel(icon: 'assets/svg/profile.svg', title: AppString.studentExpense),
          // MenuModel(icon: 'assets/svg/profile.svg', title: AppString.dailyExpense),
          // MenuModel(icon: 'assets/svg/profile.svg', title: AppString.testMarks),
        ],
      ),
      MenuModel(
        icon: 'assets/svg/profile.svg',
        title: "Teacher",
        subItems: [
          MenuModel(icon: 'assets/svg/profile.svg', title: AppString.addNewTeacher),
          MenuModel(icon: 'assets/svg/profile.svg', title: AppString.teacherList),
        ],
      ),
      MenuModel(
        icon: 'assets/svg/exercise.svg',
        title: "Teacher Management",
        subItems: [
          MenuModel(icon: 'assets/svg/profile.svg', title: AppString.teacherCard),
          MenuModel(icon: 'assets/svg/profile.svg', title: AppString.salarySlip),
          MenuModel(icon: 'assets/svg/profile.svg', title: AppString.assignClasses),
        ],
      ),

      // MenuModel(
      //   icon: 'assets/svg/exercise.svg',
      //   title: "Attendance",
      //   subItems: [
      //     MenuModel(icon: 'assets/svg/profile.svg', title: AppString.studentAttendance),
      //     MenuModel(icon: 'assets/svg/profile.svg', title: AppString.teacherAttendance),
      //   ],
      // ),
      MenuModel(icon: 'assets/svg/setting.svg', title: "Announcement"),
      // MenuModel(icon: 'assets/svg/setting.svg', title: "Chat"),
      MenuModel(icon: 'assets/svg/setting.svg', title: "Result"),
      // MenuModel(icon: 'assets/svg/setting.svg', title: "Settings"),
      // MenuModel(icon: 'assets/svg/signout.svg', title: "SignOut"),
    ];

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        // border: Border(
        //   right: BorderSide(
        //     color: Colors.grey[800]!,
        //     width: 1,
        //   ),
        // ),
        color: primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Responsive.isMobile(context) ? 5 : 10),
              Image.asset(
                AppAssets.logo,
                width: 100.0,
                height: 100.0,
              ),
              const SizedBox(height: 15),
              const Text(
                "Legend School System",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: Responsive.isMobile(context) ? 20 : 30),
              ...List.generate(menu.length, (index) {
                return Consumer<MenuProvider>(
                  builder: (context, provider, child) {
                    final item = menu[index];
                    final isExpanded = provider.expandedIndex == index;
                    return Column(
                      children: [
                        _buildMenuItem(item, index, isExpanded, context, provider),
                        if (isExpanded && item.subItems != null)
                          ...item.subItems!.map((subItem) => _buildSubMenuItem(subItem, provider, context)),
                      ],
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(MenuModel item, int index, bool isExpanded, BuildContext context, MenuProvider provider) {
    // Check if any subitem of the current main menu item is selected
    final bool hasSelectedSubItem = item.subItems?.any((subItem) => provider.isActiveSubItem(subItem)) ?? false;

    return MouseRegion(
      onEnter: (_) => provider.setHoveredIndex(index),
      onExit: (_) => provider.setHoveredIndex(null),
      child: InkWell(
        onTap: () {
          if (item.subItems == null) {
            // If no subitems, directly select the main item and close the drawer
            log("Click");
            provider.selectMenuIndex(index);
          } else {
            // Toggle expansion if there are subitems
            provider.toggleExpandedIndex(index);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            color: provider.isSelected(index) && item.subItems == null // Highlight if selected and no subitems
                ? Colors.blueAccent
                : hasSelectedSubItem // Highlight if a subitem is selected
                ? Colors.blueAccent
                : provider.isHovered(index)
                ? Colors.blueAccent.withOpacity(0.2)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                child: SvgPicture.asset(
                  item.icon,
                  colorFilter: ColorFilter.mode(
                    (provider.isSelected(index) && item.subItems == null) || hasSelectedSubItem // Icon color for selected item or selected subitem
                        ? Colors.white
                        : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 16,
                    color: (provider.isSelected(index) && item.subItems == null) || hasSelectedSubItem // Text color for selected item or selected subitem
                        ? Colors.white
                        : Colors.white,
                    fontWeight: (provider.isSelected(index) && item.subItems == null) || hasSelectedSubItem // Bold font for selected item or selected subitem
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
              if (item.subItems != null)
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: (provider.isSelected(index) && item.subItems == null) || hasSelectedSubItem // Arrow icon color for selected item or selected subitem
                      ? Colors.white
                      : Colors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubMenuItem(MenuModel subItem, MenuProvider provider, BuildContext context) {
    bool isActive = provider.isActiveSubItem(subItem);
    final regP = Provider.of<RegistrationProvider>(context,listen: false);
    return MouseRegion(
      onEnter: (_) => provider.setHoveredSubItem(subItem),
      onExit: (_) => provider.setHoveredSubItem(null),
      child: InkWell(
        onTap: () {
          log("message:: ${subItem.title},");
          regP.updateType(FormType.newForm.name);
          provider.selectSubItem(subItem); // Mark this sub-item as selected
          // if (subItem.routes != null) {
          //   Navigator.pushNamed(context, subItem.routes!);
          // }
          // scaffoldKey.currentState!.closeDrawer();
        },
        child: Container(
          padding: const EdgeInsets.only(left: 40, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: isActive
                ? Colors.blueAccent.withOpacity(0.2) // Active background color
                : provider.isHoveredSubItem(subItem)
                ? Colors.blueAccent.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              // SvgPicture.asset(
              //   subItem.icon,
              //   width: 20,
              //   height: 20,
              //   colorFilter: ColorFilter.mode(
              //     isActive ? Colors.white : Colors.white, // Active icon color
              //     BlendMode.srcIn,
              //   ),
              // ),
              const SizedBox(width: 10),
              Text(
                subItem.title,
                style: TextStyle(
                  fontSize: 16,
                  color: isActive ? Colors.white : Colors.white, // Active text color
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

