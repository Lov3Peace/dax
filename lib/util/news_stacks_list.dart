import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/deck_height_value.dart';
import '../pages/main.dart';
import '../pages/projects_page.dart';
import 'decks.dart';
import 'tag_lists.dart';

class NewsStacks {
  List<Widget> newsStacks = [
    Deck(
      deckHeight: 225,
      deckWidth: 375,
      deckName: 'Trending',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    Deck(
      deckHeight: 225,
      deckWidth: 375,
      deckName: 'Local News',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    Deck(
      deckHeight: 225,
      deckWidth: 375,
      deckName: 'World News',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    Deck(
      deckHeight: 225,
      deckWidth: 375,
      deckName: 'Economic News',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    const SizedBox(height: 150)
  ];
}
