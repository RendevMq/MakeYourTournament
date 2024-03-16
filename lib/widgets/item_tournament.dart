import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/config/helpers/convert_functions.dart';
import 'package:s4_integration2/data/models/config_tourno_model.dart';
import 'package:s4_integration2/presentation/providers/tshirtProvider.dart';
import 'package:s4_integration2/presentation/screens/select_team.dart';

class ItemTournament extends StatelessWidget {
  ConfigTournoModel tournoModel;
  bool colorImage;

  ItemTournament(
      {super.key, required this.tournoModel, required this.colorImage});

  @override
  Widget build(BuildContext context) {
    final _tshirtProvider = context.watch<TshirtProvier>();

    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => SelectTeam(tournoId: tournoModel.idTourno!),
        //   ),
        // );
        // _tshirtProvider.setDefaultPlayers([]);
        // _tshirtProvider.setPlayerSelected();
        if (colorImage) {
          //CONDICIONA QUE DEPENDE DE COLORIMAGE, SINO MOSTRAAR ALERT QUE YA ESTA INSCRITO
          Alert(
            context: context,
            type: AlertType.info,
            title: "You are already REGISTERED",
            // desc: "Flutter is more awesome with RFlutter Alert.",
            buttons: [
              DialogButton(
                color: kBrandThirdColor,
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectTeam(tournoId: tournoModel.idTourno!),
            ),
          );
          _tshirtProvider.setDefaultPlayers([]);
          _tshirtProvider.setPlayerSelected();
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
              color: kBrandSecondaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: kBrandThirdColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "${getNumberMembersFilledTotal(tournoModel.numberTeams)}/${getNumberTeams(tournoModel.numberTeams) * getMembersTeam(tournoModel.membersTeam)}",
                  style: TextStyle(color: kBrandWhite),
                ),
              ),
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Image.network(
                  "https://2.bp.blogspot.com/-xLbrWcFtoeY/XHWU0r1uWYI/AAAAAAAJIoo/WUupXXXuBJk776begM-L-8gGw309JXh4wCLcBGAs/s1600/Football_Player_Silhouette_PNG_Transparent_Clip_Art_Image.png",
                  height: 80,
                  color:
                      colorImage ? kBrandWhite : Colors.grey.withOpacity(0.2),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 90),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        tournoModel.tournamentName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: kBrandWhite),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("💵"),
                        Text(
                          "Price: S/ ${tournoModel.prize} ",
                          style: TextStyle(color: kBrandWhite),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("👨🏼‍🦰"),
                        Expanded(
                          child: Text(
                            "${getNumberTeams(tournoModel.numberTeams)} Teams , ${getMembersTeam(tournoModel.membersTeam)} each",
                            style: TextStyle(color: kBrandWhite),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
