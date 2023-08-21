import 'package:flutter/material.dart';
import 'package:simple_animations/animation_mixin/animation_mixin.dart';
import 'package:sizer/sizer.dart';
import '../tab_artboard_page.dart';
import 'SignIn/tab_signin_btn.dart';
import 'SignUp/tab_signup_btn.dart';

class TabOnboardingScreen extends StatefulWidget {
  TabOnboardingScreen({super.key});

  State<TabOnboardingScreen> createState() => _TabOnboardingScreenState();
}

class _TabOnboardingScreenState extends State<TabOnboardingScreen>
    with AnimationMixin {
  bool isSignInDialogShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const TabArtBoardScreen(),
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
                    Spacer(
                      flex: 1,
                    ),
                    SizedBox(
                      width: 90.h,
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 100),
                            child: Text(
                              "Experience",
                              style: TextStyle(
                                fontSize: 100,
                                fontFamily: "Gontserrat",
                                height: 1.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 200),
                            child: Text(
                              "Omni",
                              style: TextStyle(
                                fontSize: 120,
                                fontFamily: "Gontserrat",
                                height: 1.2,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 110.0),
                            child: Text(
                              "Connect with friends",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Create your legacy",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 150.0),
                            child: Text(
                              "Conquer the world",
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Spacer(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: TabSignUpButton(
                                onTap: signupbtn,
                              ),
                            ),
                            TabSignInButton(
                              onTap: signinbtn,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Text(
                          "Why SignUp? Learn more about Us!",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
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

  void signupbtn() {}

  // create user account page
  void signinbtn() {}
}
