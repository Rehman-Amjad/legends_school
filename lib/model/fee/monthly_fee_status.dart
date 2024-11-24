import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyFeesStatus {
  String monthYear;
  double totalAmount;
  double totalPaid;
  double totalUnpaid;
  List<StudentFeeStatus> studentStatuses;

  MonthlyFeesStatus({
    required this.monthYear,
    required this.totalAmount,
    required this.totalPaid,
    required this.totalUnpaid,
    required this.studentStatuses,
  });

  factory MonthlyFeesStatus.fromFirestore(Map<String, dynamic> data, String monthYear) {
    return MonthlyFeesStatus(
      monthYear: monthYear,
      totalAmount: data['totalAmount'] ?? 0.0,
      totalPaid: data['totalPaid'] ?? 0.0,
      totalUnpaid: data['totalUnpaid'] ?? 0.0,
      studentStatuses: List<StudentFeeStatus>.from(
        data['students']?.map((x) => StudentFeeStatus.fromMap(x)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalAmount': totalAmount,
      'totalPaid': totalPaid,
      'totalUnpaid': totalUnpaid,
      'students': studentStatuses.map((x) => x.toMap()).toList(),
    };
  }
}


class StudentFeeStatus {
  String studentId;
  String status; // "Paid", "Unpaid", "Partially Paid"
  double amount;
  double paidAmount;
  double pendingAmount;
  Timestamp? paidDate;
  double previousMonthDues;

  StudentFeeStatus({
    required this.studentId,
    required this.status,
    required this.amount,
    required this.paidAmount,
    required this.pendingAmount,
    this.paidDate,
    required this.previousMonthDues,
  });

  factory StudentFeeStatus.fromMap(Map<String, dynamic> map) {
    return StudentFeeStatus(
      studentId: map['studentId'],
      status: map['status'],
      amount: map['amount'],
      paidAmount: map['paidAmount'] ?? 0.0,
      pendingAmount: map['pendingAmount'] ?? map['amount'],
      paidDate: map['paidDate'],
      previousMonthDues: map['previousMonthDues'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'status': status,
      'amount': amount,
      'paidAmount': paidAmount,
      'pendingAmount': pendingAmount,
      'paidDate': paidDate,
      'previousMonthDues': previousMonthDues,
    };
  }
}
