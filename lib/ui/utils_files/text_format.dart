import 'dart:ui';

import 'package:flutter/material.dart';

class TextFile {
  static TextStyle bodyTextStyle() {
    return const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle headerTextStyle() {
    return const TextStyle(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle header1LightText() {
    return TextStyle(
        fontSize: 17,
        color: Colors.black26,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle header1TextStyle() {
    return TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle header2LightText() {
    return TextStyle(
        fontSize: 15,
        color: Colors.black38,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle header2Text() {
    return TextStyle(
        fontSize: 17,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle header3Text() {
    return TextStyle(
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle header3LightText() {
    return TextStyle(
        fontSize: 15,
        color: Colors.black45,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }
}