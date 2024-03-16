import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/extensions/context_extensions.dart';
import 'package:s4_integration2/presentation/providers/standings_provider.dart';

class RankTeamWidget extends StatelessWidget {
  int index;

  RankTeamWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final double radiousbor = 12;
    final double paddingbor = 5;

    final _standingProvider = context.watch<StandingProvider>();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(paddingbor),
      decoration: BoxDecoration(
        color: Color(0xff1C1D38),
        borderRadius: BorderRadius.circular(radiousbor),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(2, 2),
            color: Colors.black.withOpacity(0.8)
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "${_standingProvider.teamStandingData[index].rank}.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: kBrandWhite),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(paddingbor),
              decoration: BoxDecoration(
                color: Color(0xff17182E),
                borderRadius: BorderRadius.circular(radiousbor),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: context.height * 0.075,
                    width: context.height * 0.075,
                    decoration: BoxDecoration(
                      color: Color(0xff1C1D38),
                      borderRadius: BorderRadius.circular(radiousbor),
                    ),
                    child: Image.network(
                      // "https://media.api-sports.io/football/teams/49.png",
                      "https://media.api-sports.io/football/teams/${_standingProvider.teamStandingData[index].id}.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Point",
                                style: TextStyle(fontWeight: FontWeight.bold,color: kBrandWhite),
                              ),
                              Text(
                                _standingProvider.teamStandingData[index].point.toString(),
                                style: TextStyle(color: Colors.white30),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Won",
                                style: TextStyle(fontWeight: FontWeight.bold,color: kBrandWhite),
                              ),
                              Text(
                                _standingProvider.teamStandingData[index].won.toString(),
                                style: TextStyle(color: Colors.white30),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lost",
                                style: TextStyle(fontWeight: FontWeight.bold,color: kBrandWhite),
                              ),
                              Text(
                                _standingProvider.teamStandingData[index].lost.toString(),
                                style: TextStyle(color: Colors.white30),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Draw",
                                style: TextStyle(fontWeight: FontWeight.bold,color: kBrandWhite),
                              ),
                              Text(
                                _standingProvider.teamStandingData[index].draw.toString(),
                                style: TextStyle(color: Colors.white30),
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
          )
        ],
      ),
    );
  }
}
