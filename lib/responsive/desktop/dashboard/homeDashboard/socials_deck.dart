import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:simple_animations/simple_animations.dart';

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
    double deckHeight = 22.h(context);
    double deckWidth = 35.25.w(context);
    double headingTextSize = 6.25.sp(context);
    double labelTextSize = 2.5.sp(context);
    if (100.w(context) < 1440) {
      // headingTextSize = headingTextSize * 0.9;
    }
    return TactileButton(
      onTap: () {
        router.go("/socials");
      },
      child: Deck(
        deckHeight: deckHeight,
        deckWidth: deckWidth,
        deckName: 'Socials',
        gradient1: orange,
        gradient2: purp,
        neonGlow: orange,
        labelTextSize: labelTextSize,
        headingText: 'All of your socials in one place.',
        headingTextSize: headingTextSize,
        subText:
            'Just link your social media accounts and access them all in one place.',
        // image: Image.asset('images/crest1.png'),
      ),
    );
  }
}
