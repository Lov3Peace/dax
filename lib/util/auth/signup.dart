import 'dart:ui';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/auth/auth_check.dart';
import 'package:flutter_application_1/util/auth/signup.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:simple_animations/simple_animations.dart';
import '../tactile_button.dart';
import '../../responsive/mobile/mob_constants.dart';
import 'forget_password_form.dart';
import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart' as httpClient;

//Actual BUTTON DAVON or PHIL Whatever the hell you want to be called these days.
//if you ask me, you just formerly go by: Primate
class InitSignUpButton extends StatefulWidget {
  const InitSignUpButton({super.key});

  @override
  State<InitSignUpButton> createState() => _InitSignUpButtonState();
}

class _InitSignUpButtonState extends State<InitSignUpButton> {
  // bool isSignUpDialogShown = false;
  //controls button
  Control control = Control.stop;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: loadPopUp,
      child: Text(
        "Sign Up?",
        style: TextStyle(color: Colors.white, fontSize: 3.sp(context)),
      ),
    );
  }

  void loadPopUp() {
    // toggle between control instructions

    control = Control.play;
    //slide animation
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: "Sign Up",
        context: context,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, _, __) => Center(
                child: Container(
              height: 75.h(context),
              constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 550),
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
                            height: 85.h(context),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(182, 59, 59, 59),
                              ),
                              borderRadius: BorderRadius.circular(24),
                            )),
                      ),
                    ),
                    const SingleChildScrollView(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
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
                          SignUpForm()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().slideX(
                    begin: -1,
                    end: 0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutBack)));
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
  const SignUpForm({
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
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var registerEndpoint = Uri.parse('https://localhost:7777/api/register');

  Future register(username, password, email, context, mounted) async {
    try {
      // Hitting the Login endpoint
      print('Fetching...');
      final client = httpClient.BrowserClient()..withCredentials = true;
      var res = await client
          .post(
            registerEndpoint,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(
                {"username": username, "password": password, "email": email}),
          )
          .timeout(const Duration(seconds: 5));
      final body = json.decode(res.body);
      // cookie.sameSite
      // cookie.maxAge = 30;
      print('Fetched...');
      print(res.body);
      if (body is Map && body.keys.contains('password') && mounted) {
        Navigator.pushNamed(context, '/');
      } else {
        showErrorMessage('Signup Failed: $body', context);
      }
    } catch (e) {
      showErrorMessage('Signup Failed: $e', context);
      print('Signup Failed: $e');
    }
  }

  void showErrorMessage(String message, context) {
    showDialog(
        context: (context),
        builder: (context) {
          return Center(
            child: Stack(children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                blendMode: BlendMode.darken,
                child: SizedBox(),
              ),
              AlertDialog(
                backgroundColor: tran,
                content: Container(
                  padding: EdgeInsetsGeometry.all(1.w(context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.5.w(context)),
                    color: deckColor,
                    border: Border.all(color: deckBorderColor),
                  ),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 3.sp(context), color: white),
                  ),
                ),
              )
            ]),
          );
        });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //Global Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Email for Signup
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8,
                left: 10,
                right: 10,
              ),
              child: TextField(
                controller: _emailController,
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

            //Username for signup
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Username",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8,
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

            //Password for signup
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Password",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8,
                left: 10,
                right: 10,
              ),
              child: TextField(
                controller: _passwordController,
                onSubmitted: (value) => register(
                    _usernameController.text,
                    _passwordController.text,
                    _emailController.text,
                    context,
                    mounted),
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

            //row for remeber me and switch
            //need to connect this soon!
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
              height: 2,
            ),

            //SignUp
            // Signs us into the
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TactileButton(
                  onTap: () async {
                    register(_usernameController.text, _passwordController.text,
                        _emailController.text, context, mounted);
                  },
                  child: GradientContainer(
                    gradient1: purp,
                    gradient2: red,
                    height: 10,
                    width: 30,
                    neonGlow: red,
                    text: 'Sign Up',
                    textSize: 14,
                    borderColor: tran,
                    borderRadius: 500,
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
