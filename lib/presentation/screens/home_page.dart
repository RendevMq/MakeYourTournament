import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/modals/signin_modal.dart';
import 'package:s4_integration2/modals/signup_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference playReference =
      FirebaseFirestore.instance.collection("plays");

  bool fill = true;

  showSigninSignUp() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: fill ? SignInModal() : SignUpModal(),
        );
      },
    ).then((value) {
      print("-----------------------------");
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appSize = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    playReference.get().then(
      (value) {
        print(value);
      },
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    // "https://i.pinimg.com/564x/fc/cb/01/fccb014f97f424cf3d0dc8cf0e68047e.jpg"),
                    "https://i.pinimg.com/564x/ee/e4/23/eee42326466b4ceedb6fcd9bd262e8a9.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color.fromARGB(255, 104, 58, 158).withOpacity(0.9),
                  BlendMode.overlay,
                ),
              ),
            ),
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment(0, 0.2), // Ajusta la posición del gradiente
                colors: [
                  Colors.black
                      .withOpacity(1), // Aumenta la opacidad del color oscuro
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            top: _appSize.height * 0.08,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "WELCOME!!",
                textAlign: TextAlign.center,
                style: GoogleFonts.acme(
                  fontSize: 50,
                  color: kBrandWhite,
                ),
              ),
            ),
          ),
          Positioned(
            top: _appSize.height * 0.6,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Horizon',
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    ScaleAnimatedText('MAKE YOUR',
                        textStyle: GoogleFonts.acme(),
                        textAlign: TextAlign.center),
                    ScaleAnimatedText('TOURNAMENT!!',
                        textStyle: GoogleFonts.acme(),
                        textAlign: TextAlign.center),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: _appSize.height * 0.4,
            left: 0,
            right: 0,
            // right: 0,
            child: Image.network(
              "https://2.bp.blogspot.com/-xLbrWcFtoeY/XHWU0r1uWYI/AAAAAAAJIoo/WUupXXXuBJk776begM-L-8gGw309JXh4wCLcBGAs/s1600/Football_Player_Silhouette_PNG_Transparent_Clip_Art_Image.png",
              height: _appSize.height * 0.10,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                fill = true;
                setState(() {});
                showSigninSignUp();
                print(fill);
              },
              child: Container(
                width: _appSize.width * 0.5,
                height: 80,
                decoration: BoxDecoration(
                  color: fill ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: fill ? kBrandFourthColor : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                fill = false;
                showSigninSignUp();
                setState(() {});
                print(fill);
              },
              child: Container(
                width: _appSize.width * 0.5,
                height: 80,
                decoration: BoxDecoration(
                  color: fill == false ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: !fill ? kBrandFourthColor : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
