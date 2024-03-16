// import 'package:flutter/material.dart';
// import 'package:s4_integration2/data/models/standings_model.dart';
// import 'package:s4_integration2/domain/entities/standings_season.dart';
// import 'package:s4_integration2/shared/data/standings_one_league.dart';

// class StandingProvider extends ChangeNotifier {

//   bool initialLoading = true;
//   int? seasonLeague;
//   int? idLeague;
//   List<StandingsSeason> teamStandingData = [];
//   String? leagueName;
//   int? leagueSeason;

//   Future<void> loadStandingData(int season, int id, String name) async {
//     leagueName = name;
//     leagueSeason = season;
//     idLeague = id;

//     //Simulando la peticion de un endpoint
//     await Future.delayed(
//       const Duration(seconds: 1),
//     );
//     print("hola");
//     teamStandingData = [];
//     // print(standingsMap["response"][0]["league"]["standings"]);

//     //COMENTARLO YA QUE ES LA FORMA DE HECRLO CON DATA LOCAL..
//     final teamStanding = standingsMap["response"][0]["league"]["standings"][0];

//     //carga de ligas
//     final List<StandingsSeason> allStandings = teamStanding
//         .map<StandingsSeason>(
//           (league) => StandingsModel.fromJson(league).toStandingSeasonEntity(),
//         )
//         .toList();

//     teamStandingData.addAll(allStandings); //carga las ligas
//     initialLoading = false; //ya pasamos la carga de videos
//     notifyListeners();
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:s4_integration2/data/models/standings_model.dart';
import 'package:s4_integration2/domain/entities/standings_season.dart';
import 'package:s4_integration2/shared/data/standings_one_league.dart';
import 'package:http/http.dart' as http;

class StandingProvider extends ChangeNotifier {
  //final season = 10; //Samos al darclick en cualquier card
  //final id = 32 //Sacamos en cualquier cardd
  bool initialLoading = true;
  int? seasonLeague;
  int? idLeague;
  List<StandingsSeason> teamStandingData = [];
  String? leagueName;
  int? leagueSeason;

  Future<void> loadStandingData(int season, int id, String name) async {
    /*=================== API FOOTBALL ================= */
    final url = Uri.parse(
        'https://api-football-beta.p.rapidapi.com/standings?season=${season}&league=${id}');
    final headers = {
      'X-RapidAPI-Key': '538792a512msh4656b20ef83c9d5p1409fejsnd2b7df449eec',
      'X-RapidAPI-Host': 'api-football-beta.p.rapidapi.com',
    };

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {

      Map<String, dynamic> myMap = json.decode(response.body);

      leagueName = name;
      leagueSeason = season;
      idLeague = id;

      teamStandingData = [];
      // print(standingsMap["response"][0]["league"]["standings"]);

      //COMENTARLO YA QUE ES LA FORMA DE HECRLO CON DATA LOCAL..
      final teamStanding =
          myMap["response"][0]["league"]["standings"][0];

      //carga de ligas
      final List<StandingsSeason> allStandings = teamStanding
          .map<StandingsSeason>(
            (league) =>
                StandingsModel.fromJson(league).toStandingSeasonEntity(),
          )
          .toList();

      teamStandingData.addAll(allStandings); //carga las ligas
      initialLoading = false; //ya pasamos la carga de videos
      notifyListeners();
    }
  }
}
