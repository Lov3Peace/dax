import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/main.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rive/rive.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../responsive/mobile/mob_artboard_page.dart';
import '../gradient_container.dart';
import '../tactile_button.dart';
import 'auth_check.dart';
import 'forget_password_form.dart';
import 'signup.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

//controlls button
Control control = Control.stop;
//Controls the switch
bool isSwitch = false;

final _usernameController = TextEditingController();
final _passwordController = TextEditingController();

class _OnboardingScreenState extends State<OnboardingScreen> with AnimationMixin {
  // bool isLoginDialogShown = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // const ArtBoardScreen(),
            // const RiveAnimation.asset(
            //   'rive/anime_girl.riv',
            //   fit: BoxFit.fill,
            // ),
            SizedBox(
              height: 100.h(context),
              width: 100.w(context),
              child: Image.asset(
                "images/colorful-ripple-red-yellow.jpg",
                fit: BoxFit.fill,
              ),
            ),
            // Main Container w/ Blur
            Container(
              clipBehavior: Clip.hardEdge,
              width: 40.w(context),
              height: 100.h(context),
              constraints: BoxConstraints(minHeight: 900, minWidth: 500),
              padding: EdgeInsets.only(left: 5.w(context), right: 10.w(context)),
              decoration: BoxDecoration(
                  border: Border.all(
                color: const Color.fromARGB(184, 59, 54, 61),
              )),
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    // blendMode: BlendMode.darken,
                    child: SizedBox(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 10.w(context),
                            // constraints: BoxConstraints(maxHeight: 5.w(context)),
                            // color: red,
                            child: Image.asset(
                              "images/omni-temp-logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            'Omni',
                            style: TextStyle(fontSize: 12.sp(context), fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.sp(context),
                      ),
                      //Username
                      Padding(
                        padding: EdgeInsets.only(left: 0.75.w(context)),
                        child: Text(
                          textAlign: TextAlign.start,
                          "Username",
                          style: TextStyle(color: Colors.white, fontSize: 4.sp(context)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          // top: 2.sp(context),
                          // bottom: 3.sp(context),
                          left: 0.75.w(context),
                          right: 0.75.w(context),
                        ),
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(151, 255, 255, 255),
                                width: 0.05.w(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.sp(context),
                      ),

                      //Password
                      Padding(
                        padding: EdgeInsets.only(left: 0.75.w(context), top: 3.sp(context)),
                        child: Text(
                          "Password",
                          style: TextStyle(color: Colors.white, fontSize: 4.sp(context)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          // top: 2.sp(context),
                          // bottom: 3.sp(context),
                          left: 0.75.w(context),
                          right: 0.75.w(context),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          onSubmitted: (value) => login(),
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIconColor: Colors.black,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(151, 255, 255, 255), width: 0.05.w(context)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.sp(context)),

                      //Row that contains rememeber me and Forgot Password button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // spacing: 1.w(context),
                        children: [
                          Row(
                            children: [
                              Text(
                                "Remember Me",
                                style: TextStyle(fontSize: 3.sp(context)),
                              ),

                              // Have to wrap Switch like this to change size...weird
                              Container(
                                padding: EdgeInsets.only(left: 0.5.w(context)),
                                width: 3.5.w(context),
                                // height: 30,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Switch(
                                    thumbIcon: MaterialStatePropertyAll(Icon(Icons.lock_outline)),
                                    value: isSwitch,
                                    activeColor: Colors.white,
                                    activeTrackColor: pink,
                                    onChanged: (bool newBool) {
                                      setState(() {
                                        isSwitch = newBool;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Forgot password
                          TactileButton(
                            scale: 1.1,
                            child: TextButton(
                              onPressed: () {
                                Future.delayed(
                                  const Duration(milliseconds: 400),
                                  () {
                                    //slide animation
                                    showGeneralDialog(
                                      barrierDismissible: true,
                                      barrierLabel: "Login",
                                      context: context,
                                      transitionDuration: const Duration(milliseconds: 400),
                                      transitionBuilder: (_, animation, __, child) {
                                        Tween<Offset> tween;
                                        tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
                                        return SlideTransition(
                                          position: tween.animate(
                                            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                                          ),
                                          child: child,
                                        );
                                      },
                                      pageBuilder: (context, _, __) => Center(
                                        child: Container(
                                          height: 60.sp(context),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
                                          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
                                                        height: 85.h(context),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: const Color.fromARGB(182, 31, 31, 31)),
                                                          borderRadius: BorderRadius.circular(24),
                                                        )),
                                                  ),
                                                ),
                                                SingleChildScrollView(
                                                  reverse: true,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 10),
                                                        child: Text(
                                                          "Forgot Password",
                                                          style: TextStyle(
                                                            fontSize: 34,
                                                            fontFamily: "Gontserrat",
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(vertical: 2.sp(context)),
                                                        child: Text(
                                                          "Please enter your email linked to the account!",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      ForgotPasswordForm(),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.white, fontSize: 3.sp(context)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.sp(context),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.75.w(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TactileButton(
                              scale: 1.05,
                              onTap: login,
                              child: GradientContainer(
                                gradient1: red,
                                gradient2: pink,
                                height: 2.sp(context),
                                width: 3.w(context),
                                neonGlow: red,
                                text: 'Launch',
                                textSize: 3.sp(context),
                                borderColor: tran,
                                borderRadius: 5.sp(context),
                              ),
                            ),
                            TactileButton(
                              scale: 1.1,
                              child: InitSignUpButton(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: '${_usernameController.text}@omni.com', password: _passwordController.text);
      if (mounted) {
        Navigator.pushNamed(
          context,
          '/',
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("User doesn't exist.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password.');
        showErrorMessage(e.code);
      }
    }
  }

  // error message to user
  void showErrorMessage(String message) {
    showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(182, 75, 75, 75),
            title: Center(
                child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            )),
          );
        });
  }
}
