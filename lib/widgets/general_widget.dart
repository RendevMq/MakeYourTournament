import 'package:flutter/material.dart';
import 'package:s4_integration2/config/constants/colors.dart';

showSnackBarError(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.only(bottom: context.size!.height*1.48),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: Colors.redAccent,
      content: Row(
        children: [
          Icon(
            Icons.warning_amber,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(text,)
        ],
      ),
    ),
  );
}

showSnackBarSucces(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: context.size!.height*0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: const Color(0xff17c3b2),
      content: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(text,)
        ],
      ),
    ),
  );
}

Widget loadingWidget() => const Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: kBrandWhite,
          strokeWidth: 2.2,
        ),
      ),
);