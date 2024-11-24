import 'package:legends_schools_admin/model/registration_form_model.dart';
import 'package:legends_schools_admin/model/student_model.dart';

class FeeStatusModel {
  String id;
  double amount;
  String paidDate;
  double previousMonthDues;
  RegistrationFormModel? students;
  String status;

  FeeStatusModel({
    required this.id,
    required this.amount,
    required this.paidDate,
    required this.previousMonthDues,
    required this.students,
    required this.status,
  });

  factory FeeStatusModel.fromMap(Map<String, dynamic> data) {
    return FeeStatusModel(
      id: data['id'] ?? '',
      amount: data['amount'] ?? '',
      paidDate: data['paidDate'] ?? '',
      previousMonthDues: data['previousMonthDues'] ?? '',
      status: data['status'] ?? '',
      students: null,
    );
  }

  // Convert the instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'paidDate': paidDate,
      'previousMonthDues': previousMonthDues,
    };
  }
}
