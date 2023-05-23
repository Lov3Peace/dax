import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/main.dart';
import '../pages/projects_page.dart';
import 'decks.dart';

class ProjectsDeck extends StatelessWidget {
  ProjectsDeck({super.key, this.onTap, this.color});

  VoidCallback? onTap;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Deck(
        deckHeight: MediaQuery.of(context).size.height * 0.22,
        deckWidth: MediaQuery.of(context).size.width * 0.93,
        deckName: 'Projects',
        gradient1: red,
        gradient2: purp,
        neonGlow: red,
        text: Text(
          'Collaborate and innovate.',
          style: GoogleFonts.montserrat(
              textStyle: const TextStyle(fontSize: 32, height: 1.0),
              fontWeight: FontWeight.w600),
        ),
        // subText: Text(
        //   'Post, join, or support independent projects anywhere in the world.',
        //   style: GoogleFonts.montserrat(
        //       textStyle: const TextStyle(fontSize: 12, color: Colors.white60),
        //       fontWeight: FontWeight.w500),
        // ),
      ),
    );
  }
}
