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
import '../desk_sp/desk_side_panel.dart';
import 'package:rive/rive.dart' as r;

import '../messages.dart';
import 'title_bubble.dart';

//import 'package:responsive_framework/responsive_framework.dart';

class DesktopDashboard extends StatefulWidget {
  const DesktopDashboard({Key? key}) : super(key: key);

  @override
  State<DesktopDashboard> createState() => _DesktopDashboardState();
}

class _DesktopDashboardState extends State<DesktopDashboard> {
  //globals
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // final heroReset = context.read<ButtonState>();
    // heroReset.heroReset();
  }

  @override
  Widget build(BuildContext context) {
    double deckHeight = 22.sp(context);
    double deckWidth = 35.25.w(context);
    double halfDeckWidth = 17.325.w(context);
    double headerTextSize = 6.5.sp(context);
    subTextSize = 2.5.sp(context);
    profBubTextSize = 20;
    double labelTextSize = 3.sp(context);
    textConstraint = 500;
    subTextConstraint = 500;
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
                children: [
                  DesktopSidePanel(),
                  Container(
                    height: 90.h(context),
                    // width: 71.5.w(context),
                    constraints: 100.w(context) > 1920 ? BoxConstraints(minHeight: 1440) : BoxConstraints(minHeight: 900),
                    //
                    // Row for Decks + Messages
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.25.w(context)),
                          child: Column(
                            children: [
                              //
                              // Row for Title, Profile, Projects, and Communities Decks
                              Expanded(
                                child: Row(
                                  children: [
                                    //
                                    // Stagger Load Animation
                                    StaggerLoad(
                                        layer: 1,
                                        scale: 1.03,
                                        scrollDirection: Axis.horizontal,
                                        duration: 200,
                                        delay: 75,
                                        padding: EdgeInsets.all(0.25.w(context)),
                                        widgets: [
                                          //
                                          //Column of Title Bubble and Profile Card
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 0.25.w(context)),
                                                child: TitleBubble(
                                                  deckHeight: 3.sp(context),
                                                  deckName: 'Dashboard',
                                                  deckWidth: halfDeckWidth,
                                                  textSize: 4.sp(context),
                                                  leftPad: 4.sp(context),
                                                ),
                                              ),
                                              Expanded(child: ProfileCard()),
                                            ],
                                          ),
                                          ProjectsDeck(),
                                          CommunitiesDeck(),
                                        ]),
                                  ],
                                ),
                              ),
                              //
                              // Row for Socials and News Decks
                              Expanded(
                                child: Row(
                                  children: [
                                    StaggerLoad(
                                        layer: 2,
                                        scale: 1.03,
                                        scrollDirection: Axis.horizontal,
                                        duration: 200,
                                        delay: 75,
                                        padding: EdgeInsets.all(0.25.w(context)),
                                        widgets: [
                                          SocialsDeck(),
                                          NewsDeck(),
                                        ]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // // ignore: prefer_const_constructors
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.25.w(context)),
                          child: StaggerLoad(
                            widgets: [Messages()],
                            duration: 200,
                            delay: 75,
                            layer: 3,
                            scale: 1.03,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ],
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

  @override
  void dispose() {
    super.dispose();
  }
}
