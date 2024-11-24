import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/enum/toast_type.dart';

class ActionProvider extends ChangeNotifier{
  int _selectedIndex = 0;
  final Map<int, bool> _isHovered = {};
  final Map<int, bool> _isLoading = {};

  Map<int, bool> _isCardHovered = {};

  bool isCardHovered(int index) => _isCardHovered[index] ?? false;

  void setHover(int index, bool value) {
    _isCardHovered[index] = value;
    notifyListeners();
  }

  static final ActionProvider _instance = ActionProvider._internal();
  factory ActionProvider() => _instance;
  ActionProvider._internal();

  int get selectedIndex => _selectedIndex;
  bool  isHovered(int index) => _isHovered[index] ?? false;
  bool  isLoading(int index) => _isLoading[index] ?? false;

  void selectMenu(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void onHover(int index,bool isHovered) {
    _isHovered[index] = isHovered;
    notifyListeners();
  }

  void setLoading(bool isLoading, {int index = 0}) {
    _isLoading[index] = isLoading;
    notifyListeners();
  }

  // Static methods to start and stop loading globally
  static void startLoading({int index = 0}) {
    _instance.setLoading(true,index: index);
  }

  static void stopLoading({int index = 0}) {
    _instance.setLoading(false,index: index);
  }

  String? _message;
  bool _isVisible = false;
  ToastType? _toastType;

  String? get message => _message;
  bool get isVisible => _isVisible;
  ToastType? get toastType => _toastType;

  void showToast(String message, ToastType toastType) {
    _message = message;
    _toastType = toastType;
    _isVisible = true;
    notifyListeners();

    // Automatically hide the toast after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      hideToast();
    });
  }

  void hideToast() {
    _isVisible = false;
    notifyListeners();
  }

  final Map<String, bool> _loadingStates = {};
  bool isLoadingState(String key) => _loadingStates[key] ?? false;

  void setLoadingState(String key, bool loading) {
    _loadingStates[key] = loading;
    notifyListeners();
  }


  bool _isFooterHovered = false;

  bool get isFooterHovered => _isFooterHovered;

  void setHovered(bool value) {
    _isFooterHovered = value;
    notifyListeners();
  }

  int _hoveredIndex = -1;

  int get hoveredIndex => _hoveredIndex;

  void setHoveredIndex(int index) {
    _hoveredIndex = index;
    notifyListeners();
  }

  void clearHover() {
    _hoveredIndex = -1;
    notifyListeners();
  }


  bool _isEditVisible = false;
  bool get isEditVisible => _isEditVisible;

  void setEditVisible(bool value) {
    _isEditVisible = value;
    notifyListeners();
  }


  final GlobalKey<ScaffoldState> _scaffoldKeyDashboard = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKeyDashboard;

  void controlMenuDashboard() {
    if (!_scaffoldKeyDashboard.currentState!.isDrawerOpen) {
      _scaffoldKeyDashboard.currentState!.openDrawer();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKeyInstructor = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKeyInstructor => _scaffoldKeyInstructor;

  void controlMenuInstructor() {
    if (!_scaffoldKeyInstructor.currentState!.isDrawerOpen) {
      _scaffoldKeyInstructor.currentState!.openDrawer();
    }
  }


  // date picker d
  DateTime? _selectedDateTime;

  DateTime? get selectedDateTime => _selectedDateTime;

  void setDateTime(DateTime dateTime) {
    _selectedDateTime = dateTime;
    notifyListeners();
  }

  DateTimeRange? _selectedDateTimeRange;

  DateTimeRange? get selectedDateTimeRange => _selectedDateTimeRange;

  // void setDateTimeRange(DateTimeRange dateTimeRange) {
  //   _selectedDateTimeRange = dateTimeRange;
  //   notifyListeners();
  // }

  // DateTimeRange? _selectedDateTimeRange;

  DateTime? _startDate;
  DateTime? _endDate;

  // Getter for start date
  DateTime? get startDate => _startDate;

  // Getter for end date
  DateTime? get endDate => _endDate;

  // Getter for the entire date range
  // DateTimeRange? get selectedDateTimeRange => _selectedDateTimeRange;

  // Method to set the date range and update start and end dates
  void setDateTimeRange(DateTimeRange dateTimeRange) {
    _selectedDateTimeRange = dateTimeRange;
    _startDate = dateTimeRange.start;
    _endDate = dateTimeRange.end;
    notifyListeners();  // Notify listeners (UI will be updated)
  }

  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  String searchValue = '';

  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July',
    'August', 'September', 'October', 'November', 'December',
  ];

  List<String> get filteredMonths {
    return months
        .where((month) => month.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();
  }

  void updateSearchValue(String value) {
    searchValue = value;
    notifyListeners();
  }

}