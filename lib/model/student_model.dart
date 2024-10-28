class StudentModel {
  final String id;
  final String admissionDate;
  final String admissionID;
  final String admissionTime;
  final String admissionYear;
  final String agri;
  final String appPassword;
  final String bForm;
  final String contactNumber;
  final String dateOfBirth;
  final String fatherCNIC;
  final String fatherName;
  final String formSaveMonth;
  final String formSaveYear;
  final String occupation;
  final String pdfImageUrl;
  final String registrationNumber;
  final String religion;
  final String residenceNumber;
  final String schoolAddress;
  final String schoolName;
  final String studentAddress;
  final String studentClassName;
  final String studentFee;
  final String studentImage;
  final String studentName;
  final String studentStatus;
  final String timeStamp;

  StudentModel({
    required this.id,
    required this.admissionDate,
    required this.admissionID,
    required this.admissionTime,
    required this.admissionYear,
    required this.agri,
    required this.appPassword,
    required this.bForm,
    required this.contactNumber,
    required this.dateOfBirth,
    required this.fatherCNIC,
    required this.fatherName,
    required this.formSaveMonth,
    required this.formSaveYear,
    required this.occupation,
    required this.pdfImageUrl,
    required this.registrationNumber,
    required this.religion,
    required this.residenceNumber,
    required this.schoolAddress,
    required this.schoolName,
    required this.studentAddress,
    required this.studentClassName,
    required this.studentFee,
    required this.studentImage,
    required this.studentName,
    required this.studentStatus,
    String? timeStamp, // Optional parameter for createdAt
  }) : timeStamp = timeStamp ?? DateTime.now().millisecondsSinceEpoch.toString(); // Default to current timestamp

  factory StudentModel.fromMap(Map<String, dynamic> data) {
    return StudentModel(
      id: data['id'] ?? '',
      admissionDate: data['admissionDate'] ?? '',
      admissionID: data['admissionID'] ?? '',
      admissionTime: data['admissionTime'] ?? '',
      admissionYear: data['admissionYear'] ?? '',
      agri: data['agri'] ?? '',
      appPassword: data['appPassword'] ?? '',
      bForm: data['bForm'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      dateOfBirth: data['dateOfBirth'] ?? '',
      fatherCNIC: data['fatherCNIC'] ?? '',
      fatherName: data['fatherName'] ?? '',
      formSaveMonth: data['formSaveMonth'] ?? '',
      formSaveYear: data['formSaveYear'] ?? '',
      occupation: data['occupation'] ?? '',
      pdfImageUrl: data['pdfImageUrl'] ?? '',
      registrationNumber: data['registrationNumber'] ?? '',
      religion: data['religion'] ?? '',
      residenceNumber: data['residenceNumber'] ?? '',
      schoolAddress: data['schoolAddress'] ?? '',
      schoolName: data['schoolName'] ?? '',
      studentAddress: data['studentAddress'] ?? '',
      studentClassName: data['studentClassName'] ?? '',
      studentFee: data['studentFee'] ?? '',
      studentImage: data['studentImage'] ?? '',
      studentName: data['studentName'] ?? '',
      studentStatus: data['studentStatus'] ?? '',
        timeStamp: data['timeStamp'] ?? '',
    );
  }
}
