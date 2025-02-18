import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/bubble_deck_pages/desk_project_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../../main.dart';
import '../../../util/tactile_button.dart';
import '../../mobile/mobile_projects_page.dart';
import '../../tablet/tablet_projects_page.dart';
import '../desk_decks.dart';
import '../hero_deck_pages/desk_hero_project_page.dart';
import 'package:rive/rive.dart' as r;
import 'package:get/get.dart';

class ProjectsDeck extends StatefulWidget {
  const ProjectsDeck({Key? key}) : super(key: key);

  @override
  _ProjectsDeckState createState() => _ProjectsDeckState();
}

class _ProjectsDeckState extends State<ProjectsDeck> with AnimationMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TactileButton(
        onTap: () {
          if (100.w > 550) {
            Get.to(DeskHeroProjectsPage(), routeName: '/projects', duration: Duration(milliseconds: 300));
          }
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
