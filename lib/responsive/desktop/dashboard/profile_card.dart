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

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: profileCard());
  }

  Widget profileCard({VoidCallback? onTap, Color? color}) {
    // values set in desk_decks.dart
    deckHeight = deckHeight;
    deckWidth = deckWidth;
    halfDeckWidth = halfDeckWidth;
    labelTextSize = labelTextSize;
    return Deck(
      deckHeight: deckHeight,
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
