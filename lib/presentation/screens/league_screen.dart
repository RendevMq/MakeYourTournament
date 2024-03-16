import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:s4_integration2/extensions/context_extensions.dart';
import 'package:s4_integration2/presentation/providers/standings_provider.dart';
import 'package:s4_integration2/widgets/rankTeamWidget.dart';

List<String> images = [
  "https://tofter.pe/wp-content/uploads/2023/04/ADIDAS_Pelota_Al_Rihla_Pro_Blanco_H57783-4.webp",
  "https://w.forfun.com/fetch/49/491525afc93cce6ec969b2992ca3c53e.jpeg",
  "https://e1.pxfuel.com/desktop-wallpaper/831/89/desktop-wallpaper-football-stadium-football-ground.jpg",
  "https://img.freepik.com/fotos-premium/futbol-linea-tiro-esquina-pelota-estadio_324842-490.jpg",
  "https://cloudfront-us-east-1.images.arcpublishing.com/elespectador/YB7BAYJZFBQNPEKRP4ILGBQ7HI.jpg",
  "https://static.vecteezy.com/system/resources/previews/030/711/682/large_2x/of-a-soccer-stadium-at-night-with-stadium-light-the-stadium-was-made-in-3d-without-using-existing-references-free-photo.jpg",
  "https://c1.wallpaperflare.com/preview/461/62/328/the-ball-stadion-football-the-pitch.jpg",
  "https://images4.alphacoders.com/932/932935.jpg",
  "https://static.vecteezy.com/system/resources/previews/022/653/581/large_2x/soccer-ball-standing-in-the-middle-of-the-soccer-field-under-the-evening-spotlights-generative-ai-free-photo.jpg",
  "https://media.istockphoto.com/id/1405057877/es/foto/silueta-de-personas-en-el-estadio-por-la-noche.jpg?s=612x612&w=0&k=20&c=-MYz_OOlv8oFxoenZQCESAg7gZgQrZp2LimrWFq2zcY="
];

class LeagueScreen extends StatelessWidget {
  LeagueScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _standingProvider = context.watch<StandingProvider>();
    return Scaffold(
      backgroundColor: Color(0xff0C0D1A),
      body: _standingProvider.initialLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: context.height / 2.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          images[Random().nextInt(10)],
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.srcATop,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        //Aplicar filtro morado
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: context.width * 0.8,
                                child: Text(
                                  _standingProvider.leagueName!.toUpperCase(),
                                  style: GoogleFonts.acme(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "${_standingProvider.leagueSeason} - Season",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 20,
                          child: BackButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: context.height / 2.8,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: MediaQuery.of(context)
                        .size
                        .height, // O un valor específico
                    child: ListView.builder(
                      itemCount: _standingProvider.teamStandingData
                          .length, // Cantidad de elementos en la lista
                      itemBuilder: (context, index) {
                        return RankTeamWidget(
                          index: index,
                        ); // Reemplaza con el widget específico que necesitas
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
