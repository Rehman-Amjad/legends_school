import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/firebase.dart';

class ImageController extends GetxController{


  Uint8List? pickedImage;


  pickImageMethod() async {
    FilePickerResult? pickImage =
    await FilePicker.platform.pickFiles(type: FileType.image);
    if (pickImage == null) {
      Get.snackbar("Alert!!!", 'Please select student image',backgroundColor: Colors.red,snackPosition: SnackPosition.BOTTOM);
    } else {
      pickedImage = pickImage.files.first.bytes!;
      update();
    }
    update();
  }

  uploadBannerImage() async {
    try {
      final String imageUrl = await firebaseStorageImage(image: pickedImage!);
      var id = firestore.collection('MainBanner').doc().id.toString();
      await firestore.collection('MainBanner').doc(id).set({
        'image': imageUrl,
        'bannerID': id
      });
      Get.snackbar("Alert!!!", 'Image uploaded...',backgroundColor: Colors.green,snackPosition: SnackPosition.BOTTOM);

    } catch (e) {
      debugPrint(e.toString());
    }
  }

  uploadData({
    required String? studentName,
    required String studentDOB,
    required String? registrationNumber
  }) async{
    try {
      final String imageUrl = await firebaseStorageImage(image: pickedImage!);
      var id = firestore.collection('admissions').doc().id.toString();
      await firestore.collection('admissions').doc(id).set({
        'studentImage': imageUrl,
      });
      Get.snackbar("Alert!!!", 'Image uploaded...',backgroundColor: Colors.green,snackPosition: SnackPosition.BOTTOM);

    } catch (e) {
      debugPrint(e.toString());
    }
  }

  firebaseStorageImage({required Uint8List image}) async {
    final Reference reference =
    storage.ref('/StudentAdmissionFormImage/${DateTime.now().toString()}');
    final UploadTask uploadTask = reference.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

}