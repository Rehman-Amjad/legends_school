import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../config/util/app_utils.dart';
import 'action_provider.dart';

class ResultProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> get genderList => ['Male', 'Female'];
  String? selectedGender = 'Male';

  // Controllers for input fields
  final studentNameController = TextEditingController();
  final studentSessionController = TextEditingController();
  final studentClassController = TextEditingController();
  final studentObtMarksController = TextEditingController();
  final studentTotalMarksController = TextEditingController();
  final studentRollNoController = TextEditingController();

  Stream<QuerySnapshot> resultsStream() {
    return _firestore.collection("resultsPortfolio").snapshots();
  }

  Future<void> saveResult() async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await _firestore.collection("resultsPortfolio").doc(id).set({
      "id": id,
      "name": studentNameController.text,
      "className": studentClassController.text,
      "session": studentSessionController.text,
      "obt": studentObtMarksController.text,
      "total": studentTotalMarksController.text,
      "gender": selectedGender?.toLowerCase(),
      "rollNo": studentRollNoController.text,
    });

    ActionProvider.stopLoading();
    AppUtils().showToast(text: "Result Uploaded");
  }

  Future<void> deleteResult(String id) async {
    await _firestore.collection("resultsPortfolio").doc(id).delete();
    AppUtils().showToast(text: "Result Delete Successfully");
  }

  void setSelectedGender(String? gender) {
    selectedGender = gender;
    notifyListeners();
  }
}
