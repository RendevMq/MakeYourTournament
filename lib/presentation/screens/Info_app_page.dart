import 'package:flutter/material.dart';
import 'package:s4_integration2/config/constants/colors.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17182E),
      body: Center(
        child: Text("Favourite Page",        style: TextStyle(
          color: kBrandWhite,
        ),),
      ),
    );
  }
}
