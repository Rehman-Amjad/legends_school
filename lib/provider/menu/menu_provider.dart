import 'package:flutter/material.dart';
import 'package:legends_schools_admin/main/admission_form_screen.dart';
import 'package:legends_schools_admin/screens/admission/admission_screen.dart';
import 'package:legends_schools_admin/screens/dashboard/dashboard.dart';

import '../../screens/admission/admission_form_screen.dart';

class MenuProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int _selectedScreenIndex = 0;

  int get selectedIndex => _selectedIndex;

  void selectMenu(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void selectIndex(int index) {
    _selectedScreenIndex = index;
    notifyListeners();
  }

  // Define the screens for each menu item
  Widget get selectedScreen {
    switch (_selectedScreenIndex) {
      case 0:
        return DashboardScreen(); // Replace with actual screen
      case 1:
        return AdmissionScreen(); // Replace with actual screen
      case 3:
        return DashboardScreen(); // Replace with actual screen
      case 4:
        return DashboardScreen(); // Replace with actual screen
      case 5:
        return DashboardScreen();
      case 5:
        return DashboardScreen();
      case 6:
        return DashboardScreen();
      case 7:
        return DashboardScreen();
      case 8:
        return DashboardScreen();
      case 9:
        return DashboardScreen();
      case 10:
        return DashboardScreen();
      case 11:
        return DashboardScreen();
      case 12:
        return DashboardScreen();
      case 13:
        return AdmissionFormScreen();
      case 14:
        return StudentAdmissionFormScreen();
      default:
        return DashboardScreen(); // Replace with actual screen
    }
  }
}
