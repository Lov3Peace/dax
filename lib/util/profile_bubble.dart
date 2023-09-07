import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class ProfileBubble extends StatelessWidget {
  ProfileBubble({
    required this.deckHeight,
    required this.deckWidth,
    required this.deckName,
    required this.gradient1,
    required this.gradient2,
    required this.neonGlow,
    this.onTap,
    super.key,
  });

  double deckHeight;
  double deckWidth;
  String deckName;
  Color gradient1;
  Color gradient2;
  Color neonGlow;
  VoidCallback? onTap;
  Color shadowColor = Colors.white;
  Color buttonColor = const Color.fromARGB(255, 29, 29, 29);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color.fromARGB(134, 10, 10, 10),
              Color.fromARGB(230, 24, 24, 24),
            ], transform: GradientRotation(180)),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: const Color.fromARGB(147, 36, 36, 36)),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                color: Color.fromARGB(255, 8, 8, 8),
                offset: Offset(0, 0),
              ),
              // BoxShadow(
              //   blurRadius: 10,
              //   color: Color.fromARGB(255, 37, 37, 37),
              //   offset: Offset(0, 0),
              // )
            ]),
        constraints: const BoxConstraints(maxHeight: 600, maxWidth: 1080),
        height: deckHeight,
        width: deckWidth,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [gradient1, gradient2]),
                    boxShadow: [
                      BoxShadow(
                          color: neonGlow,
                          blurRadius: 20,
                          blurStyle: BlurStyle.solid)
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('images/crest5.png', width: 35),
                      Text(
                        deckName,
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
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
                    ],
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
