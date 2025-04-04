import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../main.dart';
import 'decks.dart';

class NewsDeck extends StatelessWidget {
  NewsDeck({super.key, this.onTap, this.color});

  VoidCallback? onTap;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Deck(
        deckHeight: MediaQuery.of(context).size.height * 0.22,
        deckWidth: MediaQuery.of(context).size.width * 0.45,
        deckName: 'News',
        gradient1: const Color.fromARGB(255, 59, 193, 255),
        gradient2: purp,
        neonGlow: const Color.fromARGB(255, 59, 193, 255),
        onTap: onTap,
      ),
    );
  }
}
