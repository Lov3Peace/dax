import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
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
    deckHeight = 22.sp;
    deckWidth = 35.25.w;
    halfDeckWidth = 17.325.w;
    labelTextSize = 16;
    return TactileButton(
      onTap: () {
        setState(() {
          // controller.play();s
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
                    return MobSocialsPage(
                      transitionAnimation: animation,
                    );
                  } else if (screenWidth < 1100) {
                    return TabSocialsPage(
                      transitionAnimation: animation,
                    );
                  } else {
                    // ignore: prefer_const_constructors
                    return DeskHeroSocialsPage(
                        //transitionAnimation: animation,
                        );
                  }
                },
                transitionDuration: const Duration(milliseconds: 1000),
              ),
            );
          });
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            controller.reset();
          });
        });
      },
      child: socialsDeck(),
    );
  }

  Widget socialsDeck({
    VoidCallback? onTap,
    Color? color,
  }) {
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
