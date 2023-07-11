import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/mobile/mob_constants.dart';

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
