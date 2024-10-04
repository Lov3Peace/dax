import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/auth/auth_check.dart';
import 'package:flutter_application_1/util/auth/signup.dart';
import 'package:flutter_application_1/util/gradient_container.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../tactile_button.dart';
import '../../responsive/mobile/mob_constants.dart';
import 'forget_password_form.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class InitLoginButton extends StatefulWidget {
  const InitLoginButton({super.key});

  @override
  State<InitLoginButton> createState() => _InitLoginButtonState();
}

class _InitLoginButtonState extends State<InitLoginButton> {
  // bool isLoginDialogShown = false;
  //controlls button
  Control control = Control.stop;

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      onTap: loadPopUp,
      child: GradientContainer(
        gradient1: purp,
        gradient2: red,
        height: 20,
        width: 50,
        neonGlow: red,
        text: 'Launch',
        textSize: 16,
        borderColor: tran,
        borderRadius: 500,
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
              constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 500),
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
                              border: Border.all(
                                color: const Color.fromARGB(182, 59, 59, 59),
                              ),
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
                                "Login",
                                style: TextStyle(
                                  fontSize: 34,
                                  fontFamily: "Gontserrat",
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            LoginForm(),
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
    //   isLoginDialogShown = true;
    // });
  }

  // void reverseShrink() {
  //   setState(() {
  //     control = Control.playReverse;
  //   });
  // }

  void createaccbtn() {}
}

//PopUp Card
class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //controlls button
  Control control = Control.stop;
  //Controls the switch
  bool isSwitch = false;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //Global Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Username
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
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.white38,
                    ),
                  ),
                ),
              ),
            ),

            //Password
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
                left: 15,
                right: 15,
              ),
              child: TextField(
                controller: _passwordController,
                onSubmitted: (value) => login(),
                obscureText: false,
                decoration: InputDecoration(
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.white38,
                    ),
                  ),
                ),
              ),
            ),

            //Row that contains rememeber me and Forgot Password button
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
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TactileButton(
                  onTap: login,
                  child: GradientContainer(
                    gradient1: purp,
                    gradient2: red,
                    height: 10,
                    width: 30,
                    neonGlow: red,
                    text: 'Login',
                    textSize: 14,
                    borderColor: tran,
                    borderRadius: 500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account yet?",
                ),
                InitSignUpButton()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
