import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:legends_schools_admin/config/keys/db_key.dart';

import '../../model/registration_form_model.dart';

class StudentCardProvider with ChangeNotifier {
  final collectRef = FirebaseFirestore.instance.collection(DbKey.admissions);

  List<RegistrationFormModel> students = [];
  String taskText = "Search Students and Generate Cards";

  Future<void> fetchStudentDetails(List<String> studentIDs) async {
    try {
      students.clear();
      for (var i = 0; i < studentIDs.length; i++) {
        taskText = "Fetching Student ${i + 1} records please wait a moment";
        notifyListeners();
        log(taskText); // Log task status
        var documentSnapshot = await collectRef.doc(studentIDs[i]).get();
        if (documentSnapshot.exists) {
          Map<String, dynamic>? data = documentSnapshot.data();
          students.add(RegistrationFormModel.fromFirestore(data!));
          log('Fetched data for student ${studentIDs[i]}: $data');
          notifyListeners();
        } else {
          log('No data found for student ${studentIDs[i]}');
        }
      }
      taskText = "All student data found. Now generating PDF file, please wait.";
      notifyListeners();
      log(taskText); // Log task status
    } catch (e) {
      taskText = "Error occurred while fetching data: $e";
      notifyListeners();
      log(taskText); // Log error
    }
  }


  void generatePDF(BuildContext context) {
    // Implement your PDF generation logic here
  }
}
