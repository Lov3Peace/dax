import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/auth/onboarding_page.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../main.dart';
import 'auth_check.dart';

import '../gradient_container.dart';
import '../tactile_button.dart';
import '../../responsive/mobile/mob_constants.dart';

//Actual BUTTON DAVON or PHIL Whatever the hell you want to be called these days.
//if you ask me, you just formerly go by: Primate
class InitSignUpButton extends StatefulWidget {
  InitSignUpButton({super.key});

  @override
  State<InitSignUpButton> createState() => _InitSignUpButtonState();
}

class _InitSignUpButtonState extends State<InitSignUpButton> {
  // bool isSignUpDialogShown = false;
  //controls button
  Control control = Control.stop;

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      onTap: loadPopUp,
      child: GradientContainer(
        gradient1: purp,
        gradient2: red,
        height: 20,
        width: 23,
        neonGlow: red,
        text: 'Sign Up',
        textSize: 16,
        borderColor: tran,
      ),
    );
  }

  void loadPopUp() {
    // toggle between control instructions

    control = Control.play;
    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        //slide animation
        showGeneralDialog(
          barrierDismissible: true,
          barrierLabel: "Sign Up",
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
              constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 500),
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
                                color: const Color.fromARGB(182, 59, 59, 59),
                              ),
                              borderRadius: BorderRadius.circular(24),
                            )),
                      ),
                    ),
                    Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.transparent,
                      body: SingleChildScrollView(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 34,
                                  fontFamily: "Gontserrat",
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SignUpForm(),
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
    // setState(() {
    //   isSignUpDialogShown = true;
    // });
  }

  // void reverseShrink() {
  //   setState(() {
  //     control = Control.playReverse;
  //   });
  // }
}

//PopUp Card
class SignUpForm extends StatefulWidget {
  SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  //Controls the Remember Me switch
  bool rememberMe = false;
  bool showLogin = true;
  //Controller for text fields
  //final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //email: '${_usernameController.text}@omni.com',
        email: '${_usernameController.text}@omni.com',
        password: _passwordController.text,
      );

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
            return const AuthCheck();
          },
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-exists') {
        print("email already exists");
      } else if (e.code == 'wrong-password') {
        print('wrong password');
      } else if (e.code == 'weak-password') {
        print(
            'Weak Password. Please try 6 or more characters with special characters.');
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //Global Key
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Username",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 16,
                left: 10,
                right: 10,
              ),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: const BorderSide(color: Colors.white38),
                  ),
                ),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 20),
            //   child: Text(
            //     "Username",
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     top: 8.0,
            //     bottom: 16,
            //     left: 10,
            //     right: 10,
            //   ),
            //   child: TextFormField(
            //     decoration: InputDecoration(
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(
            //           screenWidth / 4,
            //         ),
            //         borderSide: const BorderSide(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Password",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 16,
                left: 10,
                right: 10,
              ),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: const BorderSide(color: Colors.white38),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Remember Me",
                  ),
                ),
                Switch(
                    value: rememberMe,
                    activeColor: Colors.white,
                    activeTrackColor: const Color.fromARGB(255, 221, 83, 245),
                    onChanged: (bool newBool) {
                      setState(() {
                        rememberMe = newBool;
                      });
                    }),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TactileButton(
                  onTap: signUp,
                  child: GradientContainer(
                    gradient1: purp,
                    gradient2: red,
                    height: 10,
                    width: 30,
                    neonGlow: red,
                    text: 'Sign Up',
                    textSize: 14,
                    borderColor: tran,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
