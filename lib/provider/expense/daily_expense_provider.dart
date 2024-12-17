import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/daily_expense_model.dart';
import '../../model/fee.dart';
import '../../model/fee/monthly_fee_status.dart';

class DailyExpenseProvider with ChangeNotifier {
  // Future<void> addExpense(String studentId, DailyExpense expense) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('students')
  //         .doc(studentId)
  //         .collection('dailyExpenses')
  //         .add(expense.toMap());
  //     notifyListeners();
  //   } catch (e) {
  //     log("Error adding expense: $e");
  //   }
  // }

  // Future<List<DailyExpense>> getExpenses(String studentId) async {
  //   try {
  //     final expenseSnapshot = await FirebaseFirestore.instance
  //         .collection('students')
  //         .doc(studentId)
  //         .collection('dailyExpenses')
  //         .get();
  //     return expenseSnapshot.docs
  //         .map((doc) => DailyExpense.fromMap(doc.data()))
  //         .toList();
  //   } catch (e) {
  //     log("Error fetching expenses: $e");
  //     return [];
  //   }
  // }

  // Future<void> updateFeeStatus(String studentId, Fee fee) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('students')
  //         .doc(studentId)
  //         .collection('fees')
  //         .doc(fee.monthYear)
  //         .set(fee.toMap());
  //     notifyListeners();
  //   } catch (e) {
  //     log("Error updating fee status: $e");
  //   }
  // }

  Future<List<StudentFeeModel>> getFeesForMonth(String studentId, String monthYear) async {
    try {
      final feeSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .doc(studentId)
          .collection('fees')
          .where('monthYear', isEqualTo: monthYear)
          .get();
      return feeSnapshot.docs
          .map((doc) => StudentFeeModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      log("Error fetching fees: $e");
      return [];
    }
  }

  // Future<MonthlyFeesStatus?> fetchMonthlyFeesStatus(String monthYear) async {
  //   try {
  //     final snapshot = await FirebaseFirestore.instance
  //         .collection('monthlyFeesStatus')
  //         .doc(monthYear)
  //         .get();
  //
  //     if (snapshot.exists) {
  //       return MonthlyFeesStatus.fromFirestore(snapshot.data()!, snapshot.id);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     log("Error fetching monthly fees status: $e");
  //     return null;
  //   }
  // }

  // Fetch fee status for a specific student in a given month
  // Future<StudentFeeStatus?> fetchStudentFeeStatus(
  //     String monthYear, String studentId) async {
  //   try {
  //     final snapshot = await FirebaseFirestore.instance
  //         .collection('monthlyFeesStatus')
  //         .doc(monthYear)
  //         .collection('students')
  //         .doc(studentId)
  //         .get();
  //
  //     if (snapshot.exists) {
  //       return StudentFeeStatus.fromMap(snapshot.data()!);
  //     } else {
  //       return null; // No fee status found for the student
  //     }
  //   } catch (e) {
  //     log("Error fetching student fee status: $e");
  //     return null;
  //   }
  // }

  // Add or update a student's fee status for a specific month
  // Future<void> updateStudentFeeStatus(
  //     String monthYear,
  //     String studentId,
  //     StudentFeeStatus studentFeeStatus,
  //     ) async {
  //   try {
  //     final studentRef = FirebaseFirestore.instance
  //         .collection('monthlyFeesStatus')
  //         .doc(monthYear)
  //         .collection('students')
  //         .doc(studentId);
  //
  //     await studentRef.set(studentFeeStatus.toMap(), SetOptions(merge: true));
  //
  //     // Update the total amounts in the parent document
  //     await _updateTotalFeeAmounts(monthYear);
  //
  //     notifyListeners();
  //   } catch (e) {
  //     log("Error updating student fee status: $e");
  //   }
  // }

  // Update totalAmount, totalPaid, and totalUnpaid in the monthlyFeesStatus
  Future<void> _updateTotalFeeAmounts(String monthYear) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('monthlyFeesStatus')
          .doc(monthYear)
          .collection('students')
          .get();

      double totalAmount = 0.0;
      double totalPaid = 0.0;
      double totalUnpaid = 0.0;

      for (var doc in snapshot.docs) {
        final studentFeeStatus = StudentFeeStatus.fromMap(doc.data());
        totalAmount += studentFeeStatus.amount;
        if (studentFeeStatus.status == "Paid") {
          totalPaid += studentFeeStatus.amount;
        } else {
          totalUnpaid += studentFeeStatus.amount;
        }
      }

      // Update the totals in the monthlyFeesStatus document
      await FirebaseFirestore.instance.collection('monthlyFeesStatus').doc(monthYear).update({
        'totalAmount': totalAmount,
        'totalPaid': totalPaid,
        'totalUnpaid': totalUnpaid,
      });
    } catch (e) {
      log("Error updating total fee amounts: $e");
    }
  }
}
