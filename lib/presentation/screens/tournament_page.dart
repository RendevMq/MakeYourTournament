import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/config/helpers/config_make_tournament_alert_future.dart';
import 'package:s4_integration2/data/models/config_tourno_model.dart';
import 'package:s4_integration2/extensions/context_extensions.dart';
import 'package:s4_integration2/presentation/providers/teams_provider.dart';
import 'package:s4_integration2/services/my_service_firestore.dart';
import 'package:s4_integration2/shared/preferences/shared_global.dart';
import 'package:s4_integration2/widgets/general_widget.dart';
import 'package:s4_integration2/widgets/item_tournament.dart';

class TournamentPage extends StatefulWidget {
  TournamentPage({super.key});

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  MyServiceFirestore tournoService =
      MyServiceFirestore(collection: "tournament");
  MyServiceFirestore userService = MyServiceFirestore(collection: "users");

  List<ConfigTournoModel> tournamentsGeneral = [];
  final SharedGlobal _sharedGlobal = SharedGlobal();
  List<dynamic>? userTournoIds;
  List<dynamic>? userTournoPlaces;

  @override
  void initState() {
    userService.getUserData(_sharedGlobal.userUid).then(
      (value) {
        print(value); //[[], "[]"]
        // print(_tshirtProvider.selectedPlayers.last);
        // print(widget.tournoId);
        userTournoIds = value[0];
        userTournoPlaces = jsonDecode(value[1]);
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      
    });

    return Scaffold(
      backgroundColor: Color(0xff17182E),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Container(
            width: context.width,
            child: Column(
              children: [
                Text(
                  "TOURNAMENTS",
                  style: GoogleFonts.acme(
                    color: kBrandWhite,
                    fontSize: 25,
                    letterSpacing: 2.5,
                  ),
                ),
                SizedBox(
                  height: context.height * 0.025,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showMyAlert2(context);
                  },
                  icon: Icon(Icons.add_box_outlined),
                  label: Text(
                    "MAKE YOUR TOURNAMENT",
                  ),
                ),
                SizedBox(
                  height: context.height * 0.025,
                ),
                Text(
                  "ALL",
                  style: GoogleFonts.acme(
                    color: kBrandWhite.withOpacity(0.8),
                    fontSize: 20,
                    letterSpacing: 2.5,
                  ),
                ),
                Text(
                  "TOURNAMENTS",
                  style: GoogleFonts.acme(
                    color: kBrandWhite.withOpacity(0.8),
                    fontSize: 20,
                    letterSpacing: 2.5,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  margin: EdgeInsets.only(bottom: context.height * 0.09),
                  child: (userTournoIds == null && userTournoIds != [])
                      ? loadingWidget()
                      : StreamBuilder(
                          stream: tournoService.collectionn.snapshots(),
                          builder: (BuildContext context, AsyncSnapshot snap) {
                            if (snap.hasData) {
                              //print(snap.hasData);
                              List<ConfigTournoModel> tournaments = [];
                              QuerySnapshot collection = snap.data;

                              tournaments = collection.docs.map(
                                (e) {
                                  ConfigTournoModel tournamentModel =
                                      ConfigTournoModel.fromJson(
                                          e.data() as Map<String, dynamic>);
                                  tournamentModel.idTourno = e.id;
                                  return tournamentModel;
                                },
                              ).toList();

                              tournamentsGeneral
                                  .clear(); //limpiamos al taskgeneral a enviar
                              tournamentsGeneral =
                                  tournaments; //asignamos la lista de tasksmodels

                              return GridView.count(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.8,
                                children: tournaments.map(
                                  (e) {
                                    bool painted = false;
                                    for (var id in userTournoIds!) {
                                      if (id == e.idTourno) {
                                        painted = true;
                                        break;
                                      }
                                    }

                                    return ItemTournament(
                                      tournoModel: e,
                                      colorImage: painted,
                                    );
                                  },
                                ).toList(),
                              );
                            }
                            return loadingWidget();
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
