import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s4_integration2/data/models/config_tourno_model.dart';
import 'package:s4_integration2/services/my_service_firestore.dart';
import 'package:s4_integration2/shared/preferences/shared_global.dart';
import 'package:s4_integration2/widgets/general_widget.dart';

MyServiceFirestore userService = MyServiceFirestore(collection: "tournament");
final SharedGlobal _sharedGlobal = SharedGlobal();

List<List<int>> membersTeam = [
  [1, 2], // 3 members
  [1, 2, 1], // 4 members
  [1, 2, 2], // 5 members
  [1, 3, 2], // 6 members
  [1, 3, 3], // 7 members
  [1, 3, 3, 1], // 8 members
  [1, 4, 2, 2], // 9 members
  [1, 4, 3, 2], // 10 members
  [1, 4, 3, 3], // 11 members
];

String generarEmparejamientos(int numeroEquipos) {
  List<List<List<String>>> emparejamientos = [];

  if (numeroEquipos % 2 != 0) {
    numeroEquipos++; // Si el número de equipos es impar, agregamos un equipo ficticio
  }

  List<String> equipos =
      List.generate(numeroEquipos, (index) => 'Equipo${index + 1}');
  //print(equipos);

  for (int jornada = 0; jornada < numeroEquipos - 1; jornada++) {
    List<String> equiposCopiados = List.from(equipos);
    equiposCopiados.shuffle();

    List<List<String>> jornadaEmparejamientos = [];
    for (int i = 0; i < numeroEquipos / 2; i++) {
      List<String> emparejamiento = [
        equiposCopiados[i],
        equiposCopiados[i + numeroEquipos ~/ 2]
      ];
      jornadaEmparejamientos.add(emparejamiento);
    }

    emparejamientos.add(jornadaEmparejamientos);
  }
  //print("$emparejamientos");
  return "$emparejamientos";
}

String crearListaDeListasVacias(int n) {
  List<List<dynamic>> lista = [];
  for (int i = 0; i < n; i++) {
    lista.add([]);
  }
  return "$lista";
}

void registerTournament(
  BuildContext context,
  GlobalKey<FormState> key,
  TextEditingController tournamentNameController,
  TextEditingController numberTeamsController,
  TextEditingController membersTeamController,
  TextEditingController prizeController,
) async {
  try {
    if (key.currentState!.validate()) {
      //VALIDAMOS EL FORMULARIO, CADA INPUT DEBE TENER SU VALIDATOR, DONDE ESTA ESPECIFICO EL MENSAJE DE VALIDACION.´
      //Luego de cser validado puede agregar una tarea
      //Construimos el modelo
      ConfigTournoModel configModel = ConfigTournoModel(
        idCreator: _sharedGlobal.userUid,
        tournamentName: tournamentNameController.text,
        numberTeams: crearListaDeListasVacias(
            int.parse(numberTeamsController.text)), //"[[],[],..]"
        membersTeam:
            membersTeam[int.parse(membersTeamController.text) - 3], //[1, 3, 2]
        //"[[[..],[..],..]  ,  [[..],[..],..]   , ...]"
        schedule: generarEmparejamientos(int.parse(numberTeamsController.text)),
        status: false,
        prize: int.parse(prizeController.text),
      );

      userService.addTask(configModel).then(
        (value) {
          if (value.isNotEmpty) {
            Navigator.pop(context);
            //insertamos el snackbar luego de que se registro
            showSnackBarSucces(context, "La tarea fue registrada con éxito");
          }
        },
      ).catchError(
        (e) {
          showSnackBarError(
              context, "Hubo un inconveniente, inténtalo nuevamente");
          Navigator.pop(context);
        },
      );
      tournamentNameController.text = "";
      numberTeamsController.text = "";
      membersTeamController.text = "";
      prizeController.text = "";
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
