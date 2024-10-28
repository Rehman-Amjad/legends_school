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

  void changeGender(String gender){
    _selectedGender = gender;
    notifyListeners();
  }

  // Fee Plans
  String _selectedFeePlan = 'MONTHLY';
  final List<String> _feePlanList = ['MONTHLY','QUARTERLY','YEARLY'];

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
    'P.G',
    " K.G-I",
    " K.G-II",
    "ONE",
    "TWO",
    "THREE",
    "FOUR",
    "FIVE",
    "SIX",
    "SEVEN",
    "EIGHT",
    "NINE",
    "TEN",
    "1ST YEAR",
    "2ND YEAR",
    "B.A",
    "B.COM",
    "SUPPLEMENTARY",
    "ADVANCED",
    "LAT TEST",
    "GAT TEST",
    "HOME ECONOMICS",
    "PSYCHOLOGY",
    "COMPUTER COURSE",
  ];

  List<String> get classList => _classList;
  String get selectedClass => _selectedClass;

  void changeClass(String studentClass){
    _selectedClass = studentClass;
    notifyListeners();
  }

  // group

  String _selectedGroup = 'Select Group';
  final List<String> _groupList = [
    'Select Group',
    "NON GROUP CLASS",
    "BIO-SCIENCE",
    "ARTS",
    "COMP-SCIENCE",
    "FSC-M",
    "FSC-E",
    "ICS",
    "I.COM",
    "F.A-IT",
    "F.A",
    "PART-I",
    "PART-II",
    "COMPUTER COURSE",
  ];

  List<String> get groupList => _groupList;
  String get selectedGroup => _selectedGroup;

  void changeGroup(String studentGroup){
    _selectedGroup = studentGroup;
    notifyListeners();
  }

  // Academy Status
  String _selectedAcademyStatus = 'Select Student Status';
  final List<String> _academyStatusList = [
    'Select Student Status',
    "ACTIVE",
    "LEAVE",
  ];

  List<String> get academyStatusList => _academyStatusList;
  String get selectAcademyStatus => _selectedAcademyStatus;

  void changeAcademyStatus(String academyStatus){
    _selectedAcademyStatus = academyStatus;
    notifyListeners();
  }

  // subject list
  String _subject1 = "NONE";
  String _subject2 = "NONE";
  String _subject3 = "NONE";
  String _subject4 = "NONE";
  String _subject5 = "NONE";
  String _subject6 = "NONE";
  String _subject7 = "NONE";
  String _subject8 = "NONE";
  String _subject9 = "NONE";
  final List<String> _subjectList = [
    "NONE", "ALL SUBJECT", "SCIENCE", "MATH", "ENGLISH",
    "URDU", "PAK STUDY", "I.S", "AL.QURAN", "PHYSICS", "CHEMISTRY",
    "BIOLOGY", "COMPUTER", "IS-ELECTIVE", "EDUCATION", "PH-EDUCATION",
    "SOCIOLOGY",
    "PARSION",
    "ARABIC",
    "CIVICS",
    "STATISTICS",
    "ECONOMICS",
    "COMMERCE",
    "BANKING",
    "ACCOUNTING",
    "GEO GRAPHICS",
    "HOME ECONOMICS",
    "PUNJABI",
    "PSYCHOLOGY",
    "OTHER",
    "DIGITAL MARKETING",
    "GRAPHICS DESIGNING",
    "GRAPHICS DESIGNING",
    "MOBILE APP DEVELOPMENT",
    "WEB DEVELOPMENT",
    "CONTENT WRITING",
    "SHOPIFY STORE CREATION",
    "SPOKEN ENGLISH",
  ];

  List<String> get subjectList => _subjectList;
  String get subject1 => _subject1;
  String get subject2 => _subject2;
  String get subject3 => _subject3;
  String get subject4 => _subject4;
  String get subject5 => _subject5;
  String get subject6 => _subject6;
  String get subject7 => _subject7;
  String get subject8 => _subject8;
  String get subject9 => _subject9;

  void changeSubject1(String subject){
    _subject1 = subject;
    notifyListeners();
  }

  void changeSubject2(String subject){
    _subject2 = subject;
    notifyListeners();
  }

  void changeSubject3(String subject){
    _subject3 = subject;
    notifyListeners();
  }

  void changeSubject4(String subject){
    _subject4 = subject;
    notifyListeners();
  }

  void changeSubject5(String subject){
    _subject5 = subject;
    notifyListeners();
  }

  void changeSubject6(String subject){
    _subject6 = subject;
    notifyListeners();
  }

  void changeSubject7(String subject){
    _subject7 = subject;
    notifyListeners();
  }

  void changeSubject8(String subject){
    _subject8 = subject;
    notifyListeners();
  }

  void changeSubject9(String subject){
    _subject9 = subject;
    notifyListeners();
  }

  // Subject Price List
  String _subject1Price = "0";
  String _subject2Price = "0";
  String _subject3Price = "0";
  String _subject4Price = "0";
  String _subject5Price = "0";
  String _subject6Price = "0";
  String _subject7Price = "0";
  String _subject8Price = "0";
  String _subject9Price = "0";
  final List<String> _subjectPriceList = [
    "0",
    "500",
    "700",
    "800",
    "1000",
    "1200",
    "1300",
    "1500",
    "2000",
    "2500",
    "3000",
    "3500",
    "4000",
    "4500",
    "5000",
    "5500",
    "6000",
    "6500",
    "7000",
    "7500",
    "8000",
    "8500",
    "9000",
    "9500",
    "10000",
    "15000",
    "20000",
    "25000",
    "30000",
    "35000",
    "40000",
    "45000",
    "50000",
    "55000",
    "60000",
    "65000",
    "70000",
    "75000",
  ];

  List<String> get subjectPriceList => _subjectPriceList;
  String get subject1Price => _subject1Price;
  String get subject2Price => _subject2Price;
  String get subject3Price => _subject3Price;
  String get subject4Price => _subject4Price;
  String get subject5Price => _subject5Price;
  String get subject6Price => _subject6Price;
  String get subject7Price => _subject7Price;
  String get subject8Price => _subject8Price;
  String get subject9Price => _subject9Price;

  void changeSubject1Price(String subject){
    _subject1Price = subject;
    notifyListeners();
  }

  void changeSubject2Price(String subject){
    _subject2Price = subject;
    notifyListeners();
  }

  void changeSubject3Price(String subject){
    _subject3Price = subject;
    notifyListeners();
  }

  void changeSubject4Price(String subject){
    _subject4Price = subject;
    notifyListeners();
  }

  void changeSubject5Price(String subject){
    _subject5Price = subject;
    notifyListeners();
  }

  void changeSubject6Price(String subject){
    _subject6Price = subject;
    notifyListeners();
  }

  void changeSubject7Price(String subject){
    _subject7Price = subject;
    notifyListeners();
  }

  void changeSubject8Price(String subject){
    _subject8Price = subject;
    notifyListeners();
  }

  void changeSubject9Price(String subject){
    _subject9Price = subject;
    notifyListeners();
  }



  void clear(){
    _selectedClass = 'Select Class';
    _selectedGroup = 'Select Group';
    _selectedAcademyStatus = 'Select Academy Status';
    _selectedGender = 'Select Gender';
    _selectedFeeStatus  = 'Select Fee Status';
    _subject1 = "NONE";
    _subject2 = "NONE";
    _subject3 = "NONE";
    _subject4 = "NONE";
    _subject5 = "NONE";
    _subject6 = "NONE";
    _subject7 = "NONE";
    _subject8 = "NONE";
    _subject9 = "NONE";
    _subject1Price = "0";
    _subject2Price = "0";
    _subject3Price = "0";
    _subject4Price = "0";
    _subject5Price = "0";
    _subject6Price = "0";
    _subject7Price = "0";
    _subject8Price = "0";
    _subject9Price = "0";
    notifyListeners();
  }

}