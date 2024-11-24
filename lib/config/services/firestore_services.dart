import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:legends_schools_admin/config/keys/db_key.dart';

import '../../model/registration_form_model.dart';

class FirestoreServices{

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<List<RegistrationFormModel>> fetchStudents(String className) async {
    QuerySnapshot snapshot = await _fireStore
        .collection(DbKey.admissions)
        .where('className', isEqualTo: className)
        .get();
    return snapshot.docs.map((doc) => RegistrationFormModel.fromFirestore(doc as Map<String, dynamic>)).toList();
  }

}