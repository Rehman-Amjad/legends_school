import 'package:intl/intl.dart';

class RegistrationFormModel {
  String formId;
  String registrationNumber;
  String name;
  String status;
  String fatherName;
  String fatherCNIC;
  String studentDOB;
  String religion;
  String nationality;
  String medicalCondition;
  String address;
  String schoolName;
  String fatherOccupation;
  String referenceName;
  String pdfImageUrl;
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
  String className;
  String groupName;
  String totalDues;
  String profileImage;
  String feeStatus;
  String feePlan;
  String timestamp;
  String bForm;

  RegistrationFormModel({
    required this.formId,
    required this.registrationNumber,
    required this.name,
    required this.status,
    required this.fatherName,
    required this.fatherCNIC,
    required this.studentDOB,
    required this.religion,
    required this.nationality,
    required this.medicalCondition,
    required this.address,
    required this.schoolName,
    required this.fatherOccupation,
    required this.referenceName,
    required this.pdfImageUrl,
    required this.contactNumber,
    required this.whatsappNumber,
    required this.residenceNumber,
    required this.dailyTest,
    required this.servicesFee,
    required this.extraCharges,
    required this.discountCharges,
    required this.gender,
    required this.feeStatus,
    required this.timestamp,
    String? admissionDate,
    String? admissionTime ,
    required this.className,
    required this.groupName,
    required this.bForm,
    required this.totalDues,
    required this.feePlan,
    required this.profileImage,
  })  : this.admissionDate = admissionDate ?? DateFormat('dd/MMMM,yyyy').format(DateTime.now()),
        this.admissionTime = admissionTime ?? DateFormat('hh:mm a').format(DateTime.now());

  Map<String, dynamic> toMap() {
    return {
      'formId': formId,
      'registrationNumber': registrationNumber,
      'name': name,
      'status': status,
      'fatherName': fatherName,
      'fatherCNIC': fatherCNIC,
      'studentDOB': studentDOB,
      'religion': religion,
      'nationality': nationality,
      'medicalCondition': medicalCondition,
      'address': address,
      'schoolName': schoolName,
      'fatherOccupation': fatherOccupation,
      'referenceName': referenceName,
      'pdfImageUrl': pdfImageUrl,
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
      'className': className,
      'groupName': groupName,
      'totalDues': totalDues,
      'profileImage': profileImage,
      'timestamp': timestamp,
      'feeStatus': feeStatus,
      'feePlan': feePlan,
      'bForm': bForm,
    };
  }

  factory RegistrationFormModel.fromFirestore(Map<String, dynamic> data) {
    return RegistrationFormModel(
      formId: data['formId'] ?? '',
      registrationNumber: data['registrationNumber'] ?? '',
      name: data['name'] ?? '',
      status: data['status'] ?? '',
      fatherName: data['fatherName'] ?? '',
      fatherCNIC: data['fatherCNIC'] ?? '',
      studentDOB: data['studentDOB'] ?? '',
      religion: data['religion'] ?? '',
      nationality: data['nationality'] ?? '',
      medicalCondition: data['medicalCondition'] ?? '',
      address: data['address'] ?? '',
      schoolName: data['schoolName'] ?? '',
      fatherOccupation: data['fatherOccupation'] ?? '',
      referenceName: data['referenceName'] ?? '',
      pdfImageUrl: data['pdfImageUrl'] ?? '',
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
      className: data['className'] ?? '',
      groupName: data['groupName'] ?? '',
      totalDues: data['totalDues'] ?? '',
      profileImage: data['profileImage'] ?? '',
      feePlan: data['feePlan'] ?? '',
      timestamp: data['timestamp'] ?? '',
      bForm: data['bForm'] ?? '',
    );
  }
}
