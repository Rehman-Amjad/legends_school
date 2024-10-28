import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legends_schools_admin/constant.dart';
import 'package:provider/provider.dart';

import '../../model/menu_modal.dart';
import '../../provider/menu/menu_provider.dart';
import '../../responsive.dart';
import '../res/app_assets.dart';

class Menu extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Menu({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MenuModel> menu = [
      MenuModel(icon: 'assets/svg/home.svg', title: "Dashboard"),
      MenuModel(icon: 'assets/svg/profile.svg', title: "Admissions"),
      MenuModel(icon: 'assets/svg/profile.svg', title: "Student Promotions"),
      MenuModel(icon: 'assets/svg/exercise.svg', title: "Student Card"),
      MenuModel(icon: 'assets/svg/exercise.svg', title: "Student Attendance"),
      MenuModel(icon: 'assets/svg/exercise.svg', title: "Test Sessions"),
      MenuModel(icon: 'assets/svg/exercise.svg', title: "Marks Reports"),
      MenuModel(icon: 'assets/svg/exercise.svg', title: "Teachers"),
      MenuModel(icon: 'assets/svg/exercise.svg', title: "Diary"),
      MenuModel(icon: 'assets/svg/exercise.svg', title: "Fee Management"),
      MenuModel(icon: 'assets/svg/exercise.svg', title: "Customer Support"),
      MenuModel(icon: 'assets/svg/exercise.svg', title: "Chat Analyser"),
      MenuModel(icon: 'assets/svg/setting.svg', title: "Settings"),
      MenuModel(icon: 'assets/svg/signout.svg', title: "SignOut"),
    ];

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
        color: primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Responsive.isMobile(context) ? 5 : 10,
              ),
              Image.asset(
                AppAssets().logoImagePath,
                width: 100.0,
                height: 100.0,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Legend School System",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: Responsive.isMobile(context) ? 20 : 30,
              ),
              ...List.generate(menu.length, (index) {
                return Consumer<MenuProvider>(
                  builder: (context, menuProvider, child) {
                    bool isSelected = menuProvider.selectedIndex == index;
                    bool isHovered = false;

                    return StatefulBuilder(
                      builder: (context, setState) {
                        return MouseRegion(
                          onEnter: (_) => setState(() => isHovered = true),
                          onExit: (_) => setState(() => isHovered = false),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6.0),
                              ),
                              color: isSelected
                                  ? Colors.blueAccent
                                  : isHovered
                                  ? Colors.blue.withOpacity(0.2)
                                  : Colors.transparent,
                            ),
                            child: InkWell(
                              onTap: () {
                                menuProvider.selectIndex(index);
                                menuProvider.selectMenu(index);
                                scaffoldKey.currentState!.closeDrawer();
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 13,
                                      vertical: 7,
                                    ),
                                    child: SvgPicture.asset(
                                      menu[index].icon,
                                      colorFilter: ColorFilter.mode(
                                        isSelected
                                            ? Colors.white
                                            : Colors.grey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    menu[index].title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
}
