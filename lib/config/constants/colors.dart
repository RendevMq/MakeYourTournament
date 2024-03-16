import 'package:flutter/material.dart';

const kBrandPrimaryColor = Color(0xff17182E);
const kBrandSecondaryColor = Color(0xff1C1D38);
const kBrandThirdColor = Color(0xff7057F4);
const kBrandWhite = Colors.white;

const kBrandFourthColor = Color(0xff6032A5);
const kBrandFifthColor = Color(0xff383838);
const kBrandSixthColor = Color.fromARGB(255, 33, 34, 65);

const decorationScafoold = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color(0xff17182E), // Color base
      Color(0xff15162C), // Tono más oscuro
      Color(0xff131429), // Tono aún más oscuro
      Color(0xff111328), // Tono aún más oscuro
    ],
    stops: [0.0, 0.3, 0.6, 1.0],
  ),
);

Map<String, Color> categoryColor = {
  "Player": Color(0xff3E80FF),
  "Tournament": Color(0xffEF476F),
  "Otro": Color.fromARGB(255, 48, 202, 156),
};
