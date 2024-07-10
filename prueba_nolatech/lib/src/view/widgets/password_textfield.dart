import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomPasswordTextfield extends StatelessWidget {
  final String hint;
  final String label;

  final TextEditingController controller;
  final bool obsText;
  final Function()? onPressed;
  const CustomPasswordTextfield(
      {super.key,
      required this.hint,
      required this.label,
      required this.controller,
      required this.obsText,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child: TextFormField(
          obscureText: obsText,
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: secondaryColor)),
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
            prefixIcon: const Icon(
              Icons.lock_outline_rounded,
              color: secondaryColor,
            ),
            suffixIcon: IconButton(
                icon: obsText
                    ? const Icon(
                        Icons.visibility_off_outlined,
                        color: secondaryColor,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                        color: secondaryColor,
                      ),
                onPressed: onPressed),
          ),
        ));
  }
}
