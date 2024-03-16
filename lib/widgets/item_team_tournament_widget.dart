import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/config/helpers/convert_functions.dart';
import 'package:s4_integration2/data/models/config_tourno_model.dart';
import 'package:s4_integration2/presentation/providers/teams_provider.dart';
import 'package:s4_integration2/presentation/providers/tshirtProvider.dart';

class ItemTeamTournamentWidget extends StatelessWidget {
  ConfigTournoModel tournoModel;
  int index;
  bool isSelected;

  ItemTeamTournamentWidget({
    super.key,
    required this.tournoModel,
    required this.index,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final _teamProvider = context.watch<TeamsProvider>();
    final _tshirtProvider = context.watch<TshirtProvier>();

    return InkWell(
      onTap: () {
        _teamProvider.updateTeamIndex(index);
        _tshirtProvider.playerSelected = [100, 100];
        _tshirtProvider.setDefaultPlayers([]);
        _tshirtProvider.setDefaultPlayers(
            getMembersTeamFilled(tournoModel.numberTeams, index));
        // print(getMembersTeamFilled(tournoModel.numberTeams, index));
        // print(tournoModel.numberTeams);
        // print(_teamProvider.teamIndex);
        _tshirtProvider.setIndexTeam(index);
      },
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.only(
          // top: 5,
          bottom: 14,
          left: 30,
          right: 30,
        ),
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected
              ? kBrandThirdColor
              : kBrandSecondaryColor.withOpacity(0.8),
          // color: kBrandThirdColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kBrandSixthColor,
                      ),
                      child: Center(
                        child: Text(
                          "TEAM ${index + 1}",
                          style:
                              TextStyle(color: kBrandWhite, letterSpacing: 4),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.double_arrow_sharp,
                      color: kBrandWhite,
                      size: 30,
                    ),
                    Row(
                      children: [
                        Container(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Center(
                            child: Text(
                              "${getNumberTeamFilled(tournoModel.numberTeams, index) + (isSelected ? 1 : 0)}",
                              style: TextStyle(
                                  color: kBrandWhite, letterSpacing: 4),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kBrandSixthColor,
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Center(
                            child: Text(
                              "/",
                              style: TextStyle(
                                  color: kBrandWhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kBrandSixthColor,
                          ),
                          child: Center(
                            child: Text(
                              "${getMembersTeam(tournoModel.membersTeam)}",
                              style: const TextStyle(
                                  color: kBrandWhite, letterSpacing: 4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
