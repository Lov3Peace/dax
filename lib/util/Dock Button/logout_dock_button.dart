import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/responsive_layout.dart';
import 'package:flutter_application_1/util/auth/onboarding_page.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../responsive/mobile/mobile_login/mobile_launch_page.dart';
import '../../responsive/mobile/mob_constants.dart';
import '../Window Route/logout_window_route.dart';

class LogoutWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const LogoutWindowButton({super.key, required});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(LogoutWindowRoute(builder: (context) {
            return LogoutWindowPopupCard(
              onPressed: () {},
            );
          }));
        },
        child: const Hero(
          tag: _heroLogoutWindow,
          child: Material(
            color: tran,
            child: Icon(
              Ionicons.log_out_outline,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroLogoutWindow = 'Logout-window-hero';

class LogoutWindowPopupCard extends StatefulWidget {
  const LogoutWindowPopupCard({
    Key? key,
    required dynamic Function()? onPressed,
  }) : super(key: key);
  @override
  State<LogoutWindowPopupCard> createState() => _LogoutwindowPopupCardState();
  // TODO: implement createState
}

/// {@macro add_todo_popup_card}
class _LogoutwindowPopupCardState extends State<LogoutWindowPopupCard> with AnimationMixin {
  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 30.0),
  //       child: Hero(
  //         tag: _heroLogoutWindow,
  //         child: Material(
  //           color: const Color.fromARGB(225, 50, 50, 50).withOpacity(0.95),
  //           elevation: 2,
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
  //           child: SingleChildScrollView(
  //             child: Padding(
  //               padding: const EdgeInsets.all(16.0),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Container(
  //                     margin: const EdgeInsets.symmetric(horizontal: 75.0),
  //                     child: const Padding(
  //                       padding: EdgeInsets.symmetric(horizontal: 50.0),
  //                       child: TextField(
  //                         decoration: InputDecoration(
  //                           hintText: 'Logout',
  //                           hintStyle: TextStyle(
  //                               color: Colors.white,
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 18),
  //                           border: InputBorder.none,
  //                         ),
  //                         cursorColor: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                   Container(
  //                     margin: const EdgeInsets.symmetric(horizontal: 40),
  //                     child: const TextField(
  //                       decoration: InputDecoration(
  //                         hintText: 'Would you like to log out?',
  //                         hintStyle: TextStyle(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 18),
  //                         border: InputBorder.none,
  //                       ),
  //                       cursorColor: Colors.white,
  //                     ),
  //                   ),
  //                   TextButton(
  //                     onPressed: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => OnboardingScreen()));
  //                     },
  //                     child: const ButtonColor(),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h(context), top: 4.h(context)),
            child: Center(
              child: Container(
                height: 35.h(context),
                width: 85.w(context),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Hero(
                  tag: _heroLogoutWindow,
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: Material(
                    shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
                    color: const Color.fromARGB(42, 55, 52, 52).withOpacity(0.7),
                    elevation: 2,
                    borderRadius: BorderRadius.circular(32),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                              height: 85.h(context),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(182, 31, 31, 31)),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: 'Logout',
                                    hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: Colors.white,
                                ),
                                const TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: 'Would you like to log out?',
                                    hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: Colors.white,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ResponsiveLayout(
                                          mobileVersion: MobileLaunchPage(),
                                          tabletVersion: MobileLaunchPage(),
                                          desktopVersion: OnboardingScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const LogOutButton(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
