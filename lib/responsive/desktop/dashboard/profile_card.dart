import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import 'package:supercharged/supercharged.dart';
import '../../../main.dart';
import '../../../util/auth/login.dart';
import '../../../util/button_state.dart';
import '../../../util/tactile_button.dart';
import '../desk_constants.dart';
import '../desk_decks.dart';
import '../profile_popup/desk_profile_popup.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> with AnimationMixin {
  @override
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> opacity;
  @override
  void initState() {
    // TODO: implement initState
    // responsiveDeck();
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
    // deckHeight = 22.h;
    // deckWidth = 35.25.w;
    // halfDeckWidth = 17.325.w;
    // labelTextSize = 16;

    return TactileButton(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            barrierColor: Colors.black54, // Dims the background
            pageBuilder: (_, __, ___) => Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Hero(
                  tag: ButtonState().profileHeroTag,
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: ProfilePopup(),
                ),
              ),
            ),
          ),
        );
      },
      child: ScaleTransition(
        scale: scale,
        child: AnimatedOpacity(
          opacity: opacity.value,
          duration: const Duration(milliseconds: 300),
          child: profileCard(),
        ),
      ),
    );
  }

  Widget profileCard({VoidCallback? onTap, Color? color}) {
    return Deck(
      deckHeight: 20.h,
      deckWidth: halfDeckWidth,
      deckName: '',
      gradient1: tran,
      gradient2: tran,
      neonGlow: tran,
      labelTextSize: labelTextSize,
      textConstraint: halfDeckWidth * 0.8,
      headingText: auth.currentUser!.email.toString().allBefore('@'),
      subText: '',
    );
  }
}
