import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> deleteExpense(String studentId, String date, double expenseAmount) async {
    final feesDocRef = _firestore
        .collection('students')
        .doc(studentId)
        .collection('fees')
        .doc(date);

    try {
      await _firestore.runTransaction((transaction) async {
        // Fetch the document snapshot
        DocumentSnapshot feesSnapshot = await transaction.get(feesDocRef);

        if (feesSnapshot.exists) {

          double currentDailyExpense =
              (feesSnapshot.data() as Map<String, dynamic>)['dailyExpense'] ?? 0.0;

          double updatedDailyExpense = currentDailyExpense - expenseAmount;

          if (updatedDailyExpense < 0) updatedDailyExpense = 0;

          if (updatedDailyExpense == 0) {
            transaction.update(feesDocRef, {
              'dailyExpense': updatedDailyExpense,
            });
          } else {
            transaction.update(feesDocRef, {
              'dailyExpense': updatedDailyExpense,
            });
            log("Fees document updated with new dailyExpense: $updatedDailyExpense");
          }
        } else {
          throw Exception("Fees document does not exist. Cannot delete the expense.");
        }
      });
    } catch (e) {
      log("Error while deleting expense: $e");
      rethrow;
    }
  }
}
