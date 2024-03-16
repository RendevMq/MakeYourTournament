import 'package:flutter/material.dart';

class TextFieldNormalWidget extends StatelessWidget {
  String validateText;
  String inputLabel;
  String inputHint;
  TextEditingController controller;

  TextFieldNormalWidget({
    super.key,
    required this.validateText,
    required this.inputHint,
    required this.inputLabel,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty || value.trim().isEmpty) {
          return validateText;
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(18),
        label: Text(inputLabel),
        // labelStyle: TextStyle(color: Colors.black),
        hintText: inputHint,
        hintStyle: const TextStyle(
          color: Colors.black26,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12, // Default border color
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12, // Default border color
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
