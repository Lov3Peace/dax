import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../../main.dart';
import '../../../util/tactile_button.dart';
import '../../mobile/mobile_socials_page.dart';
import '../../tablet/tablet_socials_page.dart';
import '../desk_constants.dart';
import '../hero_deck_pages/desk_hero_socials_page.dart';
import 'package:rive/rive.dart' as r;

class SocialsDeck extends StatefulWidget {
  const SocialsDeck({super.key});

  @override
  State<SocialsDeck> createState() => _SocialsDeckState();
}

class _SocialsDeckState extends State<SocialsDeck> with AnimationMixin {
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
    double width = 35.25.w;
    double height = 22.h;
    return Deck(
      deckHeight: height,
      deckWidth: width,
      deckName: 'Socials',
      gradient1: orange,
      gradient2: purp,
      neonGlow: orange,
      labelTextSize: labelTextSize,
      textConstraint: width * 0.9,
      text: Text(
        'All of your socials in one place.',
        style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: headerTextSize, height: 1.0), fontWeight: FontWeight.w600),
      ),
      subText: Text(
        'Just link your social media accounts and access them all in one place.',
        style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: subTextSize, height: 1.25), fontWeight: FontWeight.w400),
      ),
      subTextConstraint: width * 0.6,
      riveAnim: const r.RiveAnimation.asset(
        "rive/twitter_rv.riv",
        fit: BoxFit.fitWidth,
      ),
      // image: Image.asset('images/crest1.png'),
    );
  }
}
