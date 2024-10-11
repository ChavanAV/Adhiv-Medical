import 'package:flutter/material.dart';

import 'decoration.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool isPasswordField;

  CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.isPasswordField = false,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPasswordField, // Hide text if it's a password field
      decoration: InputDecoration(
        labelText: labelText, // Floating label text
        hintText: hintText, // Placeholder text
        filled: true, // Background filled with color
        fillColor: Colors.grey[200], // Set the fill color of the TextField
        enabledBorder: OutlineInputBorder(
          // Border when TextField is not focused
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          // Border when TextField is focused
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: primaryColor,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0, horizontal: 20.0), // Padding inside the TextField
      ),
    );
  }
}
