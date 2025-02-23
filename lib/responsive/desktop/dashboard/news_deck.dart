import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../../main.dart';
import '../../../util/tactile_button.dart';
import '../../mobile/mobile_news_page.dart';
import '../../tablet/tablet_news_page.dart';
import '../desk_decks.dart';
import '../desk_constants.dart';
import '../hero_deck_pages/desk_hero_news_page.dart';
import './desk_dashboard.dart';

class NewsDeck extends StatefulWidget {
  const NewsDeck({
    super.key,
  });

  @override
  State<NewsDeck> createState() => _NewsDeckState();
}

class _NewsDeckState extends State<NewsDeck> {
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
          Get.to(() => DeskHeroNewsPage(), routeName: '/projects', duration: Duration(milliseconds: 300));
        }
      },
      child: newsDeck(),
    );
  }

  Widget newsDeck({VoidCallback? onTap, Color? color}) {
    // values set in desk_decks.dart
    deckHeight = deckHeight;
    deckWidth = deckWidth;
    halfDeckWidth = halfDeckWidth;
    labelTextSize = labelTextSize;
    return GestureDetector(
      child: Deck(
        deckHeight: deckHeight,
        deckWidth: deckWidth,
        deckName: 'News',
        gradient1: blue,
        gradient2: purp,
        neonGlow: blue,
        labelTextSize: labelTextSize,
        textConstraint: deckWidth * 0.7,
        subTextConstraint: deckWidth * 0.7,
        headingText: 'Stay up to date.',
        subText: 'Add your preferred news source to get news updates to your feed.',
      ),
    );
  }
}
