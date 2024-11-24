import 'package:flutter/foundation.dart';

import '../../model/daily_expense_model.dart';

class PaginationProvider with ChangeNotifier {
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  int get currentPage => _currentPage;
  int get itemsPerPage => _itemsPerPage;

  void goToNextPage(int totalItems) {
    if (_currentPage < (totalItems / _itemsPerPage).ceil()) {
      _currentPage++;
      notifyListeners();
    }
  }

  void goToPreviousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      notifyListeners();
    }
  }

  List<DailyExpenseModel> getPaginatedData(List<DailyExpenseModel> data) {
    return data.skip((_currentPage - 1) * _itemsPerPage).take(_itemsPerPage).toList();
  }
}
