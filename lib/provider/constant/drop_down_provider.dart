import 'package:flutter/cupertino.dart';

class DropdownProvider extends ChangeNotifier{

  // Fee Status
  String _selectedFeeStatus = 'Select Fee Status';
  final List<String> _feeStatusList = ['Select Fee Status','PAID','UNPAID'];

  List<String> get feeStatusList => _feeStatusList;
  String get selectedFeeStatus => _selectedFeeStatus;

  void changeFeeStatus(String gender){
    _selectedFeeStatus = gender;
    notifyListeners();
  }

  // gender
  String _selectedGender = 'Select Gender';
  final List<String> _genderList = ['Select Gender','MALE','FEMALE','OTHER'];

  List<String> get genderList => _genderList;
  String get selectedGender => _selectedGender;

  set selectedGender(String value) {
    _selectedGender = value;
  }
  void changeGender(String gender){
    _selectedGender = gender;
    notifyListeners();
  }

  // Fee Plans
  String _selectedFeePlan = 'MONTHLY';
  final List<String> _feePlanList = ['MONTHLY'];

  List<String> get feePlanList => _feePlanList;
  String get selectedFeePlan => _selectedFeePlan;

  void changeFeePlan(String plan){
    _selectedFeePlan = plan;
    notifyListeners();
  }

  // class
  String _selectedClass = 'Select Class';
  final List<String> _classList = [
    'Select Class',
    'Play',
    'Nursery',
    'Prep',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six girls',
    'Six boys',
    'Seven Girls',
    'Seven Boys',
    'Eight Girls',
    'Eight Boys',
    'Nine Girls',
    'Nine Boys',
    'Ten Girls',
    'Ten Boys',
    '1st year girls',
    '1st year boys',
    '2nd year girls',
    '2nd year boys',
  ];

  List<String> get classList => _classList;
  String get selectedClass => _selectedClass;

  set selectedClass(String value){
    _selectedClass = value;
  }

  void changeClass(String studentClass){
    _selectedClass = studentClass;
    notifyListeners();
  }

  // group

  String _selectedGroup = 'Select Occupation';
  final List<String> _groupList = [
    'Select Occupation',
    "AGRICULTURE",
    "NON AGRICULTURE",
  ];

  List<String> get groupList => _groupList;
  String get selectedGroup => _selectedGroup;

  set selectedGroup(String value){
    _selectedGroup = value;
  }

  void changeGroup(String studentGroup){
    _selectedGroup = studentGroup;
    notifyListeners();
  }

  // Academy Status
  String _selectedStatus = 'Select Student Status';
  final List<String> _statusList = [
    'Select Student Status',
    "ACTIVE",
    "LEAVE",
  ];

  List<String> get statusList => _statusList;
  String get selectedStatus => _selectedStatus;

  void changeAcademyStatus(String academyStatus){
    _selectedStatus = academyStatus;
    notifyListeners();
  }

  String _selectedExpense = 'Other';
  final List<String> _studentExpenseList = [
    "Stationary",
    "Other",
  ];

  List<String> get studentExpenseList => _studentExpenseList;
  String get selectedExpense => _selectedExpense;

  void updateExpenseType(int index){
    _selectedExpense = _studentExpenseList[index];
    notifyListeners();
  }




  void clear(){
    _selectedClass = 'Select Class';
    _selectedGroup = 'Select Occupation';
    _selectedStatus = 'ACTIVE';
    _selectedGender = 'Select Gender';
    _selectedFeeStatus  = 'Select Fee Status';
    notifyListeners();
  }

}