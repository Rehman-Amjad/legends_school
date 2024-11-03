import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:legends_schools_admin/utils/web_utils.dart';

import '../../config/util/app_utils.dart';
import '../../constant.dart';
import '../../model/fees_model.dart';
import '../../model/registration_form_model.dart';
import '../../model/student_model.dart';
import '../../model/teacher_model.dart';

class RegistrationProvider extends ChangeNotifier{

  String _totalDues = "0";
  String _totalSubjectFee = "0";


  var nameController = TextEditingController();
  var fatherNameController = TextEditingController();
  var fatherCNICController = TextEditingController();
  var groupNameController = TextEditingController();
  var schoolNameController = TextEditingController();
  var dailyTestController = TextEditingController();
  var servicesChargesController = TextEditingController();
  var extraChargesController = TextEditingController();
  var discountController = TextEditingController();
  var bFormController = TextEditingController();
  var studentReferenceController = TextEditingController();
  var feeController = TextEditingController();

  var dobController = TextEditingController();
  var religionController = TextEditingController();
  var nationalityController = TextEditingController();
  var addressController = TextEditingController();
  var contactNumberController = TextEditingController();
  var whatsappNumberController = TextEditingController();
  var medicalConditionController = TextEditingController();
  var residenceNumberController = TextEditingController();
  var registrationController = TextEditingController();
  var imageURLController = TextEditingController();


  RegistrationFormModel _student = RegistrationFormModel(
    formId: '',
    bForm: '',
    registrationNumber: '',
    name: '',
    status: '',
    feeStatus: '',
    fatherName: '',
    fatherCNIC: '',
    studentDOB: '',
    religion: '',
    nationality: '',
    medicalCondition: '',
    address: '',
    schoolName: '',
    fatherOccupation: '',
    referenceName: '',
    pdfImageUrl: '',
    contactNumber: '',
    whatsappNumber: '',
    residenceNumber: '',
    dailyTest: '',
    servicesFee: '',
    extraCharges: '',
    discountCharges: '',
    gender: '',
    admissionDate: '',
    admissionTime: '',
    className: '',
    groupName: '',
    totalDues: '',
    profileImage: '',
    feePlan: '', timestamp: '',
  );

  String get totalDues => _totalDues;
  String get totalSubjectFee => _totalSubjectFee;
  RegistrationFormModel get student => _student;

  void updateStudent(RegistrationFormModel student) {
    _student = student;
    notifyListeners();
  }

  Future<void> uploadStudentData() async {

    await firestore.collection('students').doc(_student.formId).set(_student.toMap()).whenComplete((){
      AppUtils().showToast(text: "Student Registered Successfully");
    });

    await saveFeeData(
        studentId: student.registrationNumber,
        billingCycle: WebUtils().formatTimeMonthYear(DateTime.now().millisecondsSinceEpoch).toString(),
        dueDate: DateTime.now(),
        amountDue: student.totalDues.toString(),
        amountPaid: "0",
        paymentStatus: student.feeStatus,

    );
  }
  void setTotalDues(String value){
    _totalDues = value;
    notifyListeners();
  }

  void setTotalSubjectFee(String value){
    _totalSubjectFee = value;
    notifyListeners();
  }

  Future<void> saveFeeData({
    required String studentId,
    required String billingCycle,
    required DateTime dueDate,
    required String amountDue,
    required String amountPaid,
    required String paymentStatus,
  }) async {
    try {
      List<Map<String, dynamic>> paymentHistory = [];
      if(paymentStatus == "PAID" || paymentStatus == "paid"){
        paymentHistory.add({
          'paymentDate': DateTime.now().toIso8601String(),
          'timeStamp': DateTime.now().toIso8601String(),
          'amount': amountPaid,
          'paymentMethod': 'Cash',
          'receiptId': 'receiptId123'
        });
        amountDue = "0";
        amountPaid = amountDue;
      }

      DocumentReference feeRef = firestore.collection('Fees').doc(studentId);

      await feeRef.set({
        'studentId': studentId,
        'billingCycle': billingCycle,
        'dueDate': dueDate.toIso8601String(),
        'amountDue': amountDue,
        'timeStamp': DateTime.now().millisecondsSinceEpoch.toString(),
        'amountPaid': amountPaid,
        'paymentStatus': paymentStatus,
        'paymentHistory': paymentHistory,
      });
      notifyListeners();
    } catch (error) {
      log('Error saving fee data: $error');
    }
  }


  Stream<List<FeeModel>> getCurrentMonthFees() {
    final DateTime now = DateTime.now();
    final DateTime startOfMonth = DateTime(now.year, now.month, 1);
    return _queryFees(startOfMonth, now);
  }

  // Get fees for today
  Stream<List<FeeModel>> getTodayFees() {
    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day);
    return _queryFees(startOfDay, now);
  }

  // Get fees for the last week
  Stream<List<FeeModel>> getLastWeekFees() {
    final DateTime now = DateTime.now();
    final DateTime startOfWeek = now.subtract(Duration(days: 7));
    return _queryFees(startOfWeek, now);
  }

  // Get fees for a custom date range
  Stream<List<FeeModel>> getFeesInDateRange(DateTime startDate, DateTime endDate) {
    return _queryFees(startDate, endDate);
  }

  Stream<List<FeeModel>> _queryFees(DateTime startDate, DateTime endDate) {
    return firestore
        .collection('Fees')
        .where('dueDate', isGreaterThanOrEqualTo: startDate.toIso8601String())
        .where('dueDate', isLessThanOrEqualTo: endDate.toIso8601String())
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => FeeModel.fromDocument(doc.data(), doc.id)).toList());
  }


  void resetAllControllers() {
    nameController.text = "";
    fatherNameController.text = "";
    fatherCNICController.text = "";
    groupNameController.text = "";
    schoolNameController.text = "";
    dailyTestController.text = "0";
    servicesChargesController.text = "0";
    extraChargesController.text = "0";
    discountController.text = "0";
    bFormController.text = "";
    studentReferenceController.text = "";
    dobController.text = "";
    religionController.text = "";
    nationalityController.text = "";
    addressController.text = "";
    contactNumberController.text = "";
    whatsappNumberController.text = "";
    medicalConditionController.text = "";
    residenceNumberController.text = "";
    registrationController.text = "";
    imageURLController.text = "";
    feeController.text = "";
  }

  // search filder
  String _searchTerm = "";

  void updateSearchTerm(String term) {
    _searchTerm = term;
    notifyListeners();
  }

  bool filterAdmissions(RegistrationFormModel student) {
    return student.fatherCNIC.contains(_searchTerm) ||
        student.address.contains(_searchTerm) ||
        student.className.contains(_searchTerm);
  }

  bool filterTeachers(TeacherModel student) {
    return student.teacherCNIC.contains(_searchTerm) ||
        student.teacherClass.contains(_searchTerm) ||
        student.teacherName.contains(_searchTerm);
  }

}