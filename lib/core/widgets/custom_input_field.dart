import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final int maxLines;
  final bool readOnly;
  final GestureTapCallback? onTap;

  const CustomInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: const Color.fromARGB(255, 142, 142, 142)
        ),
        alignLabelWithHint: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: const Color.fromARGB(255, 142, 142, 142)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator, // Validación dinámica
    );
  }
}