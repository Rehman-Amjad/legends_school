import 'dart:developer';

import 'package:flutter/cupertino.dart';

class ActionProvider extends ChangeNotifier{


  static final ActionProvider _instance = ActionProvider._internal();

  factory ActionProvider() {
    return _instance;
  }

  ActionProvider._internal();


  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void selectMenu(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // toast
  String? _message;
  bool _isVisible = false;

  String? get message => _message;
  bool get isVisible => _isVisible;

  void showToast(String message) {
    _message = message;
    _isVisible = true;
    notifyListeners();

    // Automatically hide the toast after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      hideToast();
    });
  }

  void hideToast() {
    _isVisible = false;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }
}

