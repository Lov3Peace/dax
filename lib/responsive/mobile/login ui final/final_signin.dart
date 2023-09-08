import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desktop_dashboard.dart';
import 'package:flutter_application_1/responsive/tablet/tablet_dashboard.dart';
import 'package:flutter_application_1/util/auth_check.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../main.dart';
import '../mob_constants.dart';
import '../mobile_dashboard.dart';

class SignButton extends StatefulWidget {
  SignButton({super.key});

  @override
  State<SignButton> createState() => _SignButtonState();
}

class _SignButtonState extends State<SignButton> {
  //controlls button
  Control control = Control.stop;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: '${_usernameController.text}@omni.com',
          password: _passwordController.text);

      Navigator.of(context).push(
        PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.linear);
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return AuthCheck();
          },
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("user doesn't exist");
      } else if (e.code == 'wrong-password') {
        print('wrong password');
      }
    }
  }

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
        onTap: signIn,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [purp, red]),
                boxShadow: [
                  BoxShadow(
                      color: red, blurRadius: 7, blurStyle: BlurStyle.solid)
                ],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Text(
                'Sign In',
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      const Shadow(
                        color: red,
                        blurRadius: 1,
                      ),
                      const Shadow(
                        color: purp,
                        blurRadius: 2,
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void reverseShrink() {
    setState(() {
      control = Control.playReverse;
    });
  }
}
