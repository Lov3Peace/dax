// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/sidePanelButtons.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/Logout.dart';
import 'package:simple_animations/simple_animations.dart';
import '../desk_decks.dart';

class DesktopSidePanel extends StatefulWidget {
  const DesktopSidePanel({
    super.key,
  });

  @override
  State<DesktopSidePanel> createState() => _DesktopSidePanelState();
}

class _DesktopSidePanelState extends State<DesktopSidePanel>
    with AnimationMixin {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "sidePanel",
      flightShuttleBuilder: textFlightShuttleBuilder,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            width: 12.5.w(context),
            height: 100.h(context),
            constraints: 100.w(context) > 2560
                ? BoxConstraints(minHeight: 1440, minWidth: 185)
                : BoxConstraints(minHeight: 1440, minWidth: 185),
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
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        //Logo
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: max(20, 5.w(context)),
                                bottom: max(10, 2.w(context))),
                            child: Text(
                              "Carbon",
                              style: TextStyle(
                                  fontSize: max(14, 5.sp(context)),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 1.w(context)),
                          child: SidePanelButtons(),
                        ),
                        Spacer(),
                        //Logout
                        Padding(
                          padding: EdgeInsets.all(1.w(context)),
                          child: Logout(),
                        ),
                      ],
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

//
// Contains all buttonsin the dock
