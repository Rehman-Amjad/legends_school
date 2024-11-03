import 'package:flutter/cupertino.dart';
import 'package:legends_schools_admin/model/teacher_model.dart';
import 'package:legends_schools_admin/provider/constant/action_provider.dart';

import '../../config/util/app_utils.dart';
import '../../constant.dart';

class TeacherRegistrationProvider extends ChangeNotifier{


  var nameController = TextEditingController();
  var fatherNameController = TextEditingController();
  var cNICController = TextEditingController();
  var registrationNumberController = TextEditingController();
  var addressController = TextEditingController();
  var contactController = TextEditingController();
  var domicileController = TextEditingController();
  var pdfImageUrlController = TextEditingController();
  var jobTitleController = TextEditingController();
  var qualificationController = TextEditingController();


  Future<void> uploadStudentData(TeacherModel model) async {

    await firestore.collection('teachers').doc(model.registrationID).set(model.toMap()).whenComplete((){
      AppUtils().showToast(text: "Teacher Registered Successfully");
      ActionProvider.stopLoading();
    });

  }

  // reset all controller
  void resetControllers(){
    nameController.text = '';
    fatherNameController.text = '';
    cNICController.text = '';
    registrationNumberController.text = '';
    addressController.text = '';
    contactController.text = '';
    domicileController.text = '';
    pdfImageUrlController.text = '';
    jobTitleController.text = '';
    qualificationController.text = '';
  }

  String _searchTerm = "";

  void updateSearchTerm(String term) {
    _searchTerm = term;
    notifyListeners();
  }

  bool filterTeachers(TeacherModel student) {
    return student.teacherCNIC.contains(_searchTerm) ||
        student.teacherClass.contains(_searchTerm) ||
        student.teacherName.contains(_searchTerm);
  }

}