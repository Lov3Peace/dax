import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:rive/rive.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
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
      body: Stack(
        children: [
          // const ArtBoardScreen(),
          const RiveAnimation.asset(
            'rive/anime_girl.riv',
            fit: BoxFit.fill,
          ),

          Container(
            clipBehavior: Clip.hardEdge,
            width: 40.w,
            height: 100.h,
            padding: EdgeInsets.only(left: 5.w, right: 10.w),
            decoration: BoxDecoration(
                border: Border.all(
              color: const Color.fromARGB(184, 59, 54, 61),
            )),
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  // blendMode: BlendMode.darken,
                  child: const SizedBox(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxHeight: 5.w),
                            // color: red,
                            child: Image.asset(
                              "images/omni-temp-logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          const Text(
                            'Omni',
                            style: TextStyle(fontSize: 70, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      //Username
                      Padding(
                        padding: EdgeInsets.only(left: 0.75.w),
                        child: const Text(
                          textAlign: TextAlign.start,
                          "Username",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8.0,
                          bottom: 10,
                          left: 0.75.w,
                          right: 15,
                        ),
                        child: TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(151, 255, 255, 255),
                                width: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      //Password
                      Padding(
                        padding: EdgeInsets.only(left: 0.75.w, top: 2.h),
                        child: const Text(
                          "Password",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8.0,
                          bottom: 10,
                          left: 0.75.w,
                          right: 15,
                        ),
                        child: TextField(
                          controller: _passwordController,
                          onSubmitted: (value) => login(),
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIconColor: Colors.black,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(151, 255, 255, 255), width: 0.5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      //Row that contains rememeber me and Forgot Password button
                      Padding(
                        padding: EdgeInsets.only(left: 0.75.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Remember Me",
                            ),
                            Switch(
                              value: isSwitch,
                              activeColor: Colors.white,
                              activeTrackColor: const Color.fromARGB(255, 221, 83, 245),
                              onChanged: (bool newBool) {
                                setState(() {
                                  isSwitch = newBool;
                                });
                              },
                            ),

                            //Forgot password
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextButton(
                                onPressed: () {
                                  control = Control.play;
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
                                            height: 60.h,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
                                            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
                                                            border: Border.all(color: const Color.fromARGB(182, 31, 31, 31)),
                                                            borderRadius: BorderRadius.circular(24),
                                                          )),
                                                    ),
                                                  ),
                                                  const Scaffold(
                                                    resizeToAvoidBottomInset: false,
                                                    backgroundColor: Colors.transparent,
                                                    body: SingleChildScrollView(
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
                                                            padding: EdgeInsets.symmetric(vertical: 16.0),
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
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.75.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TactileButton(
                              onTap: login,
                              child: GradientContainer(
                                gradient1: purp,
                                gradient2: red,
                                height: 10,
                                width: 30,
                                neonGlow: red,
                                text: 'Launch',
                                textSize: 14,
                                borderColor: tran,
                                borderRadius: 500,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: InitSignUpButton(),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: '${_usernameController.text}@omni.com', password: _passwordController.text);

      Navigator.of(context).push(
        PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(parent: animation, curve: Curves.linear);
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            print('Login Successful...');
            // ignore: prefer_const_constructors
            return AuthCheck();
          },
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
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
