import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/firebase_tools/userProvider.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:provider/provider.dart';
import '../../../util/tactile_button.dart';
import '../desk_decks.dart';
import '../profile_popup/desk_profile_popup.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.loadUsername(FirebaseAuth.instance.currentUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    final username = context.watch<UserProvider>().username;
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
        child: profileCard(context: context, username: username));
  }

  Widget profileCard(
      {required String username, VoidCallback? onTap, Color? color, context}) {
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
      headingText: username,
      subText: '',
    );
  }
}
