import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s4_integration2/presentation/bottomNavigation/navigation_page.dart';
import 'package:s4_integration2/presentation/providers/category_filter_profile_provider.dart';
import 'package:s4_integration2/presentation/providers/leagues_provider.dart';
import 'package:s4_integration2/presentation/providers/standings_provider.dart';
import 'package:s4_integration2/presentation/providers/teams_provider.dart';
import 'package:s4_integration2/presentation/providers/tshirtProvider.dart';
import 'package:s4_integration2/presentation/screens/home_page.dart';
import 'package:s4_integration2/shared/preferences/shared_global.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  final SharedGlobal _sharedGlobal = SharedGlobal();

  WidgetsFlutterBinding
      .ensureInitialized(); //Sirve para que firebase pueda usaar codigo nativo

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedGlobal preferences = SharedGlobal();
  preferences.initSharedPreference();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedGlobal _sharedGlobal = SharedGlobal();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryFilterProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LeagueProvider()
            ..loadWorldData()
            ..loadCountryData(),
        ),
        ChangeNotifierProvider(
          create: (_) => StandingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TshirtProvier(),
        ),
        ChangeNotifierProvider(
          create: (_) => TeamsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Practice Formation",
        theme: ThemeData(
          textTheme: GoogleFonts.manropeTextTheme(
              // bodyColor: Colors.white, // Establecer el color del texto a blanco
              ),
        ),
        home: (_sharedGlobal.fullName == "-" && _sharedGlobal.userUid == "-")
            ? HomePage()
            : BottomNavigationPage(),
      ),
    );
  }
}
