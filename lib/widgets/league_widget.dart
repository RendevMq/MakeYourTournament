import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/domain/entities/league_info.dart';
import 'package:s4_integration2/extensions/context_extensions.dart';
import 'package:s4_integration2/presentation/providers/standings_provider.dart';
import 'package:s4_integration2/presentation/screens/league_screen.dart';

class LeagueWidget extends StatelessWidget {
  LeagueInfo league;

  LeagueWidget({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    final _standingProvider = context.watch<StandingProvider>();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeagueScreen(),
          ),
        );
        _standingProvider.loadStandingData(league.season, league.id,
            league.name); //ACA LE PASA EL ID Y EL SEASON
        print(league.season);
        print(league.id);
        print(league.name);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        width: context.width / 2.5,
        // height: ,
        decoration: BoxDecoration(
          color: Color(0xff1B1D36),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Image.network(
              league.iamgeUrl,
              height: context.height / 7,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    league.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kBrandWhite,
                    ),
                  ),
                  Text(
                    "Country: ${league.country}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kBrandWhite,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: SvgPicture.network(
                      league.flag,
                      height: 20,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
