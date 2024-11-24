import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:legends_schools_admin/model/daily_expense_model.dart';
import 'package:legends_schools_admin/provider/constant/drop_down_provider.dart';
import 'package:legends_schools_admin/provider/fee_management_provider.dart';
import 'package:legends_schools_admin/config/util/time_utils.dart';
import 'package:provider/provider.dart';

import '../../config/enum/fee_type.dart';
import '../../config/util/app_utils.dart';
import '../../constant.dart';
import '../../model/fee.dart';
import '../../model/fees_model.dart';
import '../../model/registration_form_model.dart';
import '../../model/teacher_model.dart';

class RegistrationProvider extends ChangeNotifier{


  String _totalDues = "0";
  String _formType = "new";
  String _totalSubjectFee = "0";


  var nameController = TextEditingController();
  var fatherNameController = TextEditingController();
  var fatherCNICController = TextEditingController();
  var groupNameController = TextEditingController();
  var schoolNameController = TextEditingController();
  var paperFundFeeController = TextEditingController();
  var admissionFeeController = TextEditingController();
  var overtimeFeeController = TextEditingController();
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
    paperFundFee: '',
    admissionFee: '',
    overtimeFee: '',
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
  String get formType => _formType;
  String get totalSubjectFee => _totalSubjectFee;
  RegistrationFormModel get student => _student;

  void updateStudent(RegistrationFormModel student,{String type = "new"}) {
    _student = student;
    _formType = type;
    notifyListeners();
  }

  void updateType(String type){
    _formType = type;
    notifyListeners();
  }

  Future<void> updateStudentData() async{
    await firestore.collection('students').doc(_student.formId).update(_student.toMap()).whenComplete((){
      AppUtils().showToast(text: "Student Update Successfully");
    });
  }


  Future<void> uploadStudentData(BuildContext context) async {

    final provider = Provider.of<FeeManagementProvider>(context,listen: false);

    await firestore.collection('students').doc(_student.formId).set(_student.toMap()).whenComplete((){
      AppUtils().showToast(text: "Student Registered Successfully");
    });

    final fee = Fee(
      amount: double.parse(_student.totalDues),
      status: _student.feeStatus == "PAID" ? FeeType.Paid.name : FeeType.Unpaid.name,
      paidAmount: 0,
      paidDate: DateTime(2024, 1, 15),
      pendingDues: 0.0,
      previousMonthDues: 0.0,
      lateFee: 0.0,
      scholarshipDiscount: 0.0,
    );

    await provider.addFeeAndUpdateMonthlyStatus(
        studentId: _student.formId,
        feeModel: fee,
        monthYear: TimeUtils().getMonthYearFromTimestamp()
    );

  }

  Future<void> addFee(String studentId, Fee fee) async {
    await firestore
        .collection('students')
        .doc(studentId)
        .collection('fees')
        .add(fee.toMap());
    notifyListeners();
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
      }else{
        paymentHistory.add({
          'paymentDate': DateTime.now().toIso8601String(),
          'timeStamp': DateTime.now().toIso8601String(),
          'amount': "0",
          'paymentMethod': 'Cash',
          'receiptId': '1234312'
        });
        amountDue = amountDue;
        amountPaid = "0";
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
    final DateTime startOfWeek = now.subtract(const Duration(days: 7));
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
    paperFundFeeController.text = "0";
    admissionFeeController.text = "0";
    overtimeFeeController.text = "0";
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
        student.name.toLowerCase().contains(_searchTerm) ||
        student.className.contains(_searchTerm);
  }

  List<DailyExpenseModel> filterExpenses(
      List<DailyExpenseModel> expenses) {
    return expenses.where((expense) {
      return expense.description.toLowerCase().contains(_searchTerm) ||
          expense.paymentMethod.toLowerCase().contains(_searchTerm) ||
          expense.timeStamp.contains(_searchTerm);
    }).toList();
  }

  bool filterTeachers(TeacherModel student) {
    return student.teacherCNIC.contains(_searchTerm) ||
        student.teacherClass.contains(_searchTerm) ||
        student.teacherName.contains(_searchTerm);
  }


  void showUpdateData(BuildContext context){
    
    final provider = Provider.of<DropdownProvider>(context,listen: false);
    
    registrationController.text = _student.registrationNumber;
    nameController.text = _student.name;
    fatherNameController.text = _student.fatherName;
    fatherCNICController.text = _student.fatherCNIC;
    dobController.text = _student.studentDOB;
    religionController.text = _student.religion;
    nationalityController.text = _student.nationality;
    addressController.text = _student.address;
    contactNumberController.text = _student.contactNumber;
    whatsappNumberController.text = _student.whatsappNumber;
    medicalConditionController.text = _student.medicalCondition;
    residenceNumberController.text = _student.residenceNumber;
    bFormController.text = _student.bForm;
    studentReferenceController.text = _student.referenceName;
    imageURLController.text = _student.pdfImageUrl;
    feeController.text = _student.feePlan;
    schoolNameController.text = _student.schoolName;
    admissionFeeController.text = _student.paperFundFee;
    paperFundFeeController.text = _student.admissionFee;
    overtimeFeeController.text = _student.overtimeFee;
    discountController.text = _student.discountCharges;

    feeController.text = _student.totalDues;

    provider.selectedGender = _student.gender;
    provider.selectedClass = _student.className;
    if(_student.fatherOccupation.isNotEmpty){
      provider.selectedGroup = _student.fatherOccupation;
    }


  }

}