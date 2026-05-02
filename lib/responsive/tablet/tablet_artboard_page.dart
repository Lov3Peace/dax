import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:rive/rive.dart';

class TabArtBoardScreen extends StatefulWidget {
  const TabArtBoardScreen({super.key});

  @override
  State<TabArtBoardScreen> createState() => _TabArtBoardScreenState();
}

//lets run the app
class _TabArtBoardScreenState extends State<TabArtBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // const RiveAnimation.asset(
          //   "rive/mobile_artboard.riv",
          // ),
          Positioned.fill(
            child: BackdropFilter(
              //Now it looks perfecto
              filter: ImageFilter.blur(
                sigmaX: 50,
                sigmaY: 50,
              ),
              child: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
