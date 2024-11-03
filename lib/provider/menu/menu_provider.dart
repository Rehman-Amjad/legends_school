import 'package:flutter/material.dart';
import 'package:legends_schools_admin/screens/admission/admission_form_screen.dart';
import 'package:legends_schools_admin/screens/admission/admission_screen.dart';
import 'package:legends_schools_admin/screens/cards/student_card_serach.dart';
import 'package:legends_schools_admin/screens/teacher/teacher_register.dart';

import '../../Model/menu_modal.dart';
import '../../config/res/app_string.dart';
import '../../screens/annoucement/popup_annoucement_screen.dart';
import '../../screens/dashboard/dashboard.dart';
import '../../screens/result/results_screen.dart';
import '../../screens/teacher/teacher_list_screen.dart';

class MenuProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int _selectedScreenIndex = 0;

  int get selectedIndex => _selectedIndex;
  int? _expandedIndex = 0;
  int? _hoveredIndex = 0;
  MenuModel? _selectedSubItem;
  MenuModel? _hoveredSubItem;
  Widget? _cachedSelectedScreen;

  int? get expandedIndex => _expandedIndex;
  int? get hoveredIndex => _hoveredIndex;
  MenuModel? get selectedSubItem => _selectedSubItem;
  MenuModel? get hoveredSubItem => _hoveredSubItem;

  void selectMenu(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  void selectIndex(int index) {
    if (_selectedScreenIndex != index) {
      _selectedScreenIndex = index;
      notifyListeners();
    }
  }

  void toggleExpandedIndex(int index) {
    if (_expandedIndex != index) {
      _expandedIndex = _expandedIndex == index ? null : index;
      _cachedSelectedScreen = null; // Clear cache on main item change
      notifyListeners();
    }
  }

  void setHoveredIndex(int? index) {
    if (_hoveredIndex != index) {
      _hoveredIndex = index;
      notifyListeners();
    }
  }

  void selectMenuIndex(int index) {
    if (_expandedIndex != index) {
      _expandedIndex = index;
      _selectedSubItem = null;
      _cachedSelectedScreen = null; // Clear cache on selection change
      notifyListeners();
    }
  }

  void selectSubItem(MenuModel subItem) {
    if (_selectedSubItem != subItem) {
      _selectedSubItem = subItem;
      _cachedSelectedScreen = null; // Clear cache on sub-item change
      notifyListeners();
    }
  }

  bool isSelected(int index) => _expandedIndex == index;
  bool isHovered(int index) => _hoveredIndex == index;

  void setHoveredSubItem(MenuModel? item) {
    if (_hoveredSubItem != item) {
      _hoveredSubItem = item;
      notifyListeners();
    }
  }

  bool isHoveredSubItem(MenuModel item) => _hoveredSubItem == item;
  bool isActiveSubItem(MenuModel item) => _selectedSubItem == item;

  // Cache the screen to prevent unnecessary rebuilds
  Widget get selectedScreen {
    if (_cachedSelectedScreen == null) {
      if (_selectedSubItem != null) {
        switch (_selectedSubItem?.title ?? "") {
          case AppString.newAdmission:
            _cachedSelectedScreen = AdmissionFormScreen();
            break;
          case AppString.admissionList:
            _cachedSelectedScreen = const AdmissionScreen();
            break;
          case AppString.studentSearch:
            _cachedSelectedScreen = const AdmissionScreen();
            break;
          case AppString.studentCard:
            _cachedSelectedScreen = StudentCardScreen();
            break;
          // case AppString.feeSlip:
          //   _cachedSelectedScreen = FeeSlipScreen();
          //   break;
          case AppString.addNewTeacher:
            _cachedSelectedScreen = TeacherRegisterScreen();
            break;
          case AppString.teacherList:
            _cachedSelectedScreen = TeacherListScreen();
            break;
          // case AppString.assignClasses:
          //   _cachedSelectedScreen = AssignTeacherSubjectScreen();
          //   break;
          // case AppString.dailyExpense:
          //   _cachedSelectedScreen = StudentDailyExpenseScreen();
          //   break;
          // case AppString.parentCard:
          //   _cachedSelectedScreen = ParentCardSearch();
          //   break;
          // case AppString.studentCard:
          //   _cachedSelectedScreen = StudentCardScreen();
          //   break;
          // case AppString.teacherCard:
          //   _cachedSelectedScreen = TeacherCardScreen();
          //   break;
          // default:
          //   _cachedSelectedScreen = AdmissionListScreen();
        }
      } else {
        switch (_expandedIndex) {
          case 0:
            _cachedSelectedScreen = DashboardScreen();
            break;
          case 6:
            _cachedSelectedScreen = const PopupAnnoucementScreen();
            break;
          // case 8:
          //   _cachedSelectedScreen = ChatScreen();
          //   break;
          case 7:
            _cachedSelectedScreen = const ResultScreen();
            break;
          default:
            _cachedSelectedScreen = DashboardScreen();
        }
      }
    }
    return _cachedSelectedScreen!;
  }
}
