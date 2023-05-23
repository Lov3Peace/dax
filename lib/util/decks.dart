import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/main.dart';

class Deck extends StatelessWidget {
  Deck({
    required this.deckHeight,
    required this.deckWidth,
    required this.deckName,
    required this.gradient1,
    required this.gradient2,
    required this.neonGlow,
    this.text,
    this.subText,
    this.onTap,
    super.key,
  });

  double deckHeight;
  double deckWidth;
  String deckName;
  Color gradient1;
  Color gradient2;
  Color neonGlow;
  Text? text;
  Text? subText;
  VoidCallback? onTap;
  Color shadowColor = Colors.white;
  Color buttonColor = const Color.fromARGB(255, 29, 29, 29);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color.fromARGB(164, 0, 0, 0),
            Color.fromARGB(59, 15, 15, 15),
          ], transform: GradientRotation(180)),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color.fromARGB(149, 41, 41, 41)),
          boxShadow: const [
            // BoxShadow(
            //   blurRadius: 5,
            //   color: Color.fromARGB(255, 14, 14, 14),
            //   offset: Offset(5, 5),
            // ),
            //   BoxShadow(
            //     blurRadius: 10,
            //     color: Color.fromARGB(255, 37, 37, 37),
            //     offset: Offset(-5, -5),
            //   )
          ],
        ),
        constraints: const BoxConstraints(maxHeight: 600, maxWidth: 1080),
        height: deckHeight,
        width: deckWidth,
        child: Stack(
          children: [
            //
            // Description text
            //
            Positioned(
              left: 25,
              top: 20,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: 270,
                      child: text),
                  Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: 270,
                      child: subText)
                ],
              ),
            ),

            // Card label
            //
            Positioned(
              bottom: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 25),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [gradient1, gradient2]),
                      boxShadow: [
                        BoxShadow(
                            color: neonGlow,
                            blurRadius: 20,
                            blurStyle: BlurStyle.solid)
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      deckName,
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: shadowColor,
                              blurRadius: 1,
                            ),
                            Shadow(
                              color: shadowColor,
                              blurRadius: 2,
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
