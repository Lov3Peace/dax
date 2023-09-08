import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../mob_constants.dart';
import 'signin_form.dart';

class SignInButton extends StatefulWidget {
  final Function()? onTap;

  SignInButton({super.key, required this.onTap});

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  bool isSignInDialogShown = false;
  //controlls button
  Control control = Control.stop;

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<double>(
      control: control,
      startPosition: 0,
      tween: Tween(begin: 1.0, end: 0.8),
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
      onCompleted: () {
        reverseShrink();
      },
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: pressed,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [purp, red]),
              boxShadow: const [
                BoxShadow(
                    color: red, blurRadius: 10, blurStyle: BlurStyle.solid)
              ],
              borderRadius: BorderRadius.all(Radius.circular(screenWidth / 4))),
          child: const Center(
            child: Text(
              'Sign In',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  void pressed() {
    // toggle between control instructions

    control = Control.play;
    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        //slide animation
        showGeneralDialog(
          barrierDismissible: true,
          barrierLabel: "Sign in",
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
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(32)),
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
                              border: Border.all(
                                  color: const Color.fromARGB(182, 31, 31, 31)),
                              borderRadius: BorderRadius.circular(24),
                            )),
                      ),
                    ),
                    const Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.transparent,
                      body: SingleChildScrollView(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  fontSize: 34,
                                  fontFamily: "Gontserrat",
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SignInForm(),
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
    setState(() {
      isSignInDialogShown = true;
    });
  }

  void reverseShrink() {
    setState(() {
      control = Control.playReverse;
    });
  }

  void createaccbtn() {}
}
