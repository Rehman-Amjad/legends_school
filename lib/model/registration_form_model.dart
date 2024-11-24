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
  String paperFundFee;
  String admissionFee;
  String overtimeFee;
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
    required this.paperFundFee,
    required this.admissionFee,
    required this.overtimeFee,
    required this.discountCharges,
    required this.gender,
    required this.feeStatus,
    required this.timestamp,
    String? admissionDate,
    String? admissionTime,
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
      'paperFundFee': paperFundFee,
      'admissionFee': admissionFee,
      'overtimeFee': overtimeFee,
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
      paperFundFee: data['paperFundFee'] ?? '',
      admissionFee: data['admissionFee'] ?? '',
      overtimeFee: data['overtimeFee'] ?? '',
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

  RegistrationFormModel copyWith({
    String? formId,
    String? registrationNumber,
    String? name,
    String? status,
    String? fatherName,
    String? fatherCNIC,
    String? studentDOB,
    String? religion,
    String? nationality,
    String? medicalCondition,
    String? address,
    String? schoolName,
    String? fatherOccupation,
    String? referenceName,
    String? pdfImageUrl,
    String? contactNumber,
    String? whatsappNumber,
    String? residenceNumber,
    String? paperFundFee,
    String? admissionFee,
    String? overtimeFee,
    String? discountCharges,
    String? gender,
    String? admissionDate,
    String? admissionTime,
    String? className,
    String? groupName,
    String? totalDues,
    String? profileImage,
    String? feeStatus,
    String? feePlan,
    String? timestamp,
    String? bForm,
  }) {
    return RegistrationFormModel(
      formId: formId ?? this.formId,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      name: name ?? this.name,
      status: status ?? this.status,
      fatherName: fatherName ?? this.fatherName,
      fatherCNIC: fatherCNIC ?? this.fatherCNIC,
      studentDOB: studentDOB ?? this.studentDOB,
      religion: religion ?? this.religion,
      nationality: nationality ?? this.nationality,
      medicalCondition: medicalCondition ?? this.medicalCondition,
      address: address ?? this.address,
      schoolName: schoolName ?? this.schoolName,
      fatherOccupation: fatherOccupation ?? this.fatherOccupation,
      referenceName: referenceName ?? this.referenceName,
      pdfImageUrl: pdfImageUrl ?? this.pdfImageUrl,
      contactNumber: contactNumber ?? this.contactNumber,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      residenceNumber: residenceNumber ?? this.residenceNumber,
      paperFundFee: paperFundFee ?? this.paperFundFee,
      admissionFee: admissionFee ?? this.admissionFee,
      overtimeFee: overtimeFee ?? this.overtimeFee,
      discountCharges: discountCharges ?? this.discountCharges,
      gender: gender ?? this.gender,
      admissionDate: admissionDate ?? this.admissionDate,
      admissionTime: admissionTime ?? this.admissionTime,
      className: className ?? this.className,
      groupName: groupName ?? this.groupName,
      totalDues: totalDues ?? this.totalDues,
      profileImage: profileImage ?? this.profileImage,
      feeStatus: feeStatus ?? this.feeStatus,
      feePlan: feePlan ?? this.feePlan,
      timestamp: timestamp ?? this.timestamp,
      bForm: bForm ?? this.bForm,
    );
  }
}
