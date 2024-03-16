import 'package:flutter/material.dart';
import 'package:s4_integration2/config/constants/colors.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  // const TextFieldPasswordWidget({super.key});
  final TextEditingController controller;
  final String validateText;
  final String inputLabel;
  final String inputHint;

  TextFieldPasswordWidget({
    required this.controller,
    required this.validateText,
    required this.inputHint,
    required this.inputLabel,
  });

  @override
  State<TextFieldPasswordWidget> createState() =>
      _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {
  bool isInvisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !isInvisible,
      validator: (value) {
        if (value!.isEmpty || value.trim().isEmpty) {
          return widget.validateText;
        }
        return null;
      },
      decoration: InputDecoration(     
        contentPadding: EdgeInsets.all(18),
        label: Text(widget.inputLabel),
        hintText: widget.inputHint,
        hintStyle: TextStyle(
          color: Colors.black26,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            isInvisible = !isInvisible;
            setState(() {});
          },
          icon: Icon(
            isInvisible ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
            color: kBrandPrimaryColor.withOpacity(0.6),
          ),
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
