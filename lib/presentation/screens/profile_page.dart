import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/presentation/providers/category_filter_profile_provider.dart';
import 'package:s4_integration2/presentation/screens/screensProfile/other_profile_page.dart';
import 'package:s4_integration2/presentation/screens/screensProfile/player_profile_page.dart';
import 'package:s4_integration2/presentation/screens/screensProfile/tourno_profile_page.dart';
import 'package:s4_integration2/widgets/filter_chip_profile_widget.dart';
import 'package:s4_integration2/shared/preferences/shared_global.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryFilterProfileProvider>();

    Widget pageFilter() {
      switch (categoryProvider.categorySelected) {
        case "Player":
          return const PlayerProfilePage();
        case "Tournament":
          return const TournoProfilePage();
        case "Other":
          return const OtherProfilePage();
        default:
          return Container();
      }
    }

    return Scaffold(
      backgroundColor: Color(0xff17182E),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _ViewProfileDelegate(),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Color(0xff17182E), // Ajusta el color oscuro aquí
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [pageFilter()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// const _radiusCircleAvatar = 45.0;

const _maxHeaderExtend = 335.0; //335
const _minHeaderExtend = 150.0; //150

const _maxImageSize = 45.0;
const _minImageSize = 25.0;

ColorFilter colorWhite = ColorFilter.mode(
  Colors.white.withOpacity(1),
  BlendMode.srcIn,
);

String categorySelected = "Info";

class _ViewProfileDelegate extends SliverPersistentHeaderDelegate {

  final SharedGlobal _sharedGlobal = SharedGlobal();


  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // final _categoryProvider = context.watch<CategoryFilterProfileProvider>();

    final size = MediaQuery.of(context).size;
    final percent = shrinkOffset / _maxHeaderExtend;
    final currentImageSize =
        (_maxImageSize * (1 - percent)).clamp(_minImageSize, _maxImageSize);
    print(percent);

    final double imageMovement =
        ((size.width * 0.5 - currentImageSize) * (1 - percent))
            .clamp(20, (size.width * 0.5 - currentImageSize));

    final double textMovement = -105 * percent + 135;

    return Container(
      decoration: const BoxDecoration(
        color: kBrandSecondaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: imageMovement,
            child: CircleAvatar(
              backgroundColor: Colors.white12,
              radius: currentImageSize,
              backgroundImage: const NetworkImage(
                "https://img.freepik.com/foto-gratis/joven-hombre-guapo-camiseta-informal-sobre-fondo-azul-cara-feliz-sonriendo-brazos-cruzados-mirando-camara-persona-positiva_839833-12963.jpg?size=626&ext=jpg&ga=GA1.1.117944100.1709683200&semt=sph",
              ),
            ),
          ),
          Positioned(
            top: textMovement,
            left: 0,
            child: Container(
              width: size.width,
              child: Text(
                "${_sharedGlobal.fullName}",
                textAlign: TextAlign.center,
                style: GoogleFonts.acme(fontSize: 22, letterSpacing: 1,color: kBrandWhite),
              ),
            ),
          ),
          Positioned(
            top: 190,
            left: 0,
            child: Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/fill_like.svg",
                        colorFilter: colorWhite,
                        height: size.height * 0.03,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text("Followers",
                          style: TextStyle(fontWeight: FontWeight.bold,color: kBrandWhite)),
                      const Text(
                        "200",
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/fill_cup.svg",
                        colorFilter: colorWhite,
                        height: size.height * 0.03,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("Tournaments",
                          style: TextStyle(fontWeight: FontWeight.bold,color: kBrandWhite)),
                      Text(
                        "15",
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/fill_hands.svg",
                        colorFilter: colorWhite,
                        height: size.height * 0.03,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("Support",
                          style: TextStyle(fontWeight: FontWeight.bold,color: kBrandWhite)),
                      Text(
                        "40",
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 0,
            child: Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilterChipProfileWidget(thisCategory: "Player"),
                  FilterChipProfileWidget(thisCategory: "Tournament"),
                  FilterChipProfileWidget(thisCategory: "Other"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => _maxHeaderExtend;

  @override
  double get minExtent => _minHeaderExtend;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
