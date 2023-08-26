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
            "rive/mobile_artboard.riv",
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
