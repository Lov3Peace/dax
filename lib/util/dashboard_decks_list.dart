import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/finances_deck_link.dart';
import 'package:flutter_application_1/util/finances_deck_template.dart';
import 'package:flutter_application_1/util/news_deck_link.dart';
import 'package:flutter_application_1/util/news_deck_template.dart';
import 'package:flutter_application_1/util/projects_deck_link.dart';
import 'package:flutter_application_1/util/projects_deck_template.dart';
import 'package:flutter_application_1/util/socials_deck_link.dart';
import 'package:flutter_application_1/util/socials_deck_template.dart';
import 'decks.dart';

class DashboardDecks {
  List<Widget> dashboardDecks = [
    const ProjectsDeckLink(),
    const SocialsDeckLink(),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const FinancesDeckLink(),
        const NewsDeckLink(),
      ],
    ),
  ];
}
