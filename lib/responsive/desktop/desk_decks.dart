import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/neon_label.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' as r;

// Global variables for all decks. Must be declared here so decks
// can access the values. Also declared in the build so they can
// be responsive.

// double deckHeight = 22.h(context);
// double deckWidth = 35.25.w(context);
// double halfDeckWidth = 17.325.w(context);
// double headerTextSize = 5.sp(context);
double subTextSize = 14;
double profBubTextSize = 20;
// double labelTextSize = 2.sp(context);
double textConstraint = 500;
double subTextConstraint = 500;
Color deckBorderColor = const Color.fromARGB(182, 75, 75, 75);
Color deckColor = const Color.fromARGB(185, 21, 19, 22);

class Deck extends StatefulWidget {
  final double deckHeight;
  final double deckWidth;
  final String deckName;
  final Color gradient1;
  final Color gradient2;
  final Color neonGlow;
  final String headingText;
  final String subText;
  final double labelTextSize;
  final double? textConstraint;
  final double? subTextConstraint;
  final r.RiveAnimation? riveAnim;
  final Image? image;
  final VoidCallback? onTap;

  Deck({
    required this.deckHeight,
    required this.deckWidth,
    required this.deckName,
    required this.gradient1,
    required this.gradient2,
    required this.neonGlow,
    required this.headingText,
    required this.subText,
    required this.labelTextSize,
    this.textConstraint,
    this.image,
    this.onTap,
    this.subTextConstraint,
    this.riveAnim,
    Key? key,
  }) : super(key: key);

  @override
  State<Deck> createState() => _DeckState();
}

class _DeckState extends State<Deck> {
  final Color buttonColor = const Color.fromARGB(255, 29, 29, 29);

  @override
  Widget build(BuildContext context) {
    double headerTextSize = 6.sp(context);
    subTextSize = 2.5.sp(context);
    profBubTextSize = 20;
    textConstraint = 500;
    subTextConstraint = 500;

    return ClipRRect(
      borderRadius: BorderRadius.circular(1.5.w(context)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        color: Colors.transparent,
        height: widget.deckHeight,
        width: widget.deckWidth,
        constraints: const BoxConstraints(minWidth: 250),

        //Blur
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              blendMode: BlendMode.darken,
              child: SizedBox(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.5.w(context)),
                color: deckColor,
                border: Border.all(color: deckBorderColor),
              ),
              constraints: const BoxConstraints(minHeight: 500, minWidth: 700),
            ),

            //Heading and Subheading Text
            Positioned(
              left: 0,
              top: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading Text
                  Container(
                    constraints: BoxConstraints(),
                    margin: EdgeInsets.fromLTRB(2.w(context),
                        widget.deckHeight * 0.12, 2.w(context), 0),
                    width: widget.textConstraint,
                    child: Text(
                      widget.headingText,
                      softWrap: true,
                      style: GoogleFonts.montserrat(
                          height: 1.1,
                          textStyle: TextStyle(fontSize: headerTextSize),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  // Subheading Text
                  Container(
                    constraints: BoxConstraints(),
                    margin: EdgeInsets.fromLTRB(
                        2.w(context), 0.5.sp(context), 2.w(context), 0),
                    width: widget.subTextConstraint,
                    child: Text(
                      widget.subText,
                      softWrap: true,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(fontSize: subTextSize),
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),

            // Image
            Positioned(
              left: widget.deckWidth * 0.5,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(bottom: 0),
                width: widget.textConstraint,
                child: widget.image,
              ),
            ),

            // Rive Animation
            Positioned(
              left: widget.deckWidth * 0.6,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(bottom: 1.h(context)),
                constraints: BoxConstraints(minHeight: 200),
                width: 10.w(context),
                height: 20.h(context),
                child: widget.riveAnim,
              ),
            ),

            // Colored Deck Label
            Positioned(
              bottom: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    2.w(context), 0, 0, widget.deckHeight * 0.25),
                child: NeonLabel(
                  height: 5.h(context),
                  width: 8.w(context),
                  text: widget.deckName,
                  textSize: widget.labelTextSize,
                  gradient1: widget.gradient1,
                  gradient2: widget.gradient2,
                  neonGlow: widget.neonGlow,
                  borderColor: tran,
                  borderRadius: 10.w(context),
                  shadowColor: white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
