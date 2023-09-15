import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:simple_animations/animation_mixin/animation_mixin.dart';
import '../../responsive/mobile/mob_artboard_page.dart';
import 'signup.dart';
import 'login.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with AnimationMixin {
  // bool isLoginDialogShown = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ArtBoardScreen(),
          AnimatedPositioned(
            top: 0,
            duration: const Duration(milliseconds: 240),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  const Spacer(),
                  const SizedBox(
                    width: 350,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 60),
                          child: Text(
                            "Experience",
                            style: TextStyle(
                              fontSize: 50,
                              fontFamily: "Gontserrat",
                              height: 1.2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 100),
                          child: Text(
                            "Omni",
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

                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20),
                        child: InitSignUpButton(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20),
                        child: InitLoginButton(),
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
        ],
      ),
    );
  }
}
