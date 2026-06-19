import 'package:flutter_application_1/responsive/desktop/dashboard/projectDashboard/projectDashFeed.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/projectDashboard/projectDashHeadingProgress.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/messages/compactMessages.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/compactSidePanel.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/weather_date.dart';

class DesktopProjectDashboard extends StatefulWidget {
  const DesktopProjectDashboard({super.key});

  @override
  State<DesktopProjectDashboard> createState() =>
      _DesktopProjectDashboardState();
}

class _DesktopProjectDashboardState extends State<DesktopProjectDashboard> {
  @override
  Widget build(BuildContext context) {
    print(50.w(context));
    return WebUiTemplate(
      title: "Projects",
      sidePanel: CompactSidePanel(),
      messages: CompactMessages(),
      button1: CommunitiesButton(),
      button2: SocialsButton(),
      button3: NewsButton(),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Hero(
              tag: "projectDash",
              flightShuttleBuilder: textFlightShuttleBuilder,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    0.w(context), 6.w(context), 0.w(context), 0.w(context)),
                child: BlurryContainer(
                  height: 50.w(context),
                  width: 85.w(context),
                  constraints:
                      const BoxConstraints(minWidth: 1000, minHeight: 700),
                  borderRadius: 1.w(context),
                  color: deckBackgroundColor,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: 50.w(context),
                      constraints:
                          const BoxConstraints(minWidth: 1000, minHeight: 700),
                      padding: EdgeInsets.all(max(20, 1.5.w(context))),
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
                                    child: ProjectDashHeadingProgress()),
                                Expanded(flex: 3, child: SizedBox()),
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
                                            padding: EdgeInsets.fromLTRB(
                                              0,
                                              0.25.w(context),
                                              0.25.w(context),
                                              0.25.w(context),
                                            ),
                                            child: ProjectDashFeed())),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        0.25.w(context),
                                        0.25.w(context),
                                        0.25.w(context),
                                      ),
                                      child: BlurryContainer(
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
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
