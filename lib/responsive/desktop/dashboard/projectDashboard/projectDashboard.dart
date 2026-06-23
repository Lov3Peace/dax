import 'package:flutter_application_1/responsive/desktop/dashboard/projectDashboard/projectDashFeed.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/projectDashboard/projectDashHeadingProgress.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/messages/compactMessages.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/compactSidePanel.dart';
import 'package:flutter_application_1/responsive/desktop/util/bubble_dock.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/responsive/mobile/mob_artboard_page.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/weather_date.dart';

class DesktopProjectDashboard extends StatefulWidget {
  const DesktopProjectDashboard({super.key});

  @override
  State<DesktopProjectDashboard> createState() =>
      _DesktopProjectDashboardState();
}

ScrollController horizontalScrollController = ScrollController();

class _DesktopProjectDashboardState extends State<DesktopProjectDashboard> {
  @override
  Widget build(BuildContext context) {
    print(45.w(context));
    print(100.h(context));
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          height: 100.h(context),
          width: 100.w(context),
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
                  CompactSidePanel(),
                  //
                  // Content
                  Expanded(
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
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
                                      BlurryContainer(
                                        height: 4.w(context),
                                        width: 17.25.w(context),
                                        borderRadius: 50.w(context),
                                        color: deckBackgroundColor,
                                        child: Center(
                                          child: WeatherDate(
                                            constraints: 100.w(context) >= 2560
                                                ? const BoxConstraints(
                                                    minHeight: 100,
                                                    maxHeight: 300)
                                                : const BoxConstraints(
                                                    minHeight: 70,
                                                    maxHeight: 200),
                                            // height: 50,
                                          ),
                                        ),
                                      ),

                                      //
                                      //Houses Deck Buttons
                                      BubbleDock(
                                          child1: CommunitiesButton(),
                                          child2: SizedBox(),
                                          child3: SizedBox()),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Scrollbar(
                              thumbVisibility: true,
                              interactive: true,
                              controller: horizontalScrollController,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                controller: horizontalScrollController,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Center(
                                    child: Hero(
                                        tag: "projectDash",
                                        flightShuttleBuilder:
                                            textFlightShuttleBuilder,
                                        child: BlurryContainer(
                                          height: 45.w(context),
                                          // CompactSidePanel and CompactMessages are 6.25.w wide each
                                          width: 85.25.w(context),
                                          constraints: const BoxConstraints(
                                              minWidth: 1000, minHeight: 700),
                                          borderRadius: 1.w(context),
                                          color: deckBackgroundColor,
                                          child: Container(
                                            height: 50.w(context),
                                            constraints: const BoxConstraints(
                                                minWidth: 1000, minHeight: 700),
                                            padding: EdgeInsets.all(
                                                max(20, 1.5.w(context))),
                                            //
                                            // Progress Heading and Upcoming Events
                                            child: Column(
                                              children: [
                                                const Expanded(
                                                  flex: 1,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 2,
                                                          child:
                                                              ProjectDashHeadingProgress()),
                                                      Expanded(
                                                          flex: 3,
                                                          child: SizedBox()),
                                                    ],
                                                  ),
                                                ),
                                                //
                                                Expanded(
                                                  flex: 3,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          //
                                                          // Feed and Graph Column
                                                          child: Column(
                                                        children: [
                                                          Expanded(
                                                              child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .fromLTRB(
                                                                    0,
                                                                    0.25.w(
                                                                        context),
                                                                    0.25.w(
                                                                        context),
                                                                    0.25.w(
                                                                        context),
                                                                  ),
                                                                  child:
                                                                      ProjectDashFeed())),
                                                          Expanded(
                                                              child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                              0,
                                                              0.25.w(context),
                                                              0.25.w(context),
                                                              0.25.w(context),
                                                            ),
                                                            child:
                                                                BlurryContainer(
                                                              color: tran,
                                                              child: SizedBox(),
                                                            ),
                                                          ))
                                                        ],
                                                      )),
                                                      //
                                                      // Team, Current Workload, and Task Progress Column
                                                      Expanded(child: Column())
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  //
                  // Messages
                  CompactMessages(),
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
