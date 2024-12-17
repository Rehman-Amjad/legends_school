import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:legends_schools_admin/model/daily_expense_model.dart';
import 'package:legends_schools_admin/model/fee/fee_status_model.dart';
import 'package:legends_schools_admin/model/fee/student_fee_model.dart';
import 'package:legends_schools_admin/model/registration_form_model.dart';

import '../../config/keys/db_key.dart';
import '../../model/fee.dart';
import '../../model/teacher_model.dart';

class StreamDataProvider extends ChangeNotifier{

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<RegistrationFormModel>> getAdmissions({int? limit,String? status}) {
    Query query = firestore.collection(DbKey.admissions);
    if (limit != null) {
      query = query.limit(limit);
    }

    if(status != null){
      query = query.where("status", isEqualTo: status);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return RegistrationFormModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<TeacherModel>> getTeachers({int? limit}) {
    Query query = firestore.collection(DbKey.teachers);
    if (limit != null) {
      query = query.limit(limit);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TeacherModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<FeeStatusModel>> getMonthlyStudentFeeStatus({int? limit,required String monthYear}) {
    Query feeStatusQuery = firestore
        .collection(DbKey.monthlyFeeStatus)
        .doc(monthYear)
        .collection(DbKey.admissions);

    if (limit != null) {
      feeStatusQuery = feeStatusQuery.limit(limit);
    }

    return feeStatusQuery.snapshots().asyncMap((snapshot) async {

      final feeStatusWithStudents = await Future.wait(snapshot.docs.map((doc) async {
        final feeStatusData = doc.data() as Map<String, dynamic>;
        final feeStatus = FeeStatusModel.fromMap(feeStatusData);

        // Initialize the students list if not already done
        // Fetch the student data based on the feeStatus ID
        final studentDoc = await firestore
            .collection(DbKey.admissions)
            .doc(feeStatus.id) // Ensure this is correct; it should be fetching based on student IDs
            .get();

        if (studentDoc.exists) {
          final student = RegistrationFormModel.fromFirestore(studentDoc.data() as Map<String, dynamic>);
          feeStatus.students = student;
        }

        return feeStatus;
      }).toList());



      log("Total Fee Statuses with Students: ${feeStatusWithStudents.length}");

      return feeStatusWithStudents;
    });
  }

  Stream<Map<String, dynamic>> getStudentExpense({
    int? limit,
    String? monthYear, // Expected in "YYYY-MM" format
    String? category, // Specific category filter
    required String formId,
  }) {
    DateTime now = DateTime.now();

    // Extract year and month from the `monthYear` parameter
    String defaultMonthYear = monthYear ?? "${now.year}-${now.month.toString().padLeft(2, '0')}";

    // Split the "YYYY-MM" format into year and month components
    List<String> parts = defaultMonthYear.split("-");
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);

    // Build the query dynamically
    Query query = firestore
        .collection('students')
        .doc(formId)
        .collection('dailyExpenses');

    // Add filters for month and year based on the timestamp
    query = query.where(
      "timeStamp",
      isGreaterThanOrEqualTo: DateTime(
        year,
        month,
        1,
      ).millisecondsSinceEpoch.toString(), // Convert milliseconds to string
    );

    query = query.where(
      "timeStamp",
      isLessThan: DateTime(
        year,
        month + 1,
        1,
      ).millisecondsSinceEpoch.toString(), // Convert milliseconds to string
    );

    // Add a filter for category if provided
    if (category != null) {
      query = query.where("category", isEqualTo: category);
    }

    // Add a limit if provided
    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      double totalAmount = 0.0;

      final expenses = snapshot.docs.map((doc) {
        final expense = DailyExpenseModel.fromMap(doc.data() as Map<String, dynamic>);
        totalAmount += expense.amount; // Accumulate the amount
        return expense;
      }).toList();

      return {
        'expenses': expenses,
        'totalAmount': totalAmount,
      };
    });
  }


  Stream<List<StudentFeeModel>> getSingleStudentFee({int? limit,String? monthYear, required String formID}) {
    Query query = firestore
        .collection(DbKey.admissions)
        .doc(formID)
        .collection('fees');
    if (limit != null) {
      query = query.limit(limit);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return StudentFeeModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }



}