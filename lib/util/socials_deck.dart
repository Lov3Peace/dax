import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/main.dart';
import 'decks.dart';

class SocialsDeckTemplate extends StatelessWidget {
  const SocialsDeckTemplate({super.key, this.onTap, this.color});

  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Deck(
        deckHeight: MediaQuery.of(context).size.height * 0.22,
        deckWidth: MediaQuery.of(context).size.width * 0.93,
        deckName: 'Socials',
        gradient1: Colors.orange,
        gradient2: purp,
        neonGlow: Colors.deepOrange,
        onTap: onTap,
        text: Text(
          'All of your socials in one place.',
          style: GoogleFonts.montserrat(
              textStyle: const TextStyle(fontSize: 28, height: 1.0),
              fontWeight: FontWeight.w600),
        ),
        // subText: Text(
        //   'Just link your social media accounts and access them all in one place.',
        //   style: GoogleFonts.montserrat(
        //       textStyle: const TextStyle(fontSize: 12, color: Colors.white60),
        //       fontWeight: FontWeight.w500),
        // ),
      ),
    );
  }
}
