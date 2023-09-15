import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'desktop/desktop_constants.dart';
import 'dart:ui';

double deckHeight = screenHeight * 0.22;
double deckWidth = screenWidth * 0.45;
double dynDeckWidth = screenWidth * 0.45;
double halfDeckWidth = screenWidth * 0.45;
double headerTextSize = 24;
double subTextSize = 14;
double profBubTextSize = 20;
double titleTextSize = 20;

responsiveMeth() {
  var screenHeight = window.physicalSize.height / window.devicePixelRatio;
  var screenWidth = window.physicalSize.width / window.devicePixelRatio;
  if (screenWidth < 550) {
    deckHeight = screenHeight * 0.22;
    headerTextSize = 24;
    subTextSize = 16;
  } else if (screenWidth < 1000) {
    deckHeight = screenHeight * 0.24;
    headerTextSize = headerTextSize * 2.30;
    subTextSize = 14;
  } else if (screenWidth < 1920) {
    deckHeight = screenHeight * 0.40;
    deckWidth = screenWidth * 0.45;
    halfDeckWidth = screenWidth * 0.30;
    headerTextSize = 70;
    subTextSize = 30;
  } else {
    deckHeight = screenHeight * 0.40;
    deckWidth = screenWidth * 0.45;
    halfDeckWidth = screenWidth * 0.30;
    headerTextSize = 10.sp;
    subTextSize = 30;
  }
}
