import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';

import '../util/profile_bubble.dart';
import '../util/title_bubble.dart';

var screenHeight = window.physicalSize.height / window.devicePixelRatio;
var screenWidth = window.physicalSize.width / window.devicePixelRatio;

var myAppBar = AppBar(
  backgroundColor: tran,
  shadowColor: tran,
  automaticallyImplyLeading: false,
  leadingWidth: screenWidth * 0.9,
  flexibleSpace: Padding(
    padding: EdgeInsets.fromLTRB(
      screenWidth * 0.035,
      25,
      screenWidth * 0.035,
      0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Hero(
          tag: 'title',
          flightShuttleBuilder: flightShuttleBuilder,
          child: TitleBubble(
            deckHeight: screenHeight * 0.1,
            deckWidth: screenWidth * 0.4,
            deckName: 'Dashboard',
            gradient1: tran,
            gradient2: tran,
            neonGlow: tran,
          ),
        ),
        Hero(
          tag: 'profile',
          flightShuttleBuilder: flightShuttleBuilder,
          child: ProfileBubble(
            deckHeight: screenHeight * 0.1,
            deckWidth: screenWidth * 0.30,
            deckName: 's3rv',
            gradient1: tran,
            gradient2: tran,
            neonGlow: tran,
          ),
        ),
      ],
    ),
  ),
);
