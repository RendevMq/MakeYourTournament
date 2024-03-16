import 'dart:convert';

import 'package:s4_integration2/data/models/league_model.dart';
import 'package:s4_integration2/domain/entities/league_info.dart';

int yearSeason(List<Season> season) {
  int year = 0;
  for (int i = 0; i < season.length; i++) {
    if (season[i].coverage.standings == true) {
      year = season[i].year;
    }
  }
  return year;
}

/*==================================================================== */
int getNumberTeams(String numberTeamsString) {
  String jsonString = numberTeamsString;

  List<dynamic> lista = jsonDecode(jsonString);

  print(lista.length);

  return lista.length;
}

int getNumberMembersFilledTotal(String numberTeamsString) {
  String jsonString = numberTeamsString;

  List<dynamic> listAllTeams = jsonDecode(jsonString);

  int suma = 0;

  for (int i = 0; i < listAllTeams.length; i++) {
    List<dynamic> listTeam = listAllTeams[i];
    for (int i = 0; i < listTeam.length; i++) {
      suma++;
    }
  }

  return suma;
}

List<dynamic> getListNumberTeams(String numberTeamsString) {
  String jsonString = numberTeamsString;

  List<dynamic> lista = jsonDecode(jsonString);

  return lista;
}

List<dynamic> fromStrinrgToValidList(String data) {
  // Reemplaza los nombres de los equipos con comillas dobles
  data = data.replaceAllMapped(
      RegExp(r'(\bEquipo\d+\b)'), (match) => '"${match.group(0)}"');

  // Convierte la cadena en una lista de listas de cadenas
  List<dynamic> schedule = jsonDecode(data);

  // Imprime la lista resultante
  print(schedule);
  return schedule;
}

int getMembersTeam(List<int> membersTeam) {
  int members = 0;
  membersTeam.forEach(
    (element) {
      members = members + element;
    },
  );
  return members;
}

List<dynamic> getMembersTeamFilled(String numberTeamsString, int index) {
  String jsonString = numberTeamsString;

  List<dynamic> lista = jsonDecode(jsonString);

  return (lista[index]);
  // return lista[index].length;
}

int getNumberTeamFilled(String numberTeamsString, int index) {
  String jsonString = numberTeamsString;

  List<dynamic> allList = jsonDecode(jsonString); //[[...],  [...],  [... ]]

  List<dynamic> specificTeamList = allList[index];

  return (specificTeamList.length);
}
