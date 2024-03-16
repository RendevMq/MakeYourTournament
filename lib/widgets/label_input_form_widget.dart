import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabelInputFormWidget extends StatelessWidget {
  String labelText;
  TextInputType keyBoardType;
  List<TextInputFormatter> formatterrs;
  String hintText;
  TextEditingController controller;
  String validateText;

  LabelInputFormWidget({
    super.key,
    required this.labelText,
    required this.keyBoardType,
    required this.formatterrs,
    required this.hintText,
    required this.controller,
    required this.validateText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            labelText,
            style: TextStyle(fontSize: 15),
          ),
        ), // Espacio entre el texto y el TextFormField
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value!.isEmpty || value.trim().isEmpty) {
                return "Obligatorio";
              }
              return null;
            },
            keyboardType: keyBoardType, // Teclado numérico
            inputFormatters: formatterrs,
            style: TextStyle(fontSize: 15), // Establecer color del texto
            decoration: InputDecoration(
              border: OutlineInputBorder(), // Bordes del TextFormField
              hintText: hintText, // Texto de ayuda
              contentPadding: EdgeInsets.all(8),
              // hintStyle: TextStyle(
              //     color: kBrandWhite.withOpacity(
              //         0.5)), // Establecer color del texto
              // labelStyle: TextStyle(
              //     color: kBrandWhite), // Establecer color del texto
            ),
          ),
        ),
      ],
    );
  }
}
