// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/Window%20Route/friends_window_route.dart';
import 'package:flutter_application_1/util/Window%20Route/help_window_route.dart';
import 'package:flutter_application_1/util/Window%20Route/info_window_route.dart';
import 'package:flutter_application_1/util/auth/auth_check.dart';
import 'package:flutter_application_1/util/gradient_container.dart';
import 'package:flutter_application_1/util/home_button.dart';
import 'package:flutter_application_1/util/logout_dock_button.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../util/Window Route/settings_window_route.dart';
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
    Color hoverColor = Colors.white;
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0.w, 0),
        child: Container(
          constraints: BoxConstraints(minHeight: 750),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Color.fromARGB(185, 21, 19, 22),
              border: Border.all(color: Color.fromARGB(60, 75, 75, 75)),
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
          width: 12.5.w,
          child: Padding(
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
                      child: Image.asset("images/omni-temp-logo.png",
                          height: 5.w)),
                ),
                //Home
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5.h, 0, 1.5.h),
                  child: DeskSettingsWindowButton(
                    dockIcon: Material(
                      color: tran,
                      child: TactileButton(
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (buildContext) {
                              return AuthCheck();
                            }));
                          },
                          icon: Icon(Icons.dashboard_rounded,
                              size: 30, color: Colors.white),
                          label: Padding(
                            padding: EdgeInsets.only(left: 0.5.w),
                            child: Text(
                              'Home',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(fontSize: 2.sp),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        // child: GradientContainer(
                        //   borderColor: tran,
                        //   gradient1: Colors.white10,
                        //   gradient2: Colors.white12,
                        //   height: 1.h,
                        //   neonGlow: tran,
                        //   text: 'Home',
                        //   textSize: 2.sp,
                        //   borderRadius: 2.w,
                        //   width: 3.w,
                        // ),
                        // onTap: () {
                        //   Navigator.of(context)
                        //       .push(MaterialPageRoute(builder: (buildContext) {
                        //     return AuthCheck();
                        //   }));
                        // },
                      ),
                    ),
                  ),
                ),

                //Wallet
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: DeskWalletWindowButton(
                    dockIcon: Material(
                      color: tran,
                      child: TextButton.icon(
                        icon: Icon(
                          Ionicons.wallet_outline,
                          size: 30,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(SettingsWindowRoute(builder: (context) {
                            return DeskWalletWindowPopupCard();
                          }));
                        },
                        label: Padding(
                          padding: EdgeInsets.only(left: 0.5.w),
                          child: Text(
                            'Wallet',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(fontSize: 2.sp),
                                fontWeight: FontWeight.w400,
                                color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //
                //Friends
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: DeskFriendsWindowButton(
                    dockIcon: Material(
                      color: tran,
                      child: TextButton.icon(
                        icon: Icon(
                          Ionicons.people_outline,
                          size: 30,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(FriendsWindowRoute(builder: (context) {
                            return DeskFriendsWindowPopupCard();
                          }));
                        },
                        label: Padding(
                          padding: EdgeInsets.only(left: 0.5.w),
                          child: Text(
                            'Connections',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(fontSize: 2.sp),
                                fontWeight: FontWeight.w400,
                                color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //Settings
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: DeskSettingsWindowButton(
                    dockIcon: Material(
                      color: tran,
                      child: TextButton.icon(
                        icon: Icon(
                          Ionicons.settings_outline,
                          size: 30,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(SettingsWindowRoute(builder: (context) {
                            return const DeskSettingsWindowPopupCard();
                          }));
                        },
                        label: Padding(
                          padding: EdgeInsets.only(left: 0.5.w),
                          child: Text(
                            'Settings',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(fontSize: 2.sp),
                                fontWeight: FontWeight.w400,
                                color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //Help
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: DeskHelpWindowButton(
                    dockIcon: Material(
                      color: tran,
                      child: TextButton.icon(
                        icon: Icon(
                          Ionicons.help_circle_outline,
                          size: 30,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(HelpWindowRoute(builder: (context) {
                            return DeskHelpWindowPopupCard();
                          }));
                        },
                        label: Padding(
                          padding: EdgeInsets.only(left: 0.5.w),
                          child: Text(
                            'FAQs',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(fontSize: 2.sp),
                                fontWeight: FontWeight.w400,
                                color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //
                //About Us/Info
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: DeskInfoWindowButton(
                    dockIcon: Material(
                      color: tran,
                      child: TextButton.icon(
                        icon: Icon(
                          Ionicons.information_circle_outline,
                          size: 30,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(InfoWindowRoute(builder: (context) {
                            return DeskInfoWindowPopupCard();
                          }));
                        },
                        label: Padding(
                          padding: EdgeInsets.only(left: 0.5.w),
                          child: Text(
                            'About Us',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(fontSize: 2.sp),
                                fontWeight: FontWeight.w400,
                                color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //
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
