import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/constants.dart';

dashboardDecks(proj, socs, fins, news) {
  List<Widget> dashboardDecksList = [
    proj,
    socs,
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        fins,
        news,
      ],
    ),
  ];
}
