import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/config/helpers/convert_functions.dart';
import 'package:s4_integration2/config/helpers/show_schedule.dart';
import 'package:s4_integration2/data/models/config_tourno_model.dart';
import 'package:s4_integration2/presentation/bottomNavigation/navigation_page.dart';
import 'package:s4_integration2/presentation/providers/teams_provider.dart';
import 'package:s4_integration2/presentation/providers/tshirtProvider.dart';
import 'package:s4_integration2/presentation/screens/tournament_page.dart';
import 'package:s4_integration2/services/my_service_firestore.dart';
import 'package:s4_integration2/shared/preferences/shared_global.dart';
import 'package:s4_integration2/widgets/general_widget.dart';
import 'package:s4_integration2/widgets/item_team_tournament_widget.dart';
import 'package:s4_integration2/widgets/player_shirt_widget.dart';

class SelectTeam extends StatefulWidget {
  String tournoId;
  SelectTeam({super.key, required this.tournoId});

  @override
  State<SelectTeam> createState() => _SelectTeamState();
}

class _SelectTeamState extends State<SelectTeam> {
  MyServiceFirestore tournoService =
      MyServiceFirestore(collection: "tournament");
  MyServiceFirestore userService = MyServiceFirestore(collection: "users");
  final SharedGlobal _sharedGlobal = SharedGlobal();

  List<int> formacion = [];
  int? torunoTeams;

  ConfigTournoModel? tournoModel;

  @override
  void initState() {
    // TODO: implement initState
    print(widget.tournoId);
    tournoService.getTournamentData(widget.tournoId).then((value) {
      ConfigTournoModel tournamentModel =
          ConfigTournoModel.fromJson(value.data() as Map<String, dynamic>);

      formacion = tournamentModel.membersTeam.reversed.toList();
      // print(tournamentModel.membersTeam);
      print(tournamentModel.numberTeams);
      tournoModel = tournamentModel;
      torunoTeams = getNumberTeams(tournoModel!.numberTeams);
      setState(() {});
    });
    //USO DEL CONTEXTO DENTRO DEL INITSTATE
    Future.delayed(Duration.zero, () {
      final currentContext = this.context;
      final teamProvider = currentContext.read<TeamsProvider>();
      teamProvider.updateNullTeamIndex();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _tshirtProvider = context.watch<TshirtProvier>();
    final _teamProvider = context.watch<TeamsProvider>();

    return PopScope(
      onPopInvoked: (_) {
        _tshirtProvider.playerSelected = [100, 100];
      },
      child: Scaffold(
        body: Container(
          decoration: decorationScafoold,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 40,
                  left: 12,
                  right: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _tshirtProvider.playerSelected = [
                          100,
                          100
                        ]; //para remover el seleccionado
                      },
                      color: kBrandWhite,
                    ),
                    Text(
                      "SELECT \n YOUR TEAM",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.acme(
                        color: kBrandWhite,
                        letterSpacing: 2,
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        tournoModel != null
                            ? showMyAlert3(context, tournoModel!)
                            : {};
                      },
                      icon: const Icon(
                        Icons.app_registration_outlined,
                        color: kBrandWhite,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    tournoModel != null
                        ? "${tournoModel!.tournamentName}"
                        : "....",
                    style: GoogleFonts.acme(
                        color: kBrandWhite.withOpacity(0.5),
                        fontSize: 20,
                        letterSpacing: 2),
                  ),
                  Stack(
                    children: [
                      Image.asset("assets/images/field1.png"),
                      tournoModel == null
                          ? Container()
                          : Positioned.fill(
                              // Ocupamos todo el espacio disponible por el stack
                              child: Container(
                                // color: Colors.red.withOpacity(0.5),
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 33),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: List.generate(
                                    formacion.length,
                                    (index1) {
                                      return Stack(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 80),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: List.generate(
                                                formacion[index1],
                                                (index2) {
                                                  final isSelected = _tshirtProvider
                                                                      .playerSelected[
                                                                  0] ==
                                                              index1 &&
                                                          _tshirtProvider
                                                                      .playerSelected[
                                                                  1] ==
                                                              index2 ||
                                                      _tshirtProvider
                                                          .defaultSelectedPlayers
                                                          .any((element) =>
                                                              element[0] ==
                                                                  index1 &&
                                                              element[1] ==
                                                                  index2);
                                                  return PlayerShirt(
                                                    listIndex1and2: [
                                                      index1,
                                                      index2
                                                    ],
                                                    isSelected: isSelected,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Text(
                  //   "Jugadores: ${_tshirtProvider.selectedPlayers}",
                  //   style: TextStyle(color: Colors.white),
                  // ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_tshirtProvider.selectedPlayers.length !=
                          _tshirtProvider.defaultSelectedPlayers.length) {
                        print(tournoModel!.numberTeams);
                        List<dynamic> aux =
                            getListNumberTeams(tournoModel!.numberTeams);
                        aux[_tshirtProvider.indexTeamTournament!] =
                            _tshirtProvider.selectedPlayers;
                        await tournoService.addMemberInTeamUpdateString(
                            aux.toString(), widget.tournoId);

                        final userData = await userService
                            .getUserData(_sharedGlobal.userUid);
                        print(userData); //[[], "[]"]
                        print(_tshirtProvider.selectedPlayers.last);
                        print(widget.tournoId);

                        List<String> updateTournoIds = [
                          ...userData[0],
                          widget.tournoId
                        ];

                        List<dynamic> listPlaces = jsonDecode(userData[1]);
                        listPlaces.add(_tshirtProvider.selectedPlayers.last);
                        String updatePlaces = listPlaces.toString();

                        await userService.registerUpdateInfoUserInTeam(
                          updateTournoIds,
                          updatePlaces,
                          _sharedGlobal.userUid,
                        );

                        //Navigator.pop(context); //NO ACTUALIZA LA IMAGEN A BLANCO
                        // Navigator.push( //no tendremos el tabBar
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => TournamentPage(),
                        //   ),
                        // );
                        Navigator.push(
                          //CORREGIR, LEER RECOMENDACION
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavigationPage(
                              index: 1,
                            ),
                          ),
                        );
                        showSnackBarSucces(
                            context, "Se reservó con éxito"); //CORREGIR
                      } else {
                        Alert(
                          context: context,
                          type: AlertType.info,
                          title: "Select a player first",
                          buttons: [
                            DialogButton(
                              color: kBrandThirdColor,
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                      }
                    },
                    icon: Icon(
                      Icons.add_circle_sharp,
                    ),
                    label: Text(
                      "Register",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Select a Team",
                    style: TextStyle(color: kBrandWhite, fontSize: 16),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              tournoModel != null
                  ? Expanded(
                      child: ListView.builder(
                        // shrinkWrap: ,
                        // scrollDirection: Axis.horizontal,
                        itemCount: torunoTeams,
                        itemBuilder: (context, index) {
                          //loogica
                          bool isSelected = false;
                          index == _teamProvider.teamIndex
                              ? isSelected = true
                              : isSelected = false;
                          return ItemTeamTournamentWidget(
                            tournoModel: tournoModel!,
                            index: index,
                            isSelected: isSelected,
                          );
                        },
                      ),
                    )
                  : Center(
                      child: loadingWidget(),
                    )
            ],
          ), // Tu contenido aquí
        ),
      ),
    );
  }
}
