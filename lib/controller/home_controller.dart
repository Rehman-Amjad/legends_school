import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import '../utils/web_utils.dart';

class HomeController extends GetxController {
  Uint8List? pickedImage;
  String name = '';
  var loading = false.obs;

  getUserName(String userName) {
    name = userName;
    update();
  }

  pickImageMethod() async {
    FilePickerResult? pickImage =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (pickImage == null) {
      return WebUtils().errorToast("Please select a image");
    } else {
      pickedImage = pickImage.files.first.bytes!;
      update();
    }
    update();
  }

  loader() async {
    loading.value = true;
    await Future.delayed(const Duration(seconds: 5));
    loading.value = false;
  }
}
