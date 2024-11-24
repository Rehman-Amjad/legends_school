import 'package:cloud_firestore/cloud_firestore.dart';

class Fee {
  final double amount;
  final String status;
  final DateTime paidDate;
  final double pendingDues;
  double paidAmount;
  final double previousMonthDues;
  final double lateFee;
  final double scholarshipDiscount;

  Fee({
    required this.amount,
    required this.status,
    required this.paidDate,
    required this.pendingDues,
    required this.paidAmount,
    required this.previousMonthDues,
    required this.lateFee,
    required this.scholarshipDiscount,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'status': status,
      'paidDate': paidDate,
      'pendingDues': pendingDues,
      'paidAmount': paidAmount,
      'previousMonthDues': previousMonthDues,
      'lateFee': lateFee,
      'scholarshipDiscount': scholarshipDiscount,
    };
  }

  factory Fee.fromMap(Map<String, dynamic> map) {
    return Fee(
      amount: map['amount'] ?? 0,
      status: map['status'] ?? '',
      paidDate: (map['paidDate'] as Timestamp).toDate(),
      pendingDues: map['pendingDues'] ?? 0,
      paidAmount: map['paidAmount'] ?? 0,
      previousMonthDues: map['previousMonthDues'] ?? 0,
      lateFee: map['lateFee'] ?? 0,
      scholarshipDiscount: map['scholarshipDiscount'] ?? 0,
    );
  }
}