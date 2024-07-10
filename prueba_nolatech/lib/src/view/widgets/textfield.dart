import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomTextfield extends StatelessWidget {
  final String hint;
  final String label;
  final IconData icon;
  final TextEditingController controller;

  const CustomTextfield(
      {super.key,
      required this.hint,
      required this.label,
      required this.icon,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: secondaryColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: secondaryColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.only(left: 5, top: 12),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hint,
            labelText: label,
            prefixIcon: Icon(
              icon,
              color: secondaryColor,
            )),
      ),
    );
  }
}
