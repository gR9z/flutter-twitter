import 'package:flutter/material.dart';

class AppTheme {
  static InputDecoration formDecoration(String hintText) {
    return InputDecoration(
        contentPadding: EdgeInsets.all(20),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        filled: true,
        fillColor: Color(0x77FFFFFF),
        hintText: hintText);
  }
}
