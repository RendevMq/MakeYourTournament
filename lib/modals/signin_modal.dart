import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/config/helpers/login_email_function.dart';
import 'package:s4_integration2/config/helpers/login_google_function.dart';
import 'package:s4_integration2/widgets/textfield_normal_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:s4_integration2/widgets/textfield_password_widget.dart';

class SignInModal extends StatefulWidget {
  const SignInModal({super.key});

  @override
  State<SignInModal> createState() => _SignInModalState();
}

class _SignInModalState extends State<SignInModal> {
  final _formSignupKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // height: 500,
        padding:const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34),
            topRight: Radius.circular(34),
          ),
        ),
        child: Form(
          key: _formSignupKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // get started text
              Text(
                'Welcome Back',
                style: GoogleFonts.acme(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w900,
                  color: kBrandFourthColor,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 25.0,
              ),
              TextFieldNormalWidget(
                validateText: 'Please enter Email',
                inputLabel: 'Email',
                inputHint: 'Enter Email',
                controller: _emailController,
              ),
              const SizedBox(
                height: 25.0,
              ),
              TextFieldPasswordWidget(
                controller: _passwordController,
                validateText: 'Please enter Password',
                inputHint: 'Enter Password',
                inputLabel: 'Password',
              ),
              const SizedBox(
                height: 25.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBrandFourthColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  onPressed: () {
                    login(context, _formSignupKey, _emailController,
                        _passwordController);
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.7,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                    child: Text(
                      'Sign in with',
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.7,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    loginWithGooglee(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:const Color(0xfff84b2a),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: SvgPicture.asset(
                    'assets/icons/google.svg',
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  label:const  Text(
                    "Iniciar con Google",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     _googleSignIn.signOut();
              //   },
              //   child: const Text("Cerrar"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
