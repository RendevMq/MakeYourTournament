import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:s4_integration2/extensions/context_extensions.dart';
import 'package:s4_integration2/presentation/screens/Info_app_page.dart';
import 'package:s4_integration2/presentation/screens/football_page.dart';
import 'package:s4_integration2/presentation/screens/chat_page.dart';
import 'package:s4_integration2/presentation/screens/profile_page.dart';
import 'package:s4_integration2/presentation/screens/tournament_page.dart';

class BottomNavigationPage extends StatefulWidget {
  int? index;
  BottomNavigationPage({super.key, this.index = 2});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  // int pageIndex = index;
  ColorFilter colorWhite5 = ColorFilter.mode(
    Colors.white.withOpacity(0.5),
    BlendMode.srcIn,
  );
  ColorFilter colorWhite = ColorFilter.mode(
    Colors.white.withOpacity(1),
    BlendMode.srcIn,
  );

  double scale1 = 0.08;
  double scale2 = 0.07;

  @override
  Widget build(BuildContext context) {
    print(context.width);
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(child: pageBuilder(widget.index!)),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: context.width,
              child: Container(
                height: 81,
                margin: context.all(15),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff1F2140),
                      borderRadius: BorderRadius.circular(57),
                    ),
                    padding: context.all(4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => widget.index = 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.index! == 0
                                  ? Color(0xff7057F4)
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            width: 57,
                            height: 57,
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/icons/line_profile.svg",
                                colorFilter:
                                    widget.index! == 0 ? colorWhite : colorWhite5,
                                height: context.width *
                                    (widget.index! == 0 ? scale1 : scale2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => setState(() => widget.index = 1),
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.index! == 1
                                  ? Color(0xff7057F4)
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            width: 57,
                            height: 57,
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/icons/line_cup.svg",
                                colorFilter:
                                    widget.index! == 1 ? colorWhite : colorWhite5,
                                height: context.width *
                                    (widget.index! == 1 ? scale1 : scale2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => setState(() => widget.index = 2),
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.index! == 2
                                  ? Color(0xff7057F4)
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            width: 57,
                            height: 57,
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/icons/line_ball.svg",
                                colorFilter:
                                    widget.index! == 2 ? colorWhite : colorWhite5,
                                height: context.width *
                                    (widget.index! == 2 ? scale1 : scale2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => setState(() => widget.index = 3),
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.index! == 3
                                  ? Color(0xff7057F4)
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            width: 57,
                            height: 57,
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/icons/line_message.svg",
                                colorFilter:
                                    widget.index! == 3 ? colorWhite : colorWhite5,
                                height: context.width *
                                    (widget.index! == 3 ? scale1 : scale1),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => setState(() => widget.index = 4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.index! == 4
                                  ? Color(0xff7057F4)
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            width: 57,
                            height: 57,
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/icons/line_info.svg",
                                colorFilter:
                                    widget.index! == 4 ? colorWhite : colorWhite5,
                                height: context.width *
                                    (widget.index! == 4 ? scale1 : scale2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pageBuilder( int pageIndex) {
    switch (pageIndex) {
      case 0:
        return const ProfilePage();
      case 1:
        return TournamentPage();
      case 2:
        return FootballPage();
      case 3:
        return const ChatPage();
      case 4:
        return const FavouritePage();
      default:
        return Container();
    }
  }
}
