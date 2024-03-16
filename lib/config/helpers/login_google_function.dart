  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:s4_integration2/data/models/user_model.dart';
import 'package:s4_integration2/presentation/bottomNavigation/navigation_page.dart';
import 'package:s4_integration2/services/my_service_firestore.dart';
import 'package:s4_integration2/shared/preferences/shared_global.dart';

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  MyServiceFirestore userService = MyServiceFirestore(collection: "users");
  final SharedGlobal _sharedGlobal = SharedGlobal();

  saveSharedPreference(String uid, String fullname) {
    //GUARDAMOS LOS SHARED PREFERENCES
    _sharedGlobal.userUid = uid;
    _sharedGlobal.fullName = fullname;

    //IMPRIMIMOS LOS PROFERENCES
    print("UID: $uid");
    print("FULLNAME: $fullname");
  }

loginWithGooglee(BuildContext context) async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    print(googleSignInAccount);

    if (googleSignInAccount == null) {
      return;
    }

    GoogleSignInAuthentication _gooleSignInAuth =
        await googleSignInAccount.authentication;

    OAuthCredential credentials = GoogleAuthProvider.credential(
      accessToken: _gooleSignInAuth.accessToken,
      idToken: _gooleSignInAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credentials);

    if (userCredential.user != null) {
      UserModel userModel = UserModel(
        fullName: userCredential.user!.displayName!,
        email: userCredential.user!.email!,
      );

      userService.existUser(userCredential.user!.email!).then(
        (value) {
          if (value[1] == false) {
            //AÑADIMOS A FIREBASE
            userService.addUser(userModel).then(
              (value) {
                // print(userModel);
                if (value.isNotEmpty) {
                  //SE GUARDADDN LOS PREEFERENCES
                  saveSharedPreference(value, userModel.fullName); //VALUE DE RETORNO DE ADDUSER

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavigationPage()),
                    (route) => false,
                  );
                }
              },
            );
          } else {
            //SE GUARDADDN LOS PREEFERENCES
            saveSharedPreference(value[0], userModel.fullName); //VALUE DE RETORNO DE existUser

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigationPage()),
              (route) => false,
            );
          }
        },
      );
    }
  }