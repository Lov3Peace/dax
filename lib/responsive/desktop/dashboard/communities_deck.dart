import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../../main.dart';
import '../../../util/tactile_button.dart';
import '../../mobile/mobile_finance_page.dart';
import '../../tablet/tablet_finance_page.dart';
import '../desk_constants.dart';
import '../desk_decks.dart';
import '../hero_deck_pages/desk_hero_communities_page.dart';
import '../hero_deck_pages/desk_hero_project_page.dart';

class CommunitiesDeck extends StatefulWidget {
  const CommunitiesDeck({
    super.key,
  });

  @override
  State<CommunitiesDeck> createState() => _CommunitiesDeckState();
}

class _CommunitiesDeckState extends State<CommunitiesDeck> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      onTap: () {
        if (100.w > 550) {
          Get.to(() => DeskHeroCommunitiesPage(), routeName: '/projects', duration: Duration(milliseconds: 300));
        }
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
