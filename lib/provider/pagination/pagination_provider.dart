import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:legends_schools_admin/model/diary/diary_model.dart';
import 'package:legends_schools_admin/model/fee/student_fee_model.dart';

import '../../model/daily_expense_model.dart';
import '../../model/fee.dart';

class PaginationProvider with ChangeNotifier {
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  int get currentPage => _currentPage;

  int get itemsPerPage => _itemsPerPage;

  void goToNextPage(int totalItems) {
    final totalPages = (totalItems / itemsPerPage).ceil();
    if (_currentPage < totalPages) {
      _currentPage++;
      log("Navigated to next page: $_currentPage");
      notifyListeners();
    }
  }


  void goToPreviousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      log("Navigated to previous page: $_currentPage");
      notifyListeners();
    }
  }

  List<DailyExpenseModel> getPaginatedData(List<DailyExpenseModel> data) {
    final startIndex = (_currentPage - 1) * itemsPerPage;
    final endIndex = (_currentPage * itemsPerPage).clamp(0, data.length);

    log("Fetching data for Page: $_currentPage (Start: $startIndex, End: $endIndex, Total Items: ${data.length})");
    if (startIndex >= data.length) {
      log("Start index exceeds data length. Returning empty list.");
      return [];
    }

    return data.sublist(startIndex, endIndex);
  }

  List<DiaryModel> getDiaryData(List<DiaryModel> data) {
    final startIndex = (_currentPage - 1) * itemsPerPage;
    final endIndex = (_currentPage * itemsPerPage).clamp(0, data.length);

    log("Fetching data for Page: $_currentPage (Start: $startIndex, End: $endIndex, Total Items: ${data.length})");
    if (startIndex >= data.length) {
      log("Start index exceeds data length. Returning empty list.");
      return [];
    }

    return data.sublist(startIndex, endIndex);
  }


  // Fee pay Screen
  int _singleStudentPage = 1;
  final int _itemsSingleStudentPerPage = 10;

  int get singleStudentPage => _singleStudentPage;

  int get itemsSingleStudentPerPage => _itemsSingleStudentPerPage;

  void singleStudentNextPage(int totalItems) {
    final totalPages = (totalItems / itemsSingleStudentPerPage).ceil();
    if (_singleStudentPage < totalPages) {
      _singleStudentPage++;
      log("Navigated to next page: $_singleStudentPage");
      notifyListeners();
    }
  }


  void singleStudentPreviousPage() {
    if (_singleStudentPage > 1) {
      _singleStudentPage--;
      log("Navigated to previous page: $_singleStudentPage");
      notifyListeners();
    }
  }

  List<StudentFeeModel> getSingleStudentPaginatedData(List<StudentFeeModel> data) {
    final startIndex = (_singleStudentPage - 1) * itemsSingleStudentPerPage;
    final endIndex = (_singleStudentPage * itemsSingleStudentPerPage).clamp(0, data.length);

    log("Fetching data for Page: $_singleStudentPage (Start: $startIndex, End: $endIndex, Total Items: ${data.length})");
    if (startIndex >= data.length) {
      log("Start index exceeds data length. Returning empty list.");
      return [];
    }

    return data.sublist(startIndex, endIndex);
  }
}
