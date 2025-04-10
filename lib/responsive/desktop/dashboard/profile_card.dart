import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:supercharged/supercharged.dart';
import '../../../util/auth/login.dart';
import '../../../util/tactile_button.dart';
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
              barrierLabel: 'Dimiss',
              transitionDuration: Duration(milliseconds: 300),
              barrierColor: Colors.black54, // Dims the background
              pageBuilder: (_, __, ___) => Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Hero(
                    tag: 'profileHeroTag',
                    flightShuttleBuilder: flightShuttleBuilder,
                    child: ProfilePopup(),
                  ),
                ),
              ),
            ),
          );
        },
        child: profileCard(context: context));
  }

  Widget profileCard({VoidCallback? onTap, Color? color, context}) {
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
