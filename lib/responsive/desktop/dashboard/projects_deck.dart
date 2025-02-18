import 'package:flutter/material.dart';
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
                  if (100.w < 550) {
                    return MobProjectsPage(transitionAnimation: animation);
                  } else if (100.w < 1100) {
                    return TabProjectsPage(transitionAnimation: animation);
                  } else {
                    return const DeskHeroProjectsPage();
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
      child: projectDeck(),
    );
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
