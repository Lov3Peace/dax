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

class WebUiTemplate extends StatelessWidget {
  const WebUiTemplate({Key? key, required this.child}) : super(key: key);
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
          width: 100.w(context),
          constraints: 100.w(context) > 1920 ? BoxConstraints(minHeight: 1440) : BoxConstraints(minHeight: 900),
          child: Stack(
            children: [
              // Background(),
              ArtBoardScreen(),

              Padding(
                padding: EdgeInsets.only(right: 0.75.w(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DesktopSidePanel(),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h(context)),
                      child: Container(
                        height: 100.h(context),
                        width: 71.5.w(context),
                        constraints:
                            100.w(context) > 1920 ? BoxConstraints(minHeight: 1440) : BoxConstraints(minHeight: 900),
                        //
                        // *** Content goes here ***
                        child: child,
                      ),
                    ),
                    Container(
                      height: 90.h(context),
                      constraints:
                          100.w(context) > 1920 ? BoxConstraints(minHeight: 1440) : BoxConstraints(minHeight: 900),
                      child: Messages(),
                    ),
                    // ignore: prefer_const_constructors
                  ],
                ),
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
