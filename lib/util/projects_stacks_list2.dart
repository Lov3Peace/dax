import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/tag_lists.dart';
import '../main.dart';
import 'deck_height_value.dart';
import 'decks.dart';

class ProjectStacks2 {
  List<Widget> projectStacks2 = [
    Deck(
      deckHeight: DeckHeight().deckHeight,
      deckWidth: 500,
      deckName: 'Audio',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: DeckHeight().deckHeight,
      deckWidth: 500,
      deckName: 'Film',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Hero(
      tag: TagLists().group1Tags[2],
      flightShuttleBuilder: flightShuttleBuilder,
      child: Deck(
        deckHeight: DeckHeight().deckHeight,
        deckWidth: 500,
        deckName: 'Knives',
        gradient1: purp,
        gradient2: red,
        neonGlow: red,
      ),
    ),
  ];
}
