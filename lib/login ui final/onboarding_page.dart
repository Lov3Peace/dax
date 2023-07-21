import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/background/artboard_page.dart';
import 'package:rive/rive.dart';
import 'package:simple_animations/animation_mixin/animation_mixin.dart';

import 'SignIn/signin_btn.dart';
import 'SignUp/signup_btn.dart';

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
                    Spacer(
                      flex: 1,
                    ),
                    SizedBox(
                      width: 350,
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Omni",
                              style: TextStyle(
                                fontSize: 70,
                                fontFamily: "Gontserrat",
                                height: 1.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Project",
                              style: TextStyle(
                                fontSize: 60,
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
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Create your legacy",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 150.0),
                            child: Text(
                              "Conquer the world",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Spacer(),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: SignUpButton(
                            onTap: signupbtn,
                          ),
                        ),
                        SignInButton(
                          onTap: signinbtn,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Text("Why SignUp? Learn more about Us!"),
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
