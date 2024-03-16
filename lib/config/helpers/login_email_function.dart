import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s4_integration2/presentation/bottomNavigation/navigation_page.dart';
import 'package:s4_integration2/services/my_service_firestore.dart';
import 'package:s4_integration2/shared/preferences/shared_global.dart';
import 'package:s4_integration2/widgets/general_widget.dart';

MyServiceFirestore userService = MyServiceFirestore(collection: "users");
final SharedGlobal _sharedGlobal = SharedGlobal();

login(
  BuildContext context,
  GlobalKey<FormState> key,
  TextEditingController emailController,
  TextEditingController passwordController,
) async {
  try {
    if (key.currentState!.validate()) {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;
        print(uid); // Esto imprimirá el UID del usuario EN AUTH

        //GUARDAMOS EN SHARED PREFERENCES
        String email = userCredential.user!.email!;
        print(email); // Esto imprimirá el EMAIL del usuario

        userService.getUserDatabyEmail(email).then(
          (value) {
            //SABEMOS QUE NO SE PUEDE REPETIR EL EMAIL
            QueryDocumentSnapshot docs = value.docs[0];

            print(docs.data());
            print(docs.id);
            _sharedGlobal.userUid = docs.id;

            Map<String, dynamic> myMap = docs.data() as Map<String, dynamic>;
            print(myMap["fullName"]);
            _sharedGlobal.fullName =
                myMap["fullName"]; //GUARAMOS EL NOMBRE COMPLETO

            //IMPRIMIMOS LOS PROFERENCES
            print("UID: ${_sharedGlobal.userUid}");
            print("FULLNAME: ${_sharedGlobal.fullName}");

            //NAVEAMOS A LA OTRA PANTALLA
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigationPage()),
              (route) => false,
            );
          },
        );
      }
    }
  } on FirebaseAuthException catch (error) {
    if (error.code == "invalid-email") {
      showSnackBarError(context, "El correo electrónico es inválido");
    } else if (error.code == "user-not-found") {
      showSnackBarError(context, "El usuario no está registrado");
    } else if (error.code == "wrong-password") {
      showSnackBarError(context, "La contraseña es incorrecta");
    }
  }
}
