import 'package:flutter/material.dart';
import '../pages/main.dart';
import '../pages/projects_page.dart';
import 'decks.dart';

class SocialsStacks {
  List<Widget> socialsStacks = [
    Deck(
      deckHeight: 200,
      deckWidth: 375,
      deckName: 'Instagram',
      gradient1: Colors.orange,
      gradient2: purp,
      neonGlow: Colors.deepOrange,
    ),
    Deck(
      deckHeight: 200,
      deckWidth: 375,
      deckName: 'Twitter',
      gradient1: const Color.fromARGB(255, 31, 154, 255),
      gradient2: const Color.fromARGB(255, 151, 205, 255),
      neonGlow: Colors.blue,
    ),
    Deck(
      deckHeight: 200,
      deckWidth: 375,
      deckName: 'Facebook',
      gradient1: const Color.fromARGB(255, 12, 89, 255),
      gradient2: const Color.fromARGB(255, 151, 205, 255),
      neonGlow: Colors.blue,
    ),
    Deck(
      deckHeight: 200,
      deckWidth: 375,
      deckName: 'TikTok',
      gradient1: const Color.fromARGB(255, 255, 63, 121),
      gradient2: Colors.cyanAccent,
      neonGlow: const Color.fromARGB(255, 255, 91, 140),
    ),
    const SizedBox(height: 150)
  ];
}
