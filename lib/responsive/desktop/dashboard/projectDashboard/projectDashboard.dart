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
    return WebUiTemplate(
      title: "Projects",
      sidePanel: CompactSidePanel(),
      messages: CompactMessages(),
      button1: CommunitiesButton(),
      button2: SocialsButton(),
      button3: NewsButton(),
      child: Center(
        child: Hero(
            tag: "projectDash",
            flightShuttleBuilder: textFlightShuttleBuilder,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 7.5.w(context), 20, 20),
              child: BlurryContainer(
                height: 50.w(context),
                width: 90.w(context),
                constraints: BoxConstraints(minWidth: 1000, minHeight: 450),
                padding: EdgeInsets.all(max(20, 1.5.w(context))),
                borderRadius: 1.5.w(context),
                color: deckBackgroundColor,
                child: const SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: ProjectDashHeadingProgress()),
                      Expanded(flex: 3, child: SizedBox()),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
