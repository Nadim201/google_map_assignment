import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
 static void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static const TextStyle headline = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyText =
  TextStyle(fontSize: 22.0, color: Colors.red);
  static TextStyle subBodyText =
  const TextStyle(fontSize: 18.0, color: Colors.deepPurple);
  static const TextStyle smallText = TextStyle(
    fontSize: 12.0,
  );
}