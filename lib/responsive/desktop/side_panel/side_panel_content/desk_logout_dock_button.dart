import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/auth/launch_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../../../../util/Window Route/logout_window_route.dart';
import '../../../../util/ui/tactile_button.dart';

class DesktopLogoutWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  DesktopLogoutWindowButton({super.key, required});

//
// start hover is false
  bool isHover = false;

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
        child: Hero(
          tag: _heroLogoutWindow,
          child: TactileButton(
            child: AnimatedContainer(
              padding: isHover
                  ? const EdgeInsets.only(left: 10)
                  : const EdgeInsets.only(left: 0),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(104, 255, 255, 255)),
                boxShadow: const [
                  BoxShadow(color: tran),
                ],
                color: tran,
                borderRadius: const BorderRadius.all(Radius.circular(60)),
              ),
              duration: const Duration(milliseconds: 200),
              width: 10.w(context),
              height: 5.h(context),
              child: addElement(context),
            ),
          ),
        ),
      ),
    );
  }

  addElement(context) {
    return Row(
      children: [
        const Icon(
          Icons.arrow_back_ios_new,
          color: Color.fromARGB(98, 255, 255, 255),
          size: 30,
        ),
        Stack(
          children: [
            Container(
              width: 4.w(context),
              height: 4.h(context),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [purp, red]),
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
            Container(
              width: 3.75.w(context),
              height: 3.75.h(context),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Text(
          // auth.currentUser!.email.toString().allBefore('@'),
          '',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 4.sp(context)),
            fontWeight: FontWeight.w400,
            color: (isHover ? Colors.white : Colors.white54),
          ),
        ),
      ],
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
class _LogoutwindowPopupCardState extends State<LogoutWindowPopupCard>
    with AnimationMixin {
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
                width: 45.w(context),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(32)),
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Hero(
                  tag: _heroLogoutWindow,
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: Material(
                    shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
                    color:
                        const Color.fromARGB(42, 55, 52, 52).withOpacity(0.7),
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
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(182, 31, 31, 31)),
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
                                const Text(
                                  'Logout',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 1.h(context)),
                                  child: const Text(
                                    'Would you like to logout?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 1.5.h(context)),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LaunchPage()));
                                    },
                                    child: const Placeholder(),
                                  ),
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
