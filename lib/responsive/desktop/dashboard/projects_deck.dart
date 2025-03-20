import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../main.dart';
import '../../../util/tactile_button.dart';
import '../desk_decks.dart';
import 'package:rive/rive.dart' as r;

import '../hero_deck_pages/desk_hero_project_page.dart';

class ProjectsDeck extends StatefulWidget {
  const ProjectsDeck({Key? key}) : super(key: key);

  @override
  State<ProjectsDeck> createState() => _ProjectsDeckState();
}

class _ProjectsDeckState extends State<ProjectsDeck> {
  @override
  Widget build(BuildContext context) {
    return TactileButton(
        onTap: () {
          Navigator.pushNamed(context, '/projects');
        },
        child: projectDeck());
  }

  Widget projectDeck({VoidCallback? onTap, Color? color}) {
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
