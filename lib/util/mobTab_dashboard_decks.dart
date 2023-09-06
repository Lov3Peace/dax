import 'package:flutter/material.dart';

mobTabDashboardDecks(proj, socs, fins, news) {
  List decks = [
    proj,
    socs,
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [fins, news],
    )
  ];
  return decks;
}
