import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../responsive/mobile/mob_constants.dart';
import '../../responsive/desktop/desktop_dashboard.dart';
import '../../responsive/mobile/mobile_dashboard.dart';
import '../../responsive/responsive_layout.dart';
import '../../responsive/tablet/tablet_dashboard.dart';
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
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [purp, red]),
              boxShadow: const [
                BoxShadow(
                    color: red, blurRadius: 20, blurStyle: BlurStyle.solid)
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
              height: 500,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                color: const Color.fromARGB(225, 50, 50, 50).withOpacity(0.99),
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    children: const [
                      Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 34,
                          fontFamily: "Gontserrat",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "Have your personal Projects, Social Media, Finances, and News all at your finger tips! Omni's world is Endless!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SignInForm(),
                    ],
                  ),
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
