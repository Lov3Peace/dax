// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/bubble_dock.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../mobile/mob_artboard_page.dart';
import 'title_bubble.dart';
import '../side_panel/side_panel.dart';

import '../messages.dart';

//import 'package:responsive_framework/responsive_framework.dart';

class WebUiTemplate extends StatelessWidget {
  const WebUiTemplate(
      {Key? key,
      required this.child,
      required this.title,
      required this.button1,
      required this.button2,
      required this.button3})
      : super(key: key);
  final Widget child;
  final String title;
  final Widget button1;
  final Widget button2;
  final Widget button3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          height: 100.h(context),
          width: 100.w(context),
          constraints: 100.w(context) > 2560
              ? BoxConstraints(minHeight: 1440)
              : BoxConstraints(minHeight: 900),
          child: Stack(
            children: [
              // Background(),
              ArtBoardScreen(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  // Side Panel
                  DesktopSidePanel(),
                  //
                  // Content
                  Expanded(
                    child: Stack(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          ShaderMask(
                            shaderCallback: (Rect rect) {
                              return const LinearGradient(
                                // transform: GradientRotation(pi / 180),
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [tran, Colors.grey, white],
                                stops: [0.05, 0.12, 0.15],
                              ).createShader(rect);
                            },
                            //
                            // *** Content goes here ***
                            child: child,
                          ),
                          Row(
                            children: [
                              Expanded(
                                // Uniform 0.5.w padding on Row and LargeStagger items (wanted it on the parent but couldnt because of
                                // the padding on the LargeStagger list items)
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0.5.w(context),
                                      1.w(context),
                                      0.5.w(context),
                                      0.5.w(context)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //
                                      // Title of Screen
                                      TitleBubble(
                                        deckName: "[Weather]",
                                        height: 5.w(context),
                                        width: 17.25.w(context),
                                        constraints: BoxConstraints(
                                            minWidth: 250, minHeight: 50),
                                        // height: 50,
                                      ),

                                      //
                                      //Houses Deck Buttons
                                      BubbleDock(
                                          child1: button1,
                                          child2: button2,
                                          child3: button3),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  //
                  // Messages
                  Messages(),
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
