import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:legends_schools_admin/model/student_model.dart';

import '../../config/keys/db_key.dart';

class StreamDataProvider extends ChangeNotifier{

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<StudentModel>> getAdmissions({int? limit}) {
    Query query = firestore.collection(DbKey.admissions);
    if (limit != null) {
      query = query.limit(limit);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return StudentModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

}