// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_button_functions.dart';
import 'package:flutter_application_1/util/logout_dock_button.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';

import 'desk_home_dock_button.dart';

class DesktopSidePanel extends StatefulWidget {
  DesktopSidePanel({
    super.key,
    required this.newGrad1,
    required this.newGrad2,
    required this.newGlow,
  });
  Color newGrad1;
  Color newGrad2;
  Color newGlow;
  @override
  State<DesktopSidePanel> createState() => _DesktopSidePanelState();
}

class _DesktopSidePanelState extends State<DesktopSidePanel> with AnimationMixin {
  late Animation<double> scale;
  late Animation<double> opacity;

  @override
  void initState() {
    // TODO: implement initState

    scale = Tween<double>(begin: 1.0, end: 0.7).animate(controller);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0.w, 0),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  constraints: BoxConstraints(minHeight: 750),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(237, 21, 19, 22),
                      border: Border.all(color: Color.fromARGB(182, 75, 75, 75)),
                      boxShadow: const [
                        // BoxShadow(
                        //   blurRadius: 10,
                        //   color: Color.fromARGB(255, 37, 37, 37),
                        //   offset: Offset(0, 0),
                        // )
                      ]),
                  width: 12.5.w,
                ),
              ),
            )),

        //
        //Column that contains all buttons
        Padding(
          padding: EdgeInsets.only(left: 1.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //Logo
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5.h, 0, 1.h),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(1.5.w)),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset("images/omni-temp-logo.png", height: 5.w)),
              ),
              //Home
              DeskHomeDockButton(),

              DeskDockButtons(),
              //
              //Logout
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: TactileButton(child: const LogoutWindowButton()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//
// Contains all buttonsin the dock
class DeskDockButtons extends StatelessWidget {
  const DeskDockButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tran,
      width: 13.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DeskButtonSidePanel(),
        ],
      ),
    );
  }
}
