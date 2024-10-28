import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../constant.dart';
import '../../model/registration_form_model.dart';

class RegistrationProvider extends ChangeNotifier{

  String _totalDues = "0";
  String _totalSubjectFee = "0";
  RegistrationFormModel _student = RegistrationFormModel(
    studentFormID: '',
    registrationNumber: '',
    studentName: '',
    studentStatus: '',
    feeStatus: '',
    studentFatherName: '',
    fatherCNIC: '',
    studentDOB: '',
    religion: '',
    nationality: '',
    medicalCondition: '',
    studentAddress: '',
    schoolName: '',
    languageSpoken: '',
    refferranceName: '',
    studentImageUrl: '',
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
    studentClassName: '',
    studentGroupName: '',
    totalDues: '',
    subject1: '',
    subject2: '',
    subject3: '',
    subject4: '',
    subject5: '',
    subject6: '',
    subject7: '',
    subject8: '',
    subject9: '',
    subject1Price: '',
    subject2Price: '',
    subject3Price: '',
    subject4Price: '',
    subject5Price: '',
    subject6Price: '',
    subject7Price: '',
    subject8Price: '',
    subject9Price: '',
    studentImageProfile: '',
    totalSubjectFee: '',
    feePlan: '',
  );

  String get totalDues => _totalDues;
  String get totalSubjectFee => _totalSubjectFee;
  RegistrationFormModel get student => _student;

  void updateStudent(RegistrationFormModel student) {
    _student = student;
    notifyListeners();
  }

  Future<void> uploadStudentData() async {
    await firestore.collection('students').doc(_student.studentFormID).set(_student.toMap()).whenComplete((){
      Get.snackbar("Student Registration Completed","");
    });
  }
  void setTotalDues(String value){
    _totalDues = value;
    notifyListeners();
  }

  void setTotalSubjectFee(String value){
    _totalSubjectFee = value;
    notifyListeners();
  }


}