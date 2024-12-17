//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class StudentFeeModel {
//   double amount;
//   double lateFee;
//   double paidAmount;
//   DateTime paidDate;
//   double pendingDues;
//   double previousMonthDues;
//   double scholarshipDiscount;
//   String status;
//   String monthYear;
//
//   StudentFeeModel({
//     required this.amount,
//     required this.lateFee,
//     required this.paidAmount,
//     required this.paidDate,
//     required this.pendingDues,
//     required this.previousMonthDues,
//     required this.scholarshipDiscount,
//     required this.status,
//   });
//
//   factory StudentFeeModel.fromMap(Map<String, dynamic> data) {
//     return StudentFeeModel(
//       amount: data['amount'] ?? '',
//       lateFee: data['lateFee'] ?? '',
//       paidAmount: data['paidAmount'] ?? '',
//       paidDate: (data['paidDate'] as Timestamp).toDate(),
//       pendingDues: data['pendingDues'] ?? '',
//       previousMonthDues: data['previousMonthDues'] ?? '',
//       scholarshipDiscount: data['scholarshipDiscount'] ?? '',
//       status: data['status'] ?? '',
//     );
//   }
//
//   // Convert the instance to a Map
//   Map<String, dynamic> toMap() {
//     return {
//       'amount': amount,
//       'lateFee': lateFee,
//       'paidAmount': paidAmount,
//       'paidDate': Timestamp.fromDate(paidDate),
//       'pendingDues': pendingDues,
//       'previousMonthDues': previousMonthDues,
//       'scholarshipDiscount': scholarshipDiscount,
//       'status': status,
//     };
//   }
// }
