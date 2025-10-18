import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../main.dart';
import '../../../util/tactile_button.dart';
import '../desk_decks.dart';
import 'package:rive/rive.dart' as r;

import '../decks_content/projects/desktop_projects_page.dart';

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
          router.go("/projects");
        },
        child: projectDeck());
  }

  Widget projectDeck({VoidCallback? onTap, Color? color}) {
    // values set in desk_decks.dart
    double deckHeight = 22.sp(context);
    double deckWidth = 35.25.w(context);
    subTextSize = 2.5.sp(context);
    profBubTextSize = 20;
    double labelTextSize = 2.5.sp(context);
    textConstraint = 500;
    subTextConstraint = 500;
    return Deck(
      deckHeight: deckHeight,
      deckWidth: deckWidth,
      deckName: 'Projects',
      gradient1: red,
      gradient2: pink,
      neonGlow: pink,
      labelTextSize: labelTextSize,
      textConstraint: 30.w(context),
      subTextConstraint: 20.w(context),
      headingText: 'Collaborate and innovate.',
      subText:
          'Post, join, or support independent projects anywhere in the world.',
      riveAnim: r.RiveAnimation.asset('rive/building_apartments.riv'),
    );
  }
}
