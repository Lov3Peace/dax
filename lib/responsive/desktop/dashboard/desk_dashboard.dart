// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/events_deck.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/my_projects_mini_dash.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/tasks_deck.dart';
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
import 'package:provider/provider.dart';
import '../../../util/providers/userProvider.dart';
import '../../mobile/mob_artboard_page.dart';
import '../side_panel/side_panel.dart';
import '../messages.dart';
import '../util/go_routes.dart';
import '../util/title_bubble.dart';

//import 'package:responsive_framework/responsive_framework.dart';

class DesktopDashboard extends StatefulWidget {
  const DesktopDashboard({Key? key}) : super(key: key);

  @override
  State<DesktopDashboard> createState() => _DesktopDashboardState();
}

class _DesktopDashboardState extends State<DesktopDashboard> {
  //globals
  final getUserDataEndpoint =
      Uri.parse('https://$hostname/api/getUserDashboardData');
  var _getData;
  var userData;
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
  void initState() {
    super.initState();
    // set it to a private variable to call it in the FutureBuilder
    // so it only returns the value once in the FutureBuilder instead
    // of calling the function DIRECTLY infinite times inside of the Build
    // _getData = getUserDataFetch();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userData = userProvider.userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          Container(
            height: 100.h(context),
            //     .clamp(100.h(context) > 2560 ? 1440 : 700, 100.h(context)),
            width: 100.w(context),
            constraints: 100.w(context) > 2560
                ? BoxConstraints(minHeight: 1440, minWidth: 1400)
                : BoxConstraints(minHeight: 900, minWidth: 1400),
            child: Stack(
              children: [
                // Background(),
                ArtBoardScreen(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DesktopSidePanel(),
                    //
                    // SingleChildScrollView expanded inside the row to allow for horizontal scrolling on screen shrink
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        // interactive: true,
                        controller: horizontalScrollController,
                        child: SingleChildScrollView(
                          controller: horizontalScrollController,
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 1920),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            color: red,
                                            width: 18.w(context),
                                            height: 5.w(context)),
                                        Container(
                                            color: pink,
                                            width: 18.w(context),
                                            height: 40.h(context)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          color: blue,
                                          width: 25.w(context),
                                          height: 10.h(context),
                                          constraints:
                                              BoxConstraints(minHeight: 100),
                                        ),
                                        Container(
                                            color: purp,
                                            width: 25.w(context),
                                            height: 10.h(context)),
                                        Container(
                                            color: orange,
                                            width: 25.w(context),
                                            height: 20.h(context)),
                                      ],
                                    ),
                                    Container(
                                        color: green, width: 300, height: 300),
                                  ],
                                ),
                                Container(
                                    color: white, width: 300, height: 300),
                              ],
                            ),
                          ),
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
