import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/config/helpers/convert_functions.dart';
import 'package:s4_integration2/data/models/config_tourno_model.dart';
import 'package:s4_integration2/extensions/context_extensions.dart';

showMyAlert3(BuildContext mycontext ,ConfigTournoModel tournoModel) {
  final _formKey = GlobalKey<FormState>();

  return showDialog(
    context: mycontext,
    builder: (BuildContext mycontext) {
      return GestureDetector(
        onTap: () {
          print("Hola");
        },
        child: AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: mycontext.height * 0.65,
                  child: EmparejamientosPage(schedule: (tournoModel.schedule)),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(mycontext);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: kBrandThirdColor),
                      child: const Text(
                        "Ok",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: kBrandWhite),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class EmparejamientosPage extends StatelessWidget {
  // final int numeroEquipos;

  //  List<List<List<String>>> schedule;
  String schedule;
  EmparejamientosPage({required this.schedule});


  @override
  Widget build(BuildContext context) {
    // List<List<List<String>>> emparejamientos =
    //     generarEmparejamientos(numeroEquipos);
    // List<List<List<String>>> emparejamientos = schedule;

    return ListView.builder(
      itemCount: fromStrinrgToValidList(schedule).length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "MATCHDAY ${index + 1} :",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:  fromStrinrgToValidList(schedule)[index].length,
              itemBuilder: (context, subIndex) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "${ fromStrinrgToValidList(schedule)[index][subIndex][0]} vs ${ fromStrinrgToValidList(schedule)[index][subIndex][1]}",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
