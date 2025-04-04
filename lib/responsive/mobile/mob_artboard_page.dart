import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
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
          // const RiveAnimation.asset(
          //   "rive/mobile_artboard.riv",
          // ),
          // Image.asset("images/bright-blue-yellow-orbs.jpg"),
          // Image.asset("images/aperture-vintage-GlsKHybjdS0-unsplash.jpg"),
          // Image.asset("images/bright-blue-yellow-orbs.jpg"),
          Image.asset("images/aperture-vintage-3FS0H6gB3uY-unsplash.jpg"),
          Opacity(
            child: Image.asset("images/bright-blue-yellow-orbs.jpg"),
            opacity: 0.7,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 100,
                sigmaY: 100,
              ),
              child: Container(
                  // color: Color.fromARGB(48, 0, 0, 0),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
