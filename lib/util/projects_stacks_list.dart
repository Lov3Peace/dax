import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/deck_height_value.dart';
import '../pages/main.dart';
import '../pages/projects_page.dart';
import 'decks.dart';
import 'tag_lists.dart';

class ProjectStacks {
  List<Widget> projectStacks = [
    Hero(
      tag: 'keyboards',
      child: Deck(
        deckHeight: 500,
        deckWidth: 375,
        deckName: 'Keyboards',
        gradient1: purp,
        gradient2: red,
        neonGlow: red,
      ),
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Software Development',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Guitars',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Photography',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Photography',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Photography',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    const SizedBox(height: 150)
  ];
}
