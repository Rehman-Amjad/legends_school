import 'package:cloud_firestore/cloud_firestore.dart';

class StudentFeeModel {
  final double amount;
  final String status;
  final String timestamp;
  final DateTime paidDate;
  final String monthYear;
  final double pendingDues;
  final double dailyExpense;
  double paidAmount;
  final double previousMonthDues;
  final double lateFee;
  final double scholarshipDiscount;

  StudentFeeModel({
    required this.amount,
    required this.status,
    required this.paidDate,
    required this.pendingDues,
    required this.paidAmount,
    required this.previousMonthDues,
    required this.lateFee,
    required this.scholarshipDiscount,
    required this.dailyExpense,
    required this.monthYear,
    required this.timestamp
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'status': status,
      'paidDate': Timestamp.fromDate(paidDate),
      'pendingDues': pendingDues,
      'paidAmount': paidAmount,
      'previousMonthDues': previousMonthDues,
      'lateFee': lateFee,
      'dailyExpense': dailyExpense,
      'scholarshipDiscount': scholarshipDiscount,
      'monthYear': monthYear,
      'timestamp': timestamp,
    };
  }

  factory StudentFeeModel.fromMap(Map<String, dynamic> map) {
    return StudentFeeModel(
      amount: map['amount'] ?? 0,
      status: map['status'] ?? '',
      paidDate: (map['paidDate'] as Timestamp).toDate(),
      pendingDues: map['pendingDues'] ?? 0,
      paidAmount: map['paidAmount'] ?? 0,
      previousMonthDues: map['previousMonthDues'] ?? 0,
      lateFee: map['lateFee'] ?? 0,
      dailyExpense: map['dailyExpense'] ?? 0,
      scholarshipDiscount: map['scholarshipDiscount'] ?? 0,
      monthYear: map['monthYear'] ?? "",
      timestamp: map['timestamp'] ?? "",
    );
  }
}