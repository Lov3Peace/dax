// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter_application_1/responsive/desktop/messages/messages.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel.dart';
import 'package:flutter_application_1/responsive/mobile/mob_artboard_page.dart';
import 'package:http/browser_client.dart' as httpClient;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/homeDashboard/events_deck.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/homeDashboard/my_projects_mini_dash.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/homeDashboard/tasks_deck.dart';
import 'package:flutter_application_1/util/animations/scaleFadeIn.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/homeDashboard/communities_deck.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/homeDashboard/profile_card.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/homeDashboard/projects_deck.dart';
import 'package:flutter_application_1/util/providers/locationServicesProvider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';
import 'package:weather/weather.dart';
import '../../../../util/weather_date.dart';

//import 'package:responsive_framework/responsive_framework.dart';

class DesktopDashboard extends StatefulWidget {
  DesktopDashboard({Key? key}) : super(key: key);

  @override
  State<DesktopDashboard> createState() => _DesktopDashboardState();
}

late LocationServicesProvider locationServicesProvider;
final locationEndpoint = Uri.parse("$hostname/api/getLocation/");

class _DesktopDashboardState extends State<DesktopDashboard> {
  @override
  void initState() {
    super.initState();
    locationServicesProvider = context.read<LocationServicesProvider>();
    locationServicesProvider.getWeather();
  }

//globals
  final ScrollController horizontalScrollController = ScrollController();

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
                    child: Scrollbar(
                      thumbVisibility: true,
                      interactive: true,
                      controller: horizontalScrollController,
                      child: SingleChildScrollView(
                        controller: horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            width: 75.w(context),
                            height: 52.w(context),
                            padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 0.5.w(context)),
                            constraints:
                                BoxConstraints(minWidth: 900, minHeight: 950),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        // handles width
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            //
                                            // Weather
                                            Expanded(
                                              // handles height
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(math
                                                    .max(5, 0.25.w(context))),
                                                child: ScaleFadeIn(
                                                  duration: 200,
                                                  delay: 50,
                                                  child: WeatherDate(
                                                    // height: 5.w(context),
                                                    width: double.infinity,
                                                    constraints: BoxConstraints(
                                                      minWidth: 300,
                                                      minHeight: 50,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //
                                            // ProfileCard
                                            Expanded(
                                              // handles height
                                              flex: 8,
                                              child: Padding(
                                                padding: EdgeInsets.all(math
                                                    .max(5, 0.25.w(context))),
                                                child: ScaleFadeIn(
                                                  duration: 200,
                                                  delay: 150,
                                                  child: ProfileCard(
                                                    // height: 20.w(context),
                                                    width: double.infinity,
                                                    constraints: BoxConstraints(
                                                      minWidth: 300,
                                                      minHeight: 375,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //
                                      // ProjectsDeck
                                      Expanded(
                                        // handles width
                                        flex: 4,
                                        child: Column(
                                          children: [
                                            //
                                            // ProjectsDeck
                                            Expanded(
                                              // handles height
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(math
                                                    .max(5, 0.25.w(context))),
                                                child: ScaleFadeIn(
                                                  duration: 200,
                                                  delay: 250,
                                                  child: ProjectsDeck(
                                                    width: double.infinity,
                                                    constraints: BoxConstraints(
                                                      minWidth: 450,
                                                      minHeight: 150,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //
                                            // CommunitiesDeck
                                            Expanded(
                                              // handles height
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(math
                                                    .max(5, 0.25.w(context))),
                                                child: ScaleFadeIn(
                                                  duration: 200,
                                                  delay: 350,
                                                  child: CommunitiesDeck(
                                                    width: double.infinity,
                                                    constraints: BoxConstraints(
                                                      minWidth: 450,
                                                      minHeight: 100,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //
                                            // TasksDeck
                                            Expanded(
                                              // handles height
                                              flex: 2,
                                              child: Padding(
                                                padding: EdgeInsets.all(math
                                                    .max(5, 0.25.w(context))),
                                                child: ScaleFadeIn(
                                                  duration: 200,
                                                  delay: 450,
                                                  child: TasksDeck(
                                                    width: double.infinity,
                                                    constraints: BoxConstraints(
                                                      minWidth: 450,
                                                      minHeight: 250,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //
                                      // EventsDeck
                                      Expanded(
                                        // handles width
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              math.max(5, 0.25.w(context))),
                                          child: ScaleFadeIn(
                                            duration: 200,
                                            delay: 550,
                                            child: EventsDeck(
                                              // handles height
                                              height: double.infinity,
                                              constraints: BoxConstraints(
                                                  minWidth: 500,
                                                  minHeight: 250),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //
                                // MyProjectsMiniDashDeck
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        math.max(5, 0.25.w(context))),
                                    child: ScaleFadeIn(
                                      duration: 200,
                                      delay: 650,
                                      child: MyProjectsMiniDashDeck(
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Messages()
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
