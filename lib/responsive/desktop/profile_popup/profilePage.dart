import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/desk_profile_popup.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'profileHeroTag',
      flightShuttleBuilder: flightShuttleBuilder,
      child: ProfilePopup(),
    );
  }
}
