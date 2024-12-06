import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'color.dart';

class SnackBarFile {
  static showSnackBar(String title, String message) {
    Get.snackbar(
      backgroundColor: ColorFile.primaryColor,
      colorText: ColorFile.whiteColor,
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
    );
  }

  static showErrorSnackBar(String title, String message) {
    Get.snackbar(
      backgroundColor: ColorFile.redColor,
      colorText: ColorFile.whiteColor,
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
    );
  }
}
