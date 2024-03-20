import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/mobile/mobile_login/mobile_launch_page.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';

import '../../../util/Window Route/logout_window_route.dart';
import '../../../util/auth/onboarding_page.dart';
import '../../mobile/mob_constants.dart';

class TabLogoutWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const TabLogoutWindowButton({super.key, required});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(LogoutWindowRoute(builder: (context) {
            return TabLogoutWindowPopupCard(
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

class TabLogoutWindowPopupCard extends StatefulWidget {
  const TabLogoutWindowPopupCard({
    Key? key,
    required dynamic Function()? onPressed,
  }) : super(key: key);
  @override
  State<TabLogoutWindowPopupCard> createState() =>
      _TabLogoutwindowPopupCardState();
  // TODO: implement createState
}

/// {@macro add_todo_popup_card}
class _TabLogoutwindowPopupCardState extends State<TabLogoutWindowPopupCard>
    with AnimationMixin {
  Future signOut() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MobileLaunchPage()));

    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h, top: 4.h),
            child: Center(
              child: Container(
                height: 35.h,
                width: 85.w,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(32)),
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Hero(
                  tag: _heroLogoutWindow,
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: Material(
                    shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
                    color: const Color.fromARGB(42, 55, 52, 52),
                    elevation: 2,
                    borderRadius: BorderRadius.circular(32),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                                height: 85.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          182, 31, 31, 31)),
                                  borderRadius: BorderRadius.circular(24),
                                )),
                          ),
                        ),
                        Center(
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: 'Logout',
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: Colors.white,
                                ),
                                const TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: 'Would you like to log out?',
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: Colors.white,
                                ),
                                TextButton(
                                  onPressed: signOut,
                                  child: LogOutButton(),
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
