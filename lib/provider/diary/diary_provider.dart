import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:legends_schools_admin/config/keys/db_key.dart';

import '../../constant.dart';
import '../../model/diary/diary_model.dart';

class DiaryProvider extends ChangeNotifier{


  final titleC = TextEditingController();

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  DateTime? _startDate;
  DateTime? _endDate;

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  void setStartDate(DateTime date) {
    _startDate = DateTime(date.year, date.month, date.day);
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    _endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);
    notifyListeners();
  }

  void clearDateFilter() {
    _startDate = null;
    _endDate = null;
    notifyListeners();
  }

  // Update your existing filterDiary method or add a new one
  List<DiaryModel> filterDiaryByDate(List<DiaryModel> diaries) {
    if (_startDate == null && _endDate == null) return diaries;

    return diaries.where((diary) {
      // Convert milliseconds string to DateTime
      DateTime diaryDate = DateTime.fromMillisecondsSinceEpoch(
          int.parse(diary.timeStamp)
      );

      if (_startDate != null && _endDate != null) {
        return diaryDate.isAtSameMomentAs(_startDate!) ||
            diaryDate.isAtSameMomentAs(_endDate!) ||
            (diaryDate.isAfter(_startDate!) && diaryDate.isBefore(_endDate!));
      } else if (_startDate != null) {
        return diaryDate.isAtSameMomentAs(_startDate!) || diaryDate.isAfter(_startDate!);
      } else {
        return diaryDate.isAtSameMomentAs(_endDate!) || diaryDate.isBefore(_endDate!);
      }
    }).toList();
  }

  String getMonthName(int month) {
    switch (month) {
      case 1: return 'January';
      case 2: return 'February';
      case 3: return 'March';
      case 4: return 'April';
      case 5: return 'May';
      case 6: return 'June';
      case 7: return 'July';
      case 8: return 'August';
      case 9: return 'September';
      case 10: return 'October';
      case 11: return 'November';
      case 12: return 'December';
      default: return '';
    }
  }

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


  void updateClass(int index){
    _selectedClass = _classList[index];
    notifyListeners();
  }


  String _selectedSubject = 'Select Subject';
  final List<String> _subjectList = [
    'Select Subject',
    'Mathematics',
    'Science',
    'English',
    'Urdu',
    'Islamiat',
    'Social Study',
    'Home Economics',
    'Physics',
  ];
  List<String> get subjectList => _subjectList;
  String get selectedSubject => _selectedSubject;


  void updateSubject(int index){
    _selectedSubject = _subjectList[index];
    notifyListeners();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadDiary(DiaryModel diaryEntry) async {
    try {
      await _firestore.collection(DbKey.studentDiary)
          .doc(diaryEntry.date)
          .set(diaryEntry.toJson());
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to upload diary: $e");
    }
  }

  Stream<List<DiaryModel>> getDiary({int? limit,String? monthYear, required String formID}) {
    Query query = firestore
        .collection(DbKey.studentDiary);

    if (limit != null) {
      query = query.limit(limit);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DiaryModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<DiaryModel>> fetchDiaries() {
    return _firestore
        .collection(DbKey.studentDiary)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      final data = doc.data();
      return DiaryModel(
        title: data['title'] ?? "",
        description: data['description'] ?? "",
        classId: data['classId'] ?? "",
        subjectId: data['subjectId'] ?? "",
        studentId: data['studentId'] ?? '',
        date: data['date'] ?? "",
        timeStamp: data['timeStamp'] ?? "",
      );
    }).toList());
  }

}