// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_buttons/desk_home_dock_button.dart';
import 'package:flutter_application_1/util/auth/auth_check.dart';
import 'package:flutter_application_1/util/logout_dock_button.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import 'desk_dock_buttons/desk_friends_dock_button.dart';
import 'desk_dock_buttons/desk_help_dock_button.dart';
import 'desk_dock_buttons/desk_info_dock_button.dart';
import 'desk_dock_buttons/desk_settings_dock_button.dart';
import 'desk_dock_buttons/desk_wallet_dock_button.dart';

class DesktopDock extends StatefulWidget {
  DesktopDock({
    super.key,
    required this.newGrad1,
    required this.newGrad2,
    required this.newGlow,
  });
  Color newGrad1;
  Color newGrad2;
  Color newGlow;
  @override
  State<DesktopDock> createState() => _DesktopDockState();
}

class _DesktopDockState extends State<DesktopDock> with AnimationMixin {
  late Animation<double> scale;
  late Animation<double> opacity;

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
                      border:
                          Border.all(color: Color.fromARGB(182, 75, 75, 75)),
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
                    child:
                        Image.asset("images/omni-temp-logo.png", height: 5.w)),
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
class DeskDockButtons extends StatefulWidget {
  const DeskDockButtons({super.key});

  @override
  State<DeskDockButtons> createState() => _DeskDockButtonsState();
}

class _DeskDockButtonsState extends State<DeskDockButtons> {
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
          //Wallet
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: DeskWalletButtonHover(),
          ),

          //
          //Friends
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: DeskFriendsButtonHover(),
          ),
          //Settings
          Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: DeskSettingsButtonHover()),

          //Help
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: DeskHelpButtonHover(),
          ),
          //
          //About Us/Info
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: DeskInfoButtonHover(),
          ),
        ],
      ),
    );
  }
}
