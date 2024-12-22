import 'package:flutter/material.dart';

import 'decoration.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  final bool isPasswordField;
  final double? height;
  final double? width;
  final void Function()? onTap;
  final IconButton? suffixIcon;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.isPasswordField = false,
    required this.controller,
    this.onTap,
    this.height,
    this.width,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        controller: controller,
        obscureText: isPasswordField,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          filled: true,
          suffixIcon: suffixIcon,
          fillColor: Colors.grey[200],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: primaryColor,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
        ),
        onTap: () => onTap!(),
      ),
    );
  }
}
