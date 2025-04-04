import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../main.dart';
import '../../../util/tactile_button.dart';
import '../../mobile/mobile_socials_page.dart';
import '../../tablet/tablet_socials_page.dart';
import '../desk_constants.dart';
import '../desk_decks.dart';
import '../hero_deck_pages/desk_hero_socials_page.dart';
import 'package:rive/rive.dart' as r;

import 'desk_dashboard.dart';

class SocialsDeck extends StatefulWidget {
  const SocialsDeck({super.key});

  @override
  State<SocialsDeck> createState() => _SocialsDeckState();
}

class _SocialsDeckState extends State<SocialsDeck> with AnimationMixin {
  @override
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      onTap: () {
        Navigator.pushNamed(context, '/socials');
      },
      child: socialsDeck(),
    );
  }

  Widget socialsDeck({VoidCallback? onTap, Color? color}) {
    // values set in desk_decks.dart
    double deckHeight = 22.sp(context);
    double deckWidth = 35.25.w(context);
    double halfDeckWidth = 17.325.w(context);
    double headerTextSize = 6.5.sp(context);
    subTextSize = 2.5.sp(context);
    profBubTextSize = 20;
    double labelTextSize = 3.sp(context);
    textConstraint = 500;
    subTextConstraint = 500;
    return Deck(
      deckHeight: deckHeight,
      deckWidth: deckWidth,
      deckName: 'Socials',
      gradient1: orange,
      gradient2: purp,
      neonGlow: orange,
      labelTextSize: labelTextSize,
      textConstraint: deckWidth * 0.9,
      headingText: 'All of your socials in one place.',
      subText: 'Just link your social media accounts and access them all in one place.',
      subTextConstraint: deckWidth * 0.6,
      riveAnim: const r.RiveAnimation.asset(
        "rive/twitter_rv.riv",
        fit: BoxFit.fitWidth,
      ),
      // image: Image.asset('images/crest1.png'),
    );
  }
}
