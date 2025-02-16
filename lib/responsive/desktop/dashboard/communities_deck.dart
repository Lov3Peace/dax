import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../../main.dart';
import '../../../util/tactile_button.dart';
import '../../mobile/mobile_finance_page.dart';
import '../../tablet/tablet_finance_page.dart';
import '../desk_constants.dart';
import '../desk_decks.dart';
import '../hero_deck_pages/desk_hero_community_page.dart';

class CommunitiesDeck extends StatefulWidget {
  const CommunitiesDeck({
    super.key,
  });

  @override
  State<CommunitiesDeck> createState() => _CommunitiesDeckState();
}

class _CommunitiesDeckState extends State<CommunitiesDeck> with AnimationMixin {
  @override
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> opacity;
  @override
  void initState() {
    // TODO: implement initState

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    scale = Tween<double>(begin: 1.0, end: 0.9).animate(controller);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    controller.stop();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deckHeight = 22.h;
    deckWidth = 35.25.w;
    halfDeckWidth = 17.325.w;
    labelTextSize = 16;
    return TactileButton(
      onTap: () {
        setState(() {
          controller.play();
          Future.delayed(const Duration(milliseconds: 100)).then((_) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  animation = CurvedAnimation(parent: animation, curve: Curves.linear);
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  if (screenWidth < 550) {
                    return MobFinancePage(
                      transitionAnimation: animation,
                    );
                  } else if (screenWidth < 1100) {
                    return TabFinancePage(
                      transitionAnimation: animation,
                    );
                  } else {
                    return const DeskHeroCommunityPage(
                        //transitionAnimation: animation,
                        );
                  }
                },
                transitionDuration: const Duration(milliseconds: 700),
              ),
            );
          });
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            controller.reset();
          });
        });
      },
      child: communityDeck(),
    );
  }

  Widget communityDeck({VoidCallback? onTap, Color? color}) {
    return GestureDetector(
      child: Deck(
        deckHeight: 22.h,
        deckWidth: halfDeckWidth,
        deckName: 'Communities',
        gradient1: red,
        gradient2: orange,
        neonGlow: red,
        labelTextSize: labelTextSize,
        textConstraint: halfDeckWidth,
        subTextConstraint: halfDeckWidth * 0.6,
        headingText: 'Find your community.',
        subText: "Connect with others and say what's on your mind.",
      ),
    );
  }
}
