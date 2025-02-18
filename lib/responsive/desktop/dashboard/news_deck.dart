import 'package:flutter/material.dart';
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

class _NewsDeckState extends State<NewsDeck> with AnimationMixin {
  @override
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> opacity;
  @override
  void initState() {
    // TODO: implement initState

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    scale = Tween<double>(begin: 1.0, end: 0.9).animate(controller);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    controller.stop();

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
                  if (screenWidth < 550) {
                    return MobNewsPage(
                      transitionAnimation: animation,
                    );
                  } else if (screenWidth < 1100) {
                    return TabNewsPage(
                      transitionAnimation: animation,
                    );
                  } else {
                    return const DeskHeroNewsPage(
                        //transitionAnimation: animation,
                        );
                  }
                },
                transitionDuration: const Duration(milliseconds: 700),
              ),
            );
          });
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            controller.reset();
          });
        });
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
