import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

deskDashboardDecks1({
  required Widget deck1,
  required Widget deck2,
  required Widget deck3,
}) {
  Row(
    children: [deck1, deck2, deck3],
  );
  List decks = [deck1, deck2, deck3];
  return decks;
}

deskDashboardDecks2({
  required Widget deck4,
  required Widget deck5,
}) {
  List decks2 = [deck4, deck5];
  return decks2;
}
