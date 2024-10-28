import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:intl/intl.dart';

class PickerProvider with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  String _dobDate = 'Select Date';
  DateTime get selectedDate => _selectedDate;
  String get dobDate => _dobDate;
  void selectDate(DateTime date) {
    _selectedDate = date;
    _dobDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    notifyListeners();
  }


  // Image Picker & Upload
  Uint8List? _pickedImage;
  bool _isUploading = false;

  Uint8List? get pickedImage => _pickedImage;
  bool get isUploading => _isUploading;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> pickImage() async {
    FilePickerResult? pickImage =
    await FilePicker.platform.pickFiles(type: FileType.image);
    if (pickImage == null) {
      // Show an alert using a different mechanism as Get is not used here.
      print('Please select an image');
    } else {
      _pickedImage = pickImage.files.first.bytes;
      notifyListeners();
    }
  }

  Future<void> uploadData({
    required String? studentName,
    required String studentDOB,
    required String? registrationNumber,
  }) async {
    if (_pickedImage == null) return;

    _isUploading = true;
    notifyListeners();

    try {
      final String imageUrl = await firebaseStorageImage(image: _pickedImage!);
      var id = _firestore.collection('admissions').doc().id.toString();
      await _firestore.collection('admissions').doc(id).set({
        'studentImage': imageUrl,
        // Add other data fields here
      });
      // Show a success alert
      print('Image uploaded');
    } catch (e) {
      // Handle errors
      print(e.toString());
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }

  Future<String> firebaseStorageImage({required Uint8List image}) async {
    final Reference reference =
    _storage.ref('/StudentAdmissionFormImage/${DateTime.now().toString()}');
    final UploadTask uploadTask = reference.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }


  void clear(){
    _selectedDate = DateTime.now();
    _dobDate = 'Select Date';
    _pickedImage = null;
    _isUploading = false;
    notifyListeners();
  }

}