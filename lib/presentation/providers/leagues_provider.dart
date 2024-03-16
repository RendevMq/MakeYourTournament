import 'package:flutter/material.dart';
import 'package:s4_integration2/data/models/league_model.dart';
import 'package:s4_integration2/domain/entities/league_info.dart';
import 'package:s4_integration2/shared/data/local_league_post.dart';

class LeagueProvider extends ChangeNotifier {
  bool initialLoading = true;
  List<LeagueInfo> worldLeagues = [];
  List<LeagueInfo> countryLeagues = [];

  Future<void> loadWorldData() async {
    //Simulando la peticion de un endpoint
    await Future.delayed(
      const Duration(seconds: 1),
    );

    final leagueMapList = leagueMap["response"];

    final filteredLeagues = leagueMapList
        .where((league) => league["league"]["type"] == "Cup")
        .toList();

    //carga de ligas
    final List<LeagueInfo> allLeagues = filteredLeagues
        .map<LeagueInfo>(
          (league) => LeagueModel.fromJson(league).toLeagueInfoEntity(),
        )
        .toList();
    allLeagues.sort((a, b) => a.id.compareTo(b.id));
    allLeagues.removeWhere((element) => element.id == 1);

    worldLeagues.addAll(allLeagues); //carga las ligas
    initialLoading = false; //ya pasamos la carga de videos
    notifyListeners();
  }

  Future<void> loadCountryData() async {
    //Simulando la peticion de un endpoint
    await Future.delayed(
      const Duration(seconds: 1),
    );

    final leagueMapList = leagueMap["response"];

    final filteredLeagues = leagueMapList
        .where((league) => league["league"]["type"] != "Cup")
        .toList();

    //carga de ligas
    final List<LeagueInfo> allCountrysLeagues = filteredLeagues
        .map<LeagueInfo>(
          (league) => LeagueModel.fromJson(league).toLeagueInfoEntity(),
        )
        .toList();
    // allCountrysLeagues.sort((a, b) => a.id.compareTo(b.id));

    countryLeagues.addAll(allCountrysLeagues); //carga las ligas
    initialLoading = false; //ya pasamos la carga de videos
    notifyListeners();
  }



}
