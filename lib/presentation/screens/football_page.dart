import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/extensions/context_extensions.dart';
import 'package:s4_integration2/presentation/providers/leagues_provider.dart';
import 'package:s4_integration2/presentation/screens/home_page.dart';
import 'package:s4_integration2/shared/preferences/shared_global.dart';
import 'package:s4_integration2/widgets/league_widget.dart';

class FootballPage extends StatelessWidget {
  FootballPage({super.key});

  final SharedGlobal _sharedGlobal = SharedGlobal();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);

  @override
  Widget build(BuildContext context) {
    final _leagueProvider = context.watch<LeagueProvider>();

    return Theme(
      data: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              color: Colors.white), //color del texto a blanco
        ),
      ),
      child: Scaffold(
        backgroundColor: Color(0xff17182E),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white12,
                          radius: 25,
                          backgroundImage: NetworkImage(
                              "https://img.freepik.com/foto-gratis/joven-hombre-guapo-camiseta-informal-sobre-fondo-azul-cara-feliz-sonriendo-brazos-cruzados-mirando-camara-persona-positiva_839833-12963.jpg?size=626&ext=jpg&ga=GA1.1.117944100.1709683200&semt=sph"),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${_sharedGlobal.fullName}",
                          style: GoogleFonts.acme(
                              fontSize: 19, color: kBrandWhite),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        _sharedGlobal.fullName = "-";
                        _sharedGlobal.userUid = "-";
                        _googleSignIn.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false,
                        );
                      },
                      icon: const Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                    ),

                    // Icon(Icons.config)
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "WORLD LIGUES",
                        style: TextStyle(
                            color: kBrandThirdColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _leagueProvider.initialLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Container(
                              height: context.height / 3,
                              child: ListView.builder(
                                itemCount: _leagueProvider.worldLeagues.length,
                                itemBuilder: (context, index) {
                                  print(index);
                                  return LeagueWidget(
                                    league: _leagueProvider.worldLeagues[index],
                                  ); // Reemplaza con tu widget
                                },
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                      const Text(
                        "COUNTRIES LIGUES",
                        style: TextStyle(
                            color: kBrandThirdColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _leagueProvider.initialLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Container(
                              height: context.height / 3,
                              child: ListView.builder(
                                itemCount:
                                    _leagueProvider.countryLeagues.length,
                                itemBuilder: (context, index) {
                                  print(index);
                                  return LeagueWidget(
                                    league:
                                        _leagueProvider.countryLeagues[index],
                                  ); // Reemplaza con tu widget
                                },
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                                                  const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
