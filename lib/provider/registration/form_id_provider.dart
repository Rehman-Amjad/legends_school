import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../constant.dart';

class FormIdProvider extends ChangeNotifier{

  int? _formID = 0;

  int? get formID => _formID;

  Future<void> fetchCountValue() async {
    try {
      final value = await firestore.collection("studentFormNo").doc("counter").get();
      if (value.exists) {
        log("Exits");
        _formID = 1 + int.parse(value.get("count").toString());
      } else {
        log("NOt");
        _formID = 0;
      }
      notifyListeners();
    } catch (e) {
      log("Error fetching form value: $e");
    }
    notifyListeners();
  }

  Future<void> updateCountValue({required formID}) async {
    try {
      await firestore
          .collection("studentFormNo")
          .doc("counter")
          .update({"count": formID.toString()});
      notifyListeners();
    } catch (e) {
      log("Error fetching count value: $e");
    }
    notifyListeners();
  }


}