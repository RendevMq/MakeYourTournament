import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/data/models/user_model.dart';
import 'package:s4_integration2/presentation/bottomNavigation/navigation_page.dart';
import 'package:s4_integration2/services/my_service_firestore.dart';
import 'package:s4_integration2/shared/preferences/shared_global.dart';
import 'package:s4_integration2/widgets/general_widget.dart';
import 'package:s4_integration2/widgets/textfield_normal_widget.dart';
import 'package:s4_integration2/widgets/textfield_password_widget.dart';

class SignUpModal extends StatefulWidget {
  const SignUpModal({super.key});

  @override
  State<SignUpModal> createState() => _SignUpModalState();
}

class _SignUpModalState extends State<SignUpModal> {
  final _formSignupKey1 = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  MyServiceFirestore userService = MyServiceFirestore(
      collection:
          "users"); //CREAMOS UNA INSTANCIA PRIMERO PARA UTILIZAR LODE METODOS DEL SERVICIO

  final SharedGlobal _sharedGlobal = SharedGlobal();

  _registerUser() async {
    try {
      if (_formSignupKey1.currentState!.validate()) {
        //VALIDAMOS EL FORMULARIO, CADA INPUT DEBE TENER SU VALIDATOR, DONDE ESTA ESPECIFICO EL MENSAJE DE VALIDACION.´

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          //CTRL + CLICK, es un future
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (userCredential.user != null) {
          UserModel usermodel = UserModel(
            fullName: _fullNameController.text,
            email: _emailController.text,
          );
          userService.addUser(usermodel).then(
            (value) {
              if (value.isNotEmpty) {
                print(value);
                //GUARDAMOS LOS PREFERENCES
                _sharedGlobal.userUid = value;
                _sharedGlobal.fullName = _fullNameController.text;

                //NAVEGAMOS A LA OTRA PANTALLA
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationPage()),
                  (route) => false,
                );

                //IMPRIMIMOS LOS PROFERENCES
                print("UID: ${_sharedGlobal.userUid}");
                print("FULLNAME: ${_sharedGlobal.fullName}");
              }
            },
          );
        }
      }
    } on FirebaseAuthException catch (error) {
      //MENEJO DE EXCEPCIONES
      if (error.code == "weak-password") {
        showSnackBarError(context, "La contraseña es muy debil");
      } else if (error.code == "email-already-in-use") {
        showSnackBarError(context, "La correo electronico ya esta usado");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formSignupKey1,
      child: SingleChildScrollView(
        child: Container(
          // height: 500,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(34),
              topRight: Radius.circular(34),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // get started text
              Text(
                'Get Started',
                style: GoogleFonts.acme(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w900,
                  color: kBrandFourthColor,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFieldNormalWidget(
                validateText: 'Please enter Full name',
                inputLabel: 'Full Name',
                inputHint: 'Enter Full Name',
                controller: _fullNameController,
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
                    _registerUser();
                  },
                  child: Text(
                    "Sign up",
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
            ],
          ),
        ),
      ),
    );
  }
}
