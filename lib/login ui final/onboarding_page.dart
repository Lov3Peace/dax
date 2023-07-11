import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/background/artboard_page.dart';
import 'package:rive/rive.dart';
import 'package:simple_animations/animation_mixin/animation_mixin.dart';

import 'Personal SignIn/personal_btn.dart';
import 'professional_btn.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with AnimationMixin {
  bool isSignInDialogShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ArtBoardScreen(),
          AnimatedPositioned(
            top: isSignInDialogShown ? -50 : 0,
            duration: Duration(milliseconds: 240),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    Spacer(),
                    SizedBox(
                      width: 350,
                      child: Column(
                        children: const [
                          Text(
                            "Experience Omni",
                            style: TextStyle(
                              fontSize: 60,
                              fontFamily: "Gontserrat",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                              "Don't skip out on the opportunity of a lifetime. Emmerce yourself into the ever expanding world of Omni! Connect, Create, and Conquer! "),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 64,
                    //   width: 260,
                    //   child: Stack(
                    //     children: [
                    //       RiveAnimation.asset(
                    //         "rive/animated_button.riv",
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: ProfessionalButton(
                        onTap: professionalbtn,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PersonalButton(
                      onTap: personalbtn,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                          "Sign up and choose between professional and persoanl accounts. Includes access to Socials, Projects, Finances, News, and more!"),
                    ),

                    //animated button
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void professionalbtn() {}

  // create user account page
  void personalbtn() {}
}
