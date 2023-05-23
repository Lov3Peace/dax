import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/deck_height_value.dart';
import '../pages/main.dart';
import '../pages/projects_page.dart';
import 'decks.dart';
import 'tag_lists.dart';

class FinancesStacks {
  List<Widget> financesStacks = [
    Deck(
      deckHeight: 100,
      deckWidth: 375,
      deckName: 'Balance',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    Deck(
      deckHeight: DeckHeight().deckHeight,
      deckWidth: 375,
      deckName: 'Current Investments',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    Deck(
      deckHeight: DeckHeight().deckHeight,
      deckWidth: 375,
      deckName: 'Current Loans',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    const SizedBox(height: 150)
  ];
}
