import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/presentation/providers/teams_provider.dart';
import 'package:s4_integration2/presentation/providers/tshirtProvider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PlayerShirt extends StatelessWidget {
  final List<int> listIndex1and2;
  final bool isSelected;

  PlayerShirt(
      {Key? key, required this.listIndex1and2, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tshirtProvider = context.watch<TshirtProvier>();
    final _teamProvider = context.watch<TeamsProvider>();

    return GestureDetector(
      onTap: () {
        if (_teamProvider.teamIndex != null) {
          print(listIndex1and2);
          _tshirtProvider.selectPlayer(listIndex1and2);
        } else {
          //INVOCAMOS ALERT QUE DIGA SELECCIONAR UN EQUIPO PRIMERO
          print("");
          Alert(
            context: context,
            type: AlertType.info,
            title: "Select a team first",
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
        }
      },
      child: SvgPicture.asset(
        "assets/images/jersey.svg",
        colorFilter: ColorFilter.mode(
          Color.fromARGB(255, 32, 94, 138).withOpacity(isSelected ? 0 : 0.6),
          BlendMode.srcATop,
        ),
        height: 30,
      ),
    );
  }
}
