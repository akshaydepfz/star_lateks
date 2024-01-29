import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.maxlLines = 1,
    this.keyboardType = TextInputType.text,
  });

  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxlLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxlLines,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}
