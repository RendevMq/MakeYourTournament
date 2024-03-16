import 'package:flutter/material.dart';

class TeamsProvider extends ChangeNotifier {
  int? teamIndex; //if there ar 5 teams => [0,1,2,3,4]

  void updateTeamIndex(int teamsNumber) {
    teamIndex = teamsNumber;
    notifyListeners();
  }
  void updateNullTeamIndex() {
    teamIndex = null;
    notifyListeners();
  }
  
}
