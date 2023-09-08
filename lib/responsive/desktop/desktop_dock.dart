// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/mobile/mob_constants.dart';
import 'package:flutter_application_1/util/Dock%20Button/friends_dock_button.dart';
import 'package:flutter_application_1/util/Dock%20Button/help_dock_button.dart';
import 'package:flutter_application_1/util/Dock%20Button/info_dock_button.dart';
import 'package:flutter_application_1/util/Dock%20Button/logout_dock_button.dart';
import 'package:flutter_application_1/util/Dock%20Button/messages_dock_button.dart';
import 'package:flutter_application_1/util/Dock%20Button/settings_dock_button.dart';
import 'package:flutter_application_1/util/Dock%20Button/wallet_dock_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desktop_constants.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';

import '../../util/Window Route/settings_window_route.dart';
import '../../util/home_button.dart';

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
    Color hoverColor = Colors.white;
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0.25.w, 0),
        child: Container(
          constraints: BoxConstraints(minHeight: 750),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Color.fromARGB(185, 21, 19, 22),
              border: Border.all(color: Color.fromARGB(147, 58, 58, 58)),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5,
                  color: Color.fromARGB(255, 8, 8, 8),
                  offset: Offset(0, 0),
                ),
                // BoxShadow(
                //   blurRadius: 10,
                //   color: Color.fromARGB(255, 37, 37, 37),
                //   offset: Offset(0, 0),
                // )
              ]),
          width: 10.w,
          child: Padding(
            padding: EdgeInsets.only(left: 1.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                //Profile
                // DockButton(icon: Ionicons.person_circle_outline),

                //Home
                // HomeButton(
                //     gradient1: widget.newGrad1,
                //     gradient2: widget.newGrad2,
                //     glow: widget.newGlow),

                //Messages
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5.h, 0, 1.5.h),
                  child: TextButton(
                    onPressed: null,
                    child: Text(
                      'Home',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(fontSize: 3.sp),
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    onHover: (value) {
                      hoverColor = red;
                    },
                  ),
                ),
                Divider(thickness: 1, endIndent: 1.w),

                //PAGE 2

                //Settings
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: SettingsWindowButton(
                    dockIcon: Material(
                      color: tran,
                      child: TextButton.icon(
                        onHover: (value) {
                          if (value == true) {
                            setState(() {
                              hoverColor = red;
                            });
                          } else {
                            hoverColor = Colors.white;
                          }
                        },
                        icon: Icon(
                          Ionicons.settings_sharp,
                          size: 30,
                          color: hoverColor,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(SettingsWindowRoute(builder: (context) {
                            return const SettingsWindowPopupCard();
                          }));
                        },
                        label: Text(
                          'Settings',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(fontSize: 3.sp),
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(thickness: 1, endIndent: 1.w),
                //Wallet
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const WalletWindowButton(),
                ),
                Divider(thickness: 1, endIndent: 1.w),
                //Friends
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const FriendsWindowButton(),
                ),
                Divider(thickness: 1, endIndent: 1.w),
                //PAGE 3

                //
                //Help
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const HelpWindowButton(),
                ),
                Divider(thickness: 1, endIndent: 1.w),
                //About Us/Info
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const InfoWindowButton(),
                ),
                Divider(thickness: 1, endIndent: 1.w),
                //Logout
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: const LogoutWindowButton(),
                ),
              ],
            ),
          ),
        ));

    // return Container(
    //   constraints: BoxConstraints(minHeight: 750),
    //   clipBehavior: Clip.hardEdge,
    //   decoration: BoxDecoration(
    //       gradient: const LinearGradient(colors: [
    //         Color.fromARGB(134, 10, 10, 10),
    //         Color.fromARGB(230, 24, 24, 24),
    //       ], transform: GradientRotation(180)),
    //       borderRadius: BorderRadius.circular(50),
    //       border: Border.all(color: const Color.fromARGB(148, 37, 37, 37)),
    //       boxShadow: [
    //         BoxShadow(
    //           blurRadius: 5,
    //           color: Color.fromARGB(255, 8, 8, 8),
    //           offset: Offset(0, 0),
    //         ),
    //         // BoxShadow(
    //         //   blurRadius: 10,
    //         //   color: Color.fromARGB(255, 37, 37, 37),
    //         //   offset: Offset(0, 0),
    //         // )
    //       ]),
    //   width: 100,
    //   height: 75.h,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       //Home
    //       HomeButton(
    //         gradient1: purp,
    //         gradient2: red,
    //         glow: red,
    //       ),

    //       DockButton(icon: Ionicons.person_circle_outline),

    //       //Messages
    //       DockButton(
    //         icon: Ionicons.chatbox,
    //       ),

    //       //PAGE 2
    //       DockButton(icon: Ionicons.settings_sharp),

    //       //Wallet
    //       DockButton(icon: Ionicons.wallet),

    //       //Friends
    //       DockButton(icon: Ionicons.people),

    //       //PAGE 3
    //       DockButton(icon: Ionicons.help_circle_outline),

    //       //About Us/Info
    //       DockButton(icon: Icons.info_sharp),

    //       //Logout
    //       DockButton(icon: Icons.logout_outlined),
    //     ],
    //   ),
    // );
  }
}
