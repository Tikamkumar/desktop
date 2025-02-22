import 'package:flutter/material.dart';

class CustomSnackBar {
  final BuildContext context;

  CustomSnackBar(this.context);

  showSuccessMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg, style: TextStyle(color: Color(0xFF8E1616), fontSize: 16, fontWeight: FontWeight.bold),), backgroundColor: const Color(0xFFEEEEEE)));
  }

  showErrorMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg, style: TextStyle(color: Color(0xFF118B50), fontSize: 16, fontWeight: FontWeight.bold),), backgroundColor: const Color(0xFFFDF7F4)));
  }

  showWarningMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue[100],
        content: Text(msg, style: TextStyle(color: Colors.blue[900]),),));
  }
}