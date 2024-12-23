import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/enum/toast_type.dart';
import 'package:legends_schools_admin/config/keys/db_key.dart';
import 'package:legends_schools_admin/config/util/app_utils.dart';
import 'package:legends_schools_admin/model/daily_expense_model.dart';
import 'package:legends_schools_admin/model/fee/fee_status_model.dart';
import 'package:legends_schools_admin/model/registration_form_model.dart';
import 'package:legends_schools_admin/config/util/time_utils.dart';

import '../config/enum/fee_type.dart';
import '../model/fee.dart';
import '../model/fee/monthly_fee_status.dart';

class FeeManagementProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  final amountController = TextEditingController();
  final noteController = TextEditingController();


  FeeStatusModel? _feeStatusModel;


  FeeStatusModel? get feeStatusModel => _feeStatusModel;


  void updateFeeStatusModel(FeeStatusModel model){
    _feeStatusModel = model;
    notifyListeners();
  }


  // Fetch a student by studentId
  Future<RegistrationFormModel> fetchStudent(String studentId) async {
    DocumentSnapshot studentDoc =
    await _firestore.collection('students').doc(studentId).get();
    return RegistrationFormModel.fromFirestore(studentDoc.data() as Map<String, dynamic>);
  }


  String _totalAmount = "0";
  String _totalAmountPaid = "0";
  String _totalAmountRemaining = "0";

  String get totalAmountPaid => _totalAmountPaid;
  String get totalAmountRemaining => _totalAmountRemaining;
  String get totalAmount => _totalAmount;

  Future<void> fetchTotalFees() async {
    String date = TimeUtils().getMonthYearFromTimestamp(
        timestamp: DateTime.now().millisecondsSinceEpoch);
    try {
      final snapshot =
      await _firestore.collection(DbKey.monthlyFeeStatus).doc(date).get();
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null) {
          _totalAmount = data['totalAmount']?.toString() ?? "0";
          _totalAmountPaid = data['totalPaid']?.toString() ?? "0";
          _totalAmountRemaining = data['totalUnpaid']?.toString() ?? "0";
        }
      } else {
        _totalAmount = "0";
        _totalAmountPaid = "0";
        _totalAmountRemaining = "0";
      }
      notifyListeners();
    } catch (e) {
      log("Error fetching total fees: $e");
      _totalAmount = "0";
      _totalAmountPaid = "0";
      _totalAmountRemaining = "0";
    }
  }


  // // Fetch daily expenses for a student
  // Future<List<DailyExpenseModel>> fetchExpenses(String studentId) async {
  //   QuerySnapshot expenseSnapshot = await _firestore
  //       .collection('students')
  //       .doc(studentId)
  //       .collection('dailyExpenses')
  //       .get();
  //
  //   return expenseSnapshot.docs
  //       .map((doc) => DailyExpenseModel.fromMap(doc.data() as Map<String, dynamic>))
  //       .toList();
  // }

  // // Fetch monthly fee status for a specific month
  // Future<Map<String, dynamic>> fetchMonthlyFeeStatus(String monthYear) async {
  //   DocumentSnapshot statusDoc =
  //   await _firestore.collection('monthlyFeesStatus').doc(monthYear).get();
  //   return statusDoc.data() as Map<String, dynamic>;
  // }

  // // Add a fee to a student's fees collection
  // Future<void> addFee(String studentId, Fee fee) async {
  //   await _firestore
  //       .collection('students')
  //       .doc(studentId)
  //       .collection('fees')
  //       .add(fee.toMap());
  //   notifyListeners();
  // }

  // Add an expense to a student's dailyExpenses collection
  Future<void> addExpense(String studentId, DailyExpenseModel expense) async {
    await _firestore
        .collection('students')
        .doc(studentId)
        .collection('dailyExpenses')
        .doc(expense.timeStamp)
        .set(expense.toMap());

    log("Month: ${expense.monthYear}");
    await updateFeesWithTransaction(studentId,expense.monthYear,expense.amount);
  }

  Future<void> updateFeesWithTransaction(String studentId, String date, double newAmount) async {
    final feesDocRef = _firestore
        .collection('students')
        .doc(studentId)
        .collection('fees')
        .doc(date);

    try {
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot feesSnapshot = await transaction.get(feesDocRef);

        if (!feesSnapshot.exists) {
          transaction.set(feesDocRef, {
            'dailyExpense': newAmount,
          });
        } else {
          // If the document exists, update the dailyExpense by adding the newAmount
          double currentDailyExpense = feesSnapshot.get('dailyExpense') ?? 0.0;
          double updatedDailyExpense = currentDailyExpense + newAmount;
          transaction.update(feesDocRef, {
            'dailyExpense': updatedDailyExpense,
          });
        }
      });
      log('Fees updated successfully');
    } catch (e) {
      // Catch any errors during the transaction and log the error
      log('Error updating fees: $e');
      // You can also show a custom error message to the user here
    }
  }






  // Update the monthly fee status for all students
  Future<void> updateMonthlyFeeStatus(String monthYear, double totalAmount,
      double totalPaid, double totalUnpaid) async {
    await _firestore.collection('monthlyFeesStatus').doc(monthYear).set({
      'totalAmount': totalAmount,
      'totalPaid': totalPaid,
      'totalUnpaid': totalUnpaid,
    });
    notifyListeners();
  }


  Future<void> addFeeAndUpdateMonthlyStatus(
      {required String studentId, required StudentFeeModel feeModel,required String monthYear}) async {
    final studentRef = FirebaseFirestore.instance.collection('students').doc(studentId);
    final feeRef = studentRef.collection('fees').doc(monthYear);
    final monthlyFeeRef = FirebaseFirestore.instance.collection('monthlyFeesStatus').doc(monthYear).collection('students').doc(studentId);

    try {
      // Upload Fee Information to the student's document
      await feeRef.set(feeModel.toMap()); // Store fee for the given month

      // Update Monthly Fee Status
      final monthlyStatusDoc = await FirebaseFirestore.instance.collection('monthlyFeesStatus').doc(monthYear).get();
      if (monthlyStatusDoc.exists) {
        // Fetch existing total amounts and update
        final currentTotalPaid = monthlyStatusDoc['totalPaid'];
        final currentTotalUnpaid = monthlyStatusDoc['totalUnpaid'];
        final currentTotalAmount = monthlyStatusDoc['totalAmount']; // Get existing totalAmount

        // Update totals based on fee status
        final updatedTotalPaid = feeModel.status == 'Paid' ? currentTotalPaid + feeModel.amount : currentTotalPaid;
        final updatedTotalUnpaid = feeModel.status == 'Unpaid' ? currentTotalUnpaid + feeModel.amount : currentTotalUnpaid;
        final updatedTotalAmount = currentTotalAmount + feeModel.amount; // Accumulate total amount

        await FirebaseFirestore.instance.collection('monthlyFeesStatus').doc(monthYear).update({
          'totalPaid': updatedTotalPaid,
          'totalUnpaid': updatedTotalUnpaid,
          'totalAmount': updatedTotalAmount, // Update total amount
        });
      } else {
        // Initialize the document if it does not exist
        await FirebaseFirestore.instance.collection('monthlyFeesStatus').doc(monthYear).set({
          'totalAmount': feeModel.amount,
          'totalPaid': feeModel.status == 'Paid' ? feeModel.amount : 0.0,
          'totalUnpaid': feeModel.status == 'Unpaid' ? feeModel.amount : 0.0,
        });
      }

      // Store the fee status in the monthly fee status collection for the student
      await monthlyFeeRef.set({
        'id': studentId,
        'status': feeModel.status,
        'amount': feeModel.amount,
        'paidDate': feeModel.status == 'Paid' ? feeModel.paidDate : "",
        'previousMonthDues': feeModel.previousMonthDues,
      });

      log('Fee and monthly status updated successfully!');
    } catch (e) {
      log('Error updating fee and monthly status: $e');
    }
  }


  Future<void> markStudentAsPaid(String studentId, String monthYear) async {
    final studentRef = FirebaseFirestore.instance.collection('students').doc(studentId);
    final feeRef = studentRef.collection('fees').doc(monthYear);
    final monthlyFeeRef = FirebaseFirestore.instance.collection('monthlyFeesStatus').doc(monthYear).collection('students').doc(studentId);

    try {
      final feeDoc = await feeRef.get();
      if (!feeDoc.exists) {
        log('No fee record found for the student in the specified month.');
        return;
      }

      final feeData = feeDoc.data();
      final feeAmount = feeData?['amount'] ?? 0.0;
      final currentStatus = feeData?['status'] ?? 'Unpaid';

      if (currentStatus == 'Paid') {
        log('The fee is already marked as paid.');
        return;
      }

      // Update the student's fee document to mark it as "Paid"
      await feeRef.update({
        'status': 'Paid',
        'paidDate': DateTime.now().toIso8601String(),
      });

      // Update the monthly fee status
      final monthlyStatusDoc = await FirebaseFirestore.instance.collection('monthlyFeesStatus').doc(monthYear).get();
      if (monthlyStatusDoc.exists) {
        // Fetch current totalPaid and totalUnpaid amounts
        final currentTotalPaid = monthlyStatusDoc['totalPaid'];
        final currentTotalUnpaid = monthlyStatusDoc['totalUnpaid'];

        // Update totals
        final updatedTotalPaid = currentTotalPaid + feeAmount;
        final updatedTotalUnpaid = currentTotalUnpaid - feeAmount;

        await FirebaseFirestore.instance.collection('monthlyFeesStatus').doc(monthYear).update({
          'totalPaid': updatedTotalPaid,
          'totalUnpaid': updatedTotalUnpaid,
        });
      } else {
        // If monthly status document does not exist, initialize it
        await FirebaseFirestore.instance.collection('monthlyFeesStatus').doc(monthYear).set({
          'totalAmount': feeAmount,
          'totalPaid': feeAmount,
          'totalUnpaid': 0.0,
        });
      }

      // Update the student's status in the monthly fee status collection
      await monthlyFeeRef.update({
        'status': 'Paid',
        'paidDate': DateTime.now().toIso8601String(),
      });

      log('Student marked as paid and monthly status updated successfully!');
    } catch (e) {
      log('Error marking student as paid: $e');
    }
  }


  Future<void> updateFeePaymentStatus(String studentId, double paidAmount, String monthYear, DateTime paidDate) async {
    final feeRef = FirebaseFirestore.instance.collection('students').doc(studentId).collection('fees').doc(monthYear);
    final monthlyFeeRef = FirebaseFirestore.instance.collection('monthlyFeesStatus').doc(monthYear).collection('students').doc(studentId);

    // Fetch current fee status for the student
    final feeDoc = await feeRef.get();
    if (feeDoc.exists) {
      final currentFee = StudentFeeModel.fromMap(feeDoc.data()!);  // assuming Fee.fromMap() method is implemented

      if (currentFee.status == 'Unpaid') {
        // Update fee document to "Paid"
        await feeRef.update({
          'status': 'Paid',
          'paidDate': paidDate,
          'pendingDues': 0.0,
        });

        // Update the total amounts in monthly fee status
        final monthlyStatusDoc = await FirebaseFirestore.instance.collection('monthlyFeesStatus').doc(monthYear).get();
        if (monthlyStatusDoc.exists) {
          final totalPaid = monthlyStatusDoc['totalPaid'] + paidAmount;
          final totalUnpaid = monthlyStatusDoc['totalUnpaid'] - paidAmount;

          await FirebaseFirestore.instance.collection('monthlyFeesStatus').doc(monthYear).update({
            'totalPaid': totalPaid,
            'totalUnpaid': totalUnpaid,
          });
        }

        // Update the monthly fee status for the student
        await monthlyFeeRef.update({
          'status': 'Paid',
          'paidDate': paidDate,
        });

        log('Fee updated to paid and monthly status updated!');
      }
    }
  }


  Future<void> updatePartialPayment(
      String monthYear,
      String studentId,
      double paymentAmount,
      ) async {
    try {
      // Fetch current student fee status
      final studentRef = FirebaseFirestore.instance
          .collection('monthlyFeesStatus')
          .doc(monthYear)
          .collection('students')
          .doc(studentId);

      final snapshot = await studentRef.get();
      if (snapshot.exists) {
        final studentFeeStatus = StudentFeeStatus.fromMap(snapshot.data()!);

        // Update paidAmount and pendingAmount
        double newPaidAmount = studentFeeStatus.paidAmount + paymentAmount;
        double newPendingAmount = studentFeeStatus.amount - newPaidAmount;

        // Determine the status
        String newStatus = newPendingAmount > 0 ? "Partially Paid" : "Paid";

        // Update Firestore document with new values
        await studentRef.update({
          'paidAmount': newPaidAmount,
          'pendingAmount': newPendingAmount,
          'status': newStatus,
        });

        // Update total amounts for the month
        await _updateTotalFeeAmounts(monthYear);

        notifyListeners();
      }
    } catch (e) {
      log("Error updating partial payment: $e");
    }
  }

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

      snapshot.docs.forEach((doc) {
        final studentFeeStatus = StudentFeeStatus.fromMap(doc.data());
        totalAmount += studentFeeStatus.amount;
        totalPaid += studentFeeStatus.paidAmount;
        totalUnpaid += studentFeeStatus.pendingAmount;
      });

      // Update the totals in the monthlyFeesStatus document
      await FirebaseFirestore.instance.collection('monthlyFeesStatus').doc(monthYear).update({
        'totalAmount': totalAmount,
        'totalPaid': totalPaid,
        'totalUnpaid': totalUnpaid,
      });
    } catch (e) {
      print("Error updating total fee amounts: $e");
    }
  }


  bool _isLoading  = false;
  bool get isLoading => _isLoading;

  Future<void> saveUnpaidFeesForActiveStudents() async {
    try {
      _isLoading = true;
      notifyListeners();

      DateTime now = DateTime.now();
      String currentMonthYear = "${now.year}-${now.month.toString().padLeft(2, '0')}";

      QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
          .collection(DbKey.admissions)
          .where('status', isEqualTo: "ACTIVE") // Filter active students
          .get();

      if (studentSnapshot.docs.isEmpty) {
        log("No active students found.");
        return;
      }

      for (QueryDocumentSnapshot doc in studentSnapshot.docs) {
        Map<String, dynamic> studentData = doc.data() as Map<String, dynamic>;

        String formId = studentData['formID'];
        String totalDues = studentData['totalDues'] ?? 0.0;

        final fee = StudentFeeModel(
          amount: double.parse(totalDues),
          status: FeeType.Unpaid.name,
          paidAmount: 0,
          paidDate: DateTime.now(),
          pendingDues: 0.0,
          previousMonthDues: 0.0,
          lateFee: 0.0,
          dailyExpense: 0.0,
          timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
          monthYear: TimeUtils().getMonthYearFromTimestamp(),
          scholarshipDiscount: 0.0,
        );

        await addFeeAndUpdateMonthlyStatus(
            studentId: formId,
            feeModel: fee,
            monthYear: currentMonthYear
        );
        log("Unpaid fee data saved for FormID: $formId");
      }
    } catch (e) {
      log("Error saving unpaid fees: $e");
    }finally {
      AppUtils().showWebToast(text: "Student Fee Updated",toastType: ToastType.success);
      _isLoading = false;
      notifyListeners();
    }
  }

}
