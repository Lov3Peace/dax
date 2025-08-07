import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/providers/userProvider.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
  String adminOrUser = '';
  var userData = {};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userData = userProvider.userData;
    var token = JwtDecoder.decode(userData["token"]);
    final bool isAdmin = token["isAdmin"];
    adminOrUser = isAdmin == true ? "Admin" : "User";
    print("Profile Card Rebuilt");
    return TactileButton(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              barrierDismissible: true,
              barrierLabel: 'Dimiss',
              transitionDuration: Duration(milliseconds: 300),
              barrierColor: Colors.black54, // Dims the background
              pageBuilder: (_, __, ___) => Hero(
                tag: 'profileHeroTag',
                flightShuttleBuilder: flightShuttleBuilder,
                child: ProfilePopup(),
              ),
            ),
          );
        },
        child: profileCard(context: context));
  }

  Widget profileCard({VoidCallback? onTap, Color? color, context}) {
    // values set in desk_decks.dart
    double halfDeckWidth = 17.325.w(context);
    subTextSize = 2.5.sp(context);
    profBubTextSize = 20;
    double labelTextSize = 3.sp(context);
    textConstraint = 500;
    subTextConstraint = 500;
    return Deck(
      deckHeight: 22.sp(context),
      deckWidth: halfDeckWidth,
      deckName: '',
      gradient1: tran,
      gradient2: tran,
      neonGlow: tran,
      labelTextSize: labelTextSize,
      textConstraint: halfDeckWidth * 0.8,
      headingText: userData["username"],
      subText: adminOrUser,
    );
  }
}
