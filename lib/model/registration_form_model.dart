import 'package:intl/intl.dart';

class RegistrationFormModel {
  String studentFormID;
  String registrationNumber;
  String studentName;
  String studentStatus;
  String studentFatherName;
  String fatherCNIC;
  String studentDOB;
  String religion;
  String nationality;
  String medicalCondition;
  String studentAddress;
  String schoolName;
  String languageSpoken;
  String refferranceName;
  String studentImageUrl;
  String contactNumber;
  String whatsappNumber;
  String residenceNumber;
  String dailyTest;
  String servicesFee;
  String extraCharges;
  String discountCharges;
  String gender;
  String? admissionDate;
  String admissionTime;
  String studentClassName;
  String studentGroupName;
  String totalDues;
  String subject1;
  String subject2;
  String subject3;
  String subject4;
  String subject5;
  String subject6;
  String subject7;
  String subject8;
  String subject9;
  String subject1Price;
  String subject2Price;
  String subject3Price;
  String subject4Price;
  String subject5Price;
  String subject6Price;
  String subject7Price;
  String subject8Price;
  String subject9Price;
  String studentImageProfile;
  String feeStatus;
  String totalSubjectFee;
  String feePlan;
  DateTime timestamp;

  RegistrationFormModel({
    required this.studentFormID,
    required this.registrationNumber,
    required this.studentName,
    required this.studentStatus,
    required this.studentFatherName,
    required this.fatherCNIC,
    required this.studentDOB,
    required this.religion,
    required this.nationality,
    required this.medicalCondition,
    required this.studentAddress,
    required this.schoolName,
    required this.languageSpoken,
    required this.refferranceName,
    required this.studentImageUrl,
    required this.contactNumber,
    required this.whatsappNumber,
    required this.residenceNumber,
    required this.dailyTest,
    required this.servicesFee,
    required this.extraCharges,
    required this.discountCharges,
    required this.gender,
    required this.feeStatus,
    String? admissionDate,
    String? admissionTime,
    required this.studentClassName,
    required this.studentGroupName,
    required this.totalDues,
    required this.subject1,
    required this.subject2,
    required this.subject3,
    required this.subject4,
    required this.subject5,
    required this.subject6,
    required this.subject7,
    required this.subject8,
    required this.subject9,
    required this.subject1Price,
    required this.subject2Price,
    required this.subject3Price,
    required this.subject4Price,
    required this.subject5Price,
    required this.subject6Price,
    required this.subject7Price,
    required this.subject8Price,
    required this.subject9Price,
    required this.totalSubjectFee,
    required this.feePlan,
    required this.studentImageProfile,
  })  : this.admissionDate = admissionDate ?? DateFormat('dd/MMMM,yyyy').format(DateTime.now()),
        this.admissionTime = admissionTime ?? DateFormat('hh:mm a').format(DateTime.now()),
        this.timestamp = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'studentFormID': studentFormID,
      'registrationNumber': registrationNumber,
      'studentName': studentName,
      'studentStatus': studentStatus,
      'studentFatherName': studentFatherName,
      'fatherCNIC': fatherCNIC,
      'studentDOB': studentDOB,
      'religion': religion,
      'nationality': nationality,
      'medicalCondition': medicalCondition,
      'studentAddress': studentAddress,
      'schoolName': schoolName,
      'languageSpoken': languageSpoken,
      'refferranceName': refferranceName,
      'studentImageUrl': studentImageUrl,
      'contactNumber': contactNumber,
      'whatsappNumber': whatsappNumber,
      'residenceNumber': residenceNumber,
      'dailyTest': dailyTest,
      'servicesFee': servicesFee,
      'extraCharges': extraCharges,
      'discountCharges': discountCharges,
      'gender': gender,
      'admissionDate': admissionDate,
      'admissionTime': admissionTime,
      'studentClassName': studentClassName,
      'studentGroupName': studentGroupName,
      'totalDues': totalDues,
      'subject1': subject1,
      'subject2': subject2,
      'subject3': subject3,
      'subject4': subject4,
      'subject5': subject5,
      'subject6': subject6,
      'subject7': subject7,
      'subject8': subject8,
      'subject9': subject9,
      'subject1Price': subject1Price,
      'subject2Price': subject2Price,
      'subject3Price': subject3Price,
      'subject4Price': subject4Price,
      'subject5Price': subject5Price,
      'subject6Price': subject6Price,
      'subject7Price': subject7Price,
      'subject8Price': subject8Price,
      'subject9Price': subject9Price,
      'studentImageProfile': studentImageProfile,
      'timestamp': timestamp,
      'feeStatus': feeStatus,
      'totalSubjectFee': totalSubjectFee,
      'feePlan': feePlan,
    };
  }

  factory RegistrationFormModel.fromFirestore(Map<String, dynamic> data) {
    return RegistrationFormModel(
      studentFormID: data['studentFormID'] ?? '',
      registrationNumber: data['registrationNumber'] ?? '',
      studentName: data['studentName'] ?? '',
      studentStatus: data['studentStatus'] ?? '',
      studentFatherName: data['studentFatherName'] ?? '',
      fatherCNIC: data['fatherCNIC'] ?? '',
      studentDOB: data['studentDOB'] ?? '',
      religion: data['religion'] ?? '',
      nationality: data['nationality'] ?? '',
      medicalCondition: data['medicalCondition'] ?? '',
      studentAddress: data['studentAddress'] ?? '',
      schoolName: data['schoolName'] ?? '',
      languageSpoken: data['languageSpoken'] ?? '',
      refferranceName: data['refferranceName'] ?? '',
      studentImageUrl: data['studentImageUrl'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      whatsappNumber: data['whatsappNumber'] ?? '',
      residenceNumber: data['residenceNumber'] ?? '',
      dailyTest: data['dailyTest'] ?? '',
      servicesFee: data['servicesFee'] ?? '',
      extraCharges: data['extraCharges'] ?? '',
      discountCharges: data['discountCharges'] ?? '',
      gender: data['gender'] ?? '',
      feeStatus: data['feeStatus'] ?? '',
      admissionDate: data['admissionDate'],
      admissionTime: data['admissionTime'] ?? '',
      studentClassName: data['studentClassName'] ?? '',
      studentGroupName: data['studentGroupName'] ?? '',
      totalDues: data['totalDues'] ?? '',
      subject1: data['subject1'] ?? '',
      subject2: data['subject2'] ?? '',
      subject3: data['subject3'] ?? '',
      subject4: data['subject4'] ?? '',
      subject5: data['subject5'] ?? '',
      subject6: data['subject6'] ?? '',
      subject7: data['subject7'] ?? '',
      subject8: data['subject8'] ?? '',
      subject9: data['subject9'] ?? '',
      subject1Price: data['subject1Price'] ?? '',
      subject2Price: data['subject2Price'] ?? '',
      subject3Price: data['subject3Price'] ?? '',
      subject4Price: data['subject4Price'] ?? '',
      subject5Price: data['subject5Price'] ?? '',
      subject6Price: data['subject6Price'] ?? '',
      subject7Price: data['subject7Price'] ?? '',
      subject8Price: data['subject8Price'] ?? '',
      subject9Price: data['subject9Price'] ?? '',
      studentImageProfile: data['studentImageProfile'] ?? '',
      totalSubjectFee: data['totalSubjectFee'] ?? '',
      feePlan: data['feePlan'] ?? '',
    );
  }
}
