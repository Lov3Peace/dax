import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../../util/auth/auth_check.dart';
import '../../mob_constants.dart';
import 'login_launch_button.dart';
import 'forget_password_form.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  //controlls button
  Control control = Control.stop;
  //Controls the switch
  bool isSwitch = false;

  //Global Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Text(
                textAlign: TextAlign.start,
                "Username",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 16,
                left: 10,
                right: 10,
              ),
              child: TextFormField(
                controller: _usernameController,
                onSaved: (username) {},
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Password",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 16,
                left: 10,
                right: 10,
              ),
              child: TextFormField(
                controller: _passwordController,
                obscureText: false,
                decoration: InputDecoration(
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    }),
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
                                height: 60.h(context),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
                                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                                child: Material(
                                  shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
                                  color: const Color.fromARGB(42, 55, 52, 52).withOpacity(0.7),
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(32),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: const Color.fromARGB(182, 31, 31, 31)),
                                              borderRadius: BorderRadius.circular(24),
                                            ),
                                          ),
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
            const SizedBox(
              height: 10,
            ),
            LoginLaunchButton(
              onTap: login,
            ),
          ],
        ),
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
