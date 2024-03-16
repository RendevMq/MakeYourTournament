import 'package:flutter/material.dart';

class TshirtProvier extends ChangeNotifier {
  List<dynamic> playerSelected = [5, 5];
  List<dynamic> defaultSelectedPlayers = [];
  // List<List<int>> defaultSelectedPlayers = [
  //   [0, 0],
  //   [2, 2],
  //   [1, 2]
  // ];
  List<dynamic> selectedPlayers = [];
  int? indexTeamTournament;

  void setIndexTeam(int index) {
    indexTeamTournament = index;
    notifyListeners();
    print(indexTeamTournament);
  }

  void setPlayerSelected() {
    playerSelected = [100,100];
    notifyListeners();
  }

  void setDefaultPlayers(List<dynamic> players) {
    selectedPlayers = []; //Limpio la lista anterior
    defaultSelectedPlayers = players; //le agrego los de este equipo
    selectedPlayers = []
      ..addAll(defaultSelectedPlayers); //igualo a los seleccionados
    notifyListeners();
  }

  TshirtProvier() {
    selectedPlayers = []..addAll(defaultSelectedPlayers);
  }
  void selectPlayer(List<dynamic> currentPlayer) {
    playerSelected = currentPlayer;

    // Verifica si el jugador ya está en la lista de seleccionados
    final isDefaultPlayer = defaultSelectedPlayers.any((element) =>
        element[0] == currentPlayer[0] && element[1] == currentPlayer[1]);
    final isAlreadySelected = selectedPlayers.any((element) =>
        element[0] == currentPlayer[0] && element[1] == currentPlayer[1]);

    // Si selecciona un jugador por defecto, elimina los adicionales
    if (isDefaultPlayer) {
      selectedPlayers.clear();
      selectedPlayers.addAll(defaultSelectedPlayers);
    } else {
      // Limita la cantidad de jugadores seleccionados a 3
      if (!isAlreadySelected) {
        if (selectedPlayers.length < defaultSelectedPlayers.length + 1) {
          selectedPlayers.add(List.from(currentPlayer));
        } else {
          // Si ya hay 3 jugadores seleccionados, reemplaza el último
          selectedPlayers[defaultSelectedPlayers.length] =
              List.from(currentPlayer);
        }
      }
    }
    print("${selectedPlayers} + playerssss");
    notifyListeners();
  }
}
