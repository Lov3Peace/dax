import 'package:flutter/material.dart';
import 'package:simple_animations/animation_mixin/animation_mixin.dart';
import '../mob_artboard_page.dart';
import 'SignUp/signup_btn.dart';
import 'Signin/login_button.dart';

class MobileLaunchPage extends StatefulWidget {
  const MobileLaunchPage({super.key});

  get login => null;

  @override
  State<MobileLaunchPage> createState() => _MobileLaunchPageState();
}

class _MobileLaunchPageState extends State<MobileLaunchPage>
    with AnimationMixin {
  bool isSignInDialogShown = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ArtBoardScreen(),
          AnimatedPositioned(
            top: isSignInDialogShown ? -50 : 0,
            duration: const Duration(milliseconds: 240),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    const SizedBox(
                      width: 350,
                      child: Column(
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
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: SignUpButton(
                            onTap: signupbtn,
                          ),
                        ),
                        SignInButton(
                          onTap: () {},
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
}
