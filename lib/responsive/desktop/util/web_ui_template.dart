// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/communities_deck.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/news_deck.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/profile_card.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/projects_deck.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/socials_deck.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/stagger_load.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../mobile/mob_artboard_page.dart';
import '../dashboard/title_bubble.dart';
import '../desk_sp/desk_side_panel.dart';
import 'package:rive/rive.dart' as r;

import '../messages.dart';

//import 'package:responsive_framework/responsive_framework.dart';

class WebUITemplate extends StatelessWidget {
  const WebUITemplate({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: 100.h(context),
          // width: 100.w(context),
          constraints: 100.w(context) > 1920 ? BoxConstraints(minHeight: 1440) : BoxConstraints(minHeight: 900),
          child: Stack(
            children: [
              // Background(),
              ArtBoardScreen(),

              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DesktopSidePanel(),
                  Container(
                    height: 90.h(context),
                    // width: 71.5.w(context),
                    constraints:
                        100.w(context) > 1920 ? BoxConstraints(minHeight: 1440) : BoxConstraints(minHeight: 900),
                    //
                    // *** Content goes here ***
                    child: Padding(
                        padding: EdgeInsets.all(0.25.w(context)),
                        //
                        // Row for Decks, Stacks, Cards, etc.
                        child: child),
                  ),
                  Container(
                    height: 90.h(context),
                    // width: 71.5.w(context),
                    constraints:
                        100.w(context) > 1920 ? BoxConstraints(minHeight: 1440) : BoxConstraints(minHeight: 900),
                    child: Padding(
                      padding: EdgeInsets.all(0.5.w(context)),
                      child: Messages(),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                ],
              ),

              // Positioned.fill(
              //   child: BackdropFilter(
              //       filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
              //       child:  SizedBox()),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
