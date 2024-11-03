import 'package:intl/intl.dart';

class TeacherModel {
  String address;
  String appPassword;
  // String depositSalary;
  String domicile;
  String gender;
  String jobTitle;
  String qualification;
  String registrationID;
  String pdfImageUrl;
  String teacherCNIC;
  String teacherClass;
  String teacherContact;
  String teacherFatherName;
  String teacherImage;
  String teacherName;
  String teacherSubject;
  String? admissionDate;
  String admissionTime;
  String timestamp;

  TeacherModel({
    required this.address,
    required this.appPassword,
    // required this.depositSalary,
    required this.domicile,
    required this.gender,
    required this.jobTitle,
    required this.qualification,
    required this.registrationID,
    required this.pdfImageUrl,
    required this.teacherCNIC,
    required this.teacherClass,
    required this.teacherContact,
    required this.teacherFatherName,
    required this.teacherImage,
    required this.teacherName,
    required this.teacherSubject,
    String? admissionDate,
    String? admissionTime,
    required this.timestamp,
  })  : this.admissionDate = admissionDate ?? DateFormat('dd/MMMM,yyyy').format(DateTime.now()),
        this.admissionTime = admissionTime ?? DateFormat('hh:mm a').format(DateTime.now());

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'appPassword': appPassword,
      // 'depositSalary': depositSalary,
      'domicile': domicile,
      'gender': gender,
      'jobTitle': jobTitle,
      'qualification': qualification,
      'registrationID': registrationID,
      'pdfImageUrl': pdfImageUrl,
      'teacherCNIC': teacherCNIC,
      'teacherClass': teacherClass,
      'teacherContact': teacherContact,
      'teacherFatherName': teacherFatherName,
      'teacherImage': teacherImage,
      'teacherName': teacherName,
      'teacherSubject': teacherSubject,
      'admissionDate': admissionDate,
      'admissionTime': admissionTime,
      'timestamp': timestamp,
    };
  }

  factory TeacherModel.fromFirestore(Map<String, dynamic> data) {
    return TeacherModel(
      address: data['address'] ?? '',
      appPassword: data['appPassword'] ?? '',
      // depositSalary: data['depositSalary'] ?? '',
      domicile: data['domicile'] ?? '',
      gender: data['gender'] ?? '',
      jobTitle: data['jobTitle'] ?? '',
      qualification: data['qualification'] ?? '',
      registrationID: data['registrationID'] ?? '',
      pdfImageUrl: data['pdfImageUrl'] ?? '',
      teacherCNIC: data['teacherCNIC'] ?? '',
      teacherClass: data['teacherClass'] ?? '',
      teacherContact: data['teacherContact'] ?? '',
      teacherFatherName: data['teacherFatherName'] ?? '',
      teacherImage: data['teacherImage'] ?? '',
      teacherName: data['teacherName'] ?? '',
      teacherSubject: data['teacherSubject'] ?? '',
      admissionDate: data['admissionDate'],
      admissionTime: data['admissionTime'] ?? '',
      timestamp: data['timestamp'] ?? '',
    );
  }
}
