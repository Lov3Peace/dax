import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login%20ui%20final/onboarding_page.dart';
import 'package:flutter_application_1/pages/main.dart';

import 'package:ionicons/ionicons.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../login ui final/Personal SignIn/personal_btn.dart';

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
class _LogoutwindowPopupCardState extends State<LogoutWindowPopupCard>
    with AnimationMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Hero(
          tag: _heroLogoutWindow,
          child: Material(
            color: const Color(0xA9444444),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 110),
                      child: TextField(
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
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
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
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnboardingScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [purp, red]),
                            boxShadow: const [
                              BoxShadow(
                                  color: red,
                                  blurRadius: 20,
                                  blurStyle: BlurStyle.solid)
                            ],
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenWidth / 4))),
                        child: const Center(
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
