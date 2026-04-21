// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/events_deck.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/my_projects_mini_dash.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/tasks_deck.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/communities_deck.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/profile_card.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/projects_deck.dart';
import 'package:flutter_application_1/responsive/desktop/stagger_load.dart';
import '../../mobile/mob_artboard_page.dart';
import '../side_panel/side_panel.dart';
import '../messages.dart';
import '../util/title_bubble.dart';

//import 'package:responsive_framework/responsive_framework.dart';

class DesktopDashboard extends StatelessWidget {
  DesktopDashboard({Key? key}) : super(key: key);

//globals
  final ScrollController horizontalScrollController = ScrollController();

// Future getUserDataFetch() async {
//   final client = httpClient.BrowserClient()..withCredentials = true;
//   try {
//     var res = await client.get(getUserDataEndpoint, headers: {
//       "Content-Type": "application/json",
//     }).timeout(const Duration(seconds: 5));
//     final body = json.decode(res.body);
//     final resStatus = res.statusCode;
//     print("Get Status: $resStatus");
//     userData = body;
//     return userData;
//   } catch (e) {
//     print("Error: $e");
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          height: 100.h(context),
          //     .clamp(100.h(context) > 2560 ? 1440 : 700, 100.h(context)),
          width: 100.w(context),
          constraints: BoxConstraints(minHeight: 900),
          // constraints: 100.w(context) > 2560
          //     ? BoxConstraints(minHeight: 1440, minWidth: 1200)
          //     : BoxConstraints(minHeight: 900, minWidth: 1200),
          child: Stack(
            children: [
              // Background(),
              ArtBoardScreen(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DesktopSidePanel(),

                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Container(
                            width: 70.w(context),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      TitleBubble(
                                          height: 4.w(context),
                                          deckName: "[Weather]",
                                          constraints: BoxConstraints(
                                              minWidth: 250, minHeight: 75)),
                                      ProfileCard(
                                          height: 21.w(context),
                                          constraints: BoxConstraints(
                                              minWidth: 250, minHeight: 375))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      ProjectsDeck(
                                          constraints: BoxConstraints(
                                              minWidth: 450, minHeight: 100)),
                                      CommunitiesDeck(
                                          constraints: BoxConstraints(
                                              minWidth: 450, minHeight: 100)),
                                      TasksDeck(
                                          constraints: BoxConstraints(
                                              minWidth: 450, minHeight: 250)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: EventsDeck(
                                      constraints: BoxConstraints(
                                          minWidth: 500, minHeight: 450)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  StaggerLoad(
                    widgets: [Messages()],
                    duration: 200,
                    delay: 75,
                    layer: 3,
                    scale: 1.03,
                    scrollDirection: Axis.horizontal,
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
