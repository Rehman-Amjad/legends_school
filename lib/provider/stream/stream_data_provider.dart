import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:legends_schools_admin/model/registration_form_model.dart';

import '../../config/keys/db_key.dart';
import '../../model/teacher_model.dart';

class StreamDataProvider extends ChangeNotifier{

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<RegistrationFormModel>> getAdmissions({int? limit}) {
    Query query = firestore.collection(DbKey.admissions);
    if (limit != null) {
      query = query.limit(limit);
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

}