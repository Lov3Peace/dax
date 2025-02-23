import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../util/tactile_button.dart';
import '../desk_decks.dart';
import 'package:rive/rive.dart' as r;

class ProjectsDeck extends StatelessWidget {
  const ProjectsDeck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TactileButton(
        onTap: () {
          // if (100.w > 550) {
          //   Get.to(() => DeskHeroProjectsPage(), routeName: '/projects', duration: Duration(milliseconds: 300));
          // }
        },
        child: projectDeck());
  }

  Widget projectDeck({VoidCallback? onTap, Color? color}) {
    // values set in desk_decks.dart
    deckHeight = deckHeight;
    deckWidth = deckWidth;
    halfDeckWidth = halfDeckWidth;
    labelTextSize = labelTextSize;
    return Deck(
      deckHeight: deckHeight,
      deckWidth: deckWidth,
      deckName: 'Projects',
      gradient1: red,
      gradient2: pink,
      neonGlow: red,
      labelTextSize: labelTextSize,
      textConstraint: deckWidth * 0.7,
      subTextConstraint: deckWidth * 0.6,
      headingText: 'Collaborate and innovate.',
      subText: 'Post, join, or support independent projects anywhere in the world.',
      riveAnim: const r.RiveAnimation.asset('rive/building_apartments.riv'),
    );
  }
}
