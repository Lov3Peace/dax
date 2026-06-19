import 'dart:ui';

import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/compactSidePanelButtons.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/sidePanelButtons.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/logout_dock_button.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';

class CompactSidePanel extends StatelessWidget {
  const CompactSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "sidePanel",
      flightShuttleBuilder: textFlightShuttleBuilder,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            width: 6.25.w(context),
            height: 100.h(context),
            constraints: 100.w(context) > 2560
                ? BoxConstraints(minHeight: 1440, minWidth: 50)
                : BoxConstraints(minHeight: 1440, minWidth: 50),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: const Color.fromARGB(185, 21, 19, 22),
                border: Border.all(color: deckBorderColor),
                boxShadow: [
                  // BoxShadow(
                  //   blurRadius: 10,
                  //   color: Color.fromARGB(255, 37, 37, 37),
                  //   offset: Offset(0, 0),
                  // )
                ]),
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.only(left: 1.w(context)),
                      child: Column(
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          //Logo
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: max(16, 7.sp(context)),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          CompactSidePanelButtons(),
                          Spacer(),
                          //Logout
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: TactileButton(
                              child: LogoutWindowButton(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
