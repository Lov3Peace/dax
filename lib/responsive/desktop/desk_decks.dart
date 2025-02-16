import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' as r;
import 'package:sizer/sizer.dart';

// Global variables for all decks. Must be declared here so decks
// can access the values. Also declared in the build so they can
// be responsive.

double deckHeight = 22.h;
double deckWidth = 35.25.w;
double halfDeckWidth = 17.325.w;
double subTextSize = 14;
double profBubTextSize = 20;
double titleTextSize = 20;
double labelTextSize = 16;
double textConstraint = 500;
double subTextConstraint = 500;
Color deckBorderColor = const Color.fromARGB(182, 75, 75, 75);
Color deckColor = const Color.fromARGB(185, 21, 19, 22);

class Deck extends StatefulWidget {
  double deckHeight;
  double deckWidth;
  final String deckName;
  final Color gradient1;
  final Color gradient2;
  final Color neonGlow;
  final String headingText;
  final String subText;
  final double? labelTextSize;
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
    this.labelTextSize,
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
  final Color shadowColor = Colors.white;

  final Color buttonColor = const Color.fromARGB(255, 29, 29, 29);
  double headerTextSize = 5.sp;

  @override
  Widget build(BuildContext context) {
    deckHeight = 22.h;
    deckWidth = 35.25.w;
    halfDeckWidth = 17.325.w;
    headerTextSize = 6.5.sp;
    subTextSize = 2.5.sp;
    profBubTextSize = 20;
    titleTextSize = 20;
    labelTextSize = 16;
    textConstraint = 500;
    subTextConstraint = 500;

    //Responsive if statements for text and constraints
    // if (100.w > 1920 && 100.h > 1080) {
    //   headerTextSize = 82;
    //   subTextSize = 36;
    //   print(100.w);
    //   print(100.h);
    // } else {
    //   headerTextSize = 7.sp;
    //   subTextSize = 3.sp;
    //   print(100.w);
    //   print(100.h);
    // }
    return GestureDetector(
      onTap: widget.onTap,

      // Main Container
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1.5.w),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          color: Colors.transparent,
          height: widget.deckHeight,
          width: widget.deckWidth,
          constraints: const BoxConstraints(minHeight: 750),

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
                  borderRadius: BorderRadius.circular(1.5.w),
                  color: deckColor,
                  border: Border.all(color: deckBorderColor),
                ),
                constraints: const BoxConstraints(minHeight: 500),
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
                      constraints: BoxConstraints(maxWidth: widget.deckWidth * 0.9),
                      margin: EdgeInsets.fromLTRB(2.w, widget.deckHeight * 0.12, 2.w, 0),
                      width: widget.textConstraint,
                      child: Text(
                        widget.headingText,
                        style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: headerTextSize), fontWeight: FontWeight.w600),
                      ),
                    ),
                    // Subheading Text
                    Container(
                      constraints: BoxConstraints(maxWidth: widget.deckWidth * 0.9),
                      margin: EdgeInsets.fromLTRB(2.w, 0.5.w, 2.w, 0),
                      width: widget.subTextConstraint,
                      child: Text(
                        widget.subText,
                        style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: subTextSize), fontWeight: FontWeight.w400),
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
                bottom: widget.deckHeight * 0.1,
                child: Container(
                  constraints: BoxConstraints(maxHeight: widget.deckHeight, maxWidth: widget.deckHeight),
                  margin: EdgeInsets.only(bottom: 5),
                  width: widget.textConstraint,
                  child: widget.riveAnim,
                ),
              ),

              // Colored Deck Label
              Positioned(
                bottom: 0,
                left: 0,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(2.w, 0, 0, 2.w),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 50, maxHeight: 160),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [widget.gradient1, widget.gradient2]),
                      boxShadow: [BoxShadow(color: widget.neonGlow, blurRadius: 17, blurStyle: BlurStyle.solid)],
                      borderRadius: BorderRadius.all(Radius.circular(500)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(2.w, 20, 2.w, 20),
                      child: Text(
                        widget.deckName,
                        style: GoogleFonts.montserrat(
                          fontSize: widget.labelTextSize,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: shadowColor, blurRadius: 1),
                            Shadow(color: shadowColor, blurRadius: 2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
