import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:legends_schools_admin/config/keys/db_key.dart';
import 'package:legends_schools_admin/config/services/firestore_services.dart';
import 'package:legends_schools_admin/model/registration_form_model.dart';

class StudentPromotionProvider extends ChangeNotifier{


 final FirestoreServices _services =  FirestoreServices();

  List<RegistrationFormModel> _students = [];


  Future<void> fetchStudent({required String clasName}) async{
    _students = await _services.fetchStudents(clasName);
    notifyListeners();
  }

  Future<void> promoteStudents(String newClass) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (var student in _students) {
      DocumentReference studentRef = FirebaseFirestore.instance.collection(DbKey.admissions).doc(student.formId);
      batch.update(studentRef, {'className': newClass});
    }
    await batch.commit();
  }



}