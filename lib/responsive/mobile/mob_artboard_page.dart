import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ArtBoardScreen extends StatefulWidget {
  const ArtBoardScreen({super.key});

  @override
  State<ArtBoardScreen> createState() => _ArtBoardScreenState();
}

//lets run the app
class _ArtBoardScreenState extends State<ArtBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const RiveAnimation.asset(
<<<<<<< HEAD:lib/Screens/background/artboard_page.dart
            "rive/desk_br_anim.riv",
=======
            "rive/mobile_artboard.riv",
>>>>>>> dae183237a939e33b1842327119397b98dbc7a27:lib/responsive/mobile/mob_artboard_page.dart
          ),
          Positioned.fill(
            child: BackdropFilter(
              //Now it looks perfecto...sike no tf it doesn't
              filter: ImageFilter.blur(
                sigmaX: 500,
                sigmaY: 500,
              ),
              child: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
