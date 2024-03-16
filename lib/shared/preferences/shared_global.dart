//Clase global que se encargara de gestionar de forma global toddas nuestras
// sharedPreference.. para ello vamos a utilizar el patron de diseño Singleton

import 'package:shared_preferences/shared_preferences.dart';

class SharedGlobal {
  //Llammamos a la instancia(creada abajo) dentro de la clase
  static final SharedGlobal myInstance = SharedGlobal
      ._instance(); //unica instancia que gestionara los sharedpreferences

  //Instancia
  SharedGlobal._instance(); //puede ser cualquier nombre

  //Creamos un objeto general a partir de esta clase (nos ayudamos de factory)
  factory SharedGlobal() {
    return myInstance;
  }

  //Gestionamos dentro de la clase toddos los SharedPreference que se van a utilizar
  late SharedPreferences?
      _prefs; //significa que luego(late) se le asigna al objeto _prefs se le asignara el valor deseado

  //Metodo que me sirve para inicializar o asignarle un valor a _prefs.. como se hacia Anteriormente
  //SharedPreferences _prefs = await SharedPreferences.getInstance() .. asi se asignaba al _prefs
  Future<void> initSharedPreference() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //Guardar un metodo..usamos los getters andd setters (POO)

  //Caracteristicas para el Fullname
  set fullName(String value) {
    _prefs?.setString("fullName", value);
  }

  String get fullName {
    return _prefs?.getString("fullName") ?? '-';
  }

  //Caracteristicas para el userUID
  set userUid(String value) {
    _prefs?.setString("userUid", value);
  }

  String get userUid {
    return _prefs?.getString("userUid") ?? '-';
  }

  //Caracteristicas para el Adress
  // set adress(String value) {
  //   _prefs?.setString("address", value);
  // }
  // String get adress {
  //   return _prefs?.getString("address") ?? '-';
  // }

  //Caracteristicas para el darkmode
  // set darkMode(bool value) {
  //   _prefs?.setBool("darkMode", value);
  // }

  // bool get darkMode {
  //   return _prefs?.getBool("darkMode") ?? false;
  // }

  //Caracteristicas para el genero
  // set gender(int value) {
  //   _prefs?.setInt("gender", value);
  // }
  // int get gender {
  //   return _prefs?.getInt("gender") ?? 0;
  // }

}
