import 'package:flutter/material.dart';

class CustomInputDecoration {
  CustomInputDecoration._();

  static InputDecorationTheme inputDecoration() {
    return InputDecorationTheme(
      border: const OutlineInputBorder(),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.deepOrange,
          width: 2.0,
        ),
      ),
      // Border when not focused
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        // Same corner radius for consistency
        borderSide: const BorderSide(
          color: Colors.grey, // Border color when not focused
          width: 2.0, // Border width when not focused
        ),
      ),
    );
  }
}