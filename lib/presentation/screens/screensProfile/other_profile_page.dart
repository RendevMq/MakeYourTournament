import 'package:flutter/material.dart';
import 'package:s4_integration2/config/constants/colors.dart';

class OtherProfilePage extends StatelessWidget {
  const OtherProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "OtherProfilePage",
        style: TextStyle(
          color: kBrandWhite,
          fontSize: 20,
        ),
      ),
    );
  }
}
