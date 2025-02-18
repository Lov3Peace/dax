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
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
    // values set in desk_decks.dart
    deckHeight = deckHeight;
    deckWidth = deckWidth;
    halfDeckWidth = halfDeckWidth;
    labelTextSize = labelTextSize;
    return GestureDetector(
      child: Deck(
        deckHeight: deckHeight,
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
