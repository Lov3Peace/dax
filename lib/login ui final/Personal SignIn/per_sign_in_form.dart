import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../pages/main.dart';
import '../../responsive/mobile/mob_constants.dart';
import '../../responsive/mobile/mobile_dashboard.dart';
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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Username",
              style: TextStyle(color: Colors.white),
              //color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
                onSaved: (username) {},
                decoration: InputDecoration(
                  // prefixIcon: SvgPicture.asset("images/username (1).svg",
                  //     color: Colors.black),
                  //prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  // fillColor: Colors.white,
                  // filled: true,
                ),
              ),
            ),
            const Text(
              "Password",
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
                onSaved: (password) {},
                obscureText: true,
                decoration: InputDecoration(
                  // prefixIcon: SvgPicture.asset(
                  //   "images/Lock.svg",
                  // ),
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  // fillColor: Colors.white,
                  // filled: true,
                ),
              ),
            ),
            Row(
              children: [
                const Text(
                  "Remember Me",
                ),
                Switch(
                    value: isSwitch,
                    activeColor: Colors.white,
                    activeTrackColor: Color.fromARGB(255, 221, 83, 245),
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
                        Duration(milliseconds: 400),
                        () {
                          //slide animation
                          showGeneralDialog(
                            barrierDismissible: true,
                            barrierLabel: "Sign in",
                            context: context,
                            transitionDuration: Duration(milliseconds: 400),
                            transitionBuilder: (_, animation, __, child) {
                              Tween<Offset> tween;
                              tween = Tween(
                                  begin: const Offset(0, -1), end: Offset.zero);
                              return SlideTransition(
                                position: tween.animate(
                                  CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut),
                                ),
                                child: child,
                              );
                            },
                            pageBuilder: (context, _, __) => Center(
                              child: Container(
                                height: 680,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 32, horizontal: 24),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(225, 50, 50, 50)
                                      .withOpacity(0.99),
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
                                          "Forgot Password",
                                          style: TextStyle(
                                            fontSize: 34,
                                            fontFamily: "Gontserrat",
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16.0),
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
                              ),
                            ),
                          );
                        },
                      );
                      // setState(() {
                      //   isSignInDialogShown = true;
                      // });
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
            SignInButton(
              onTap: signinbtn,
            ),
          ],
        ),
      ),
    );
  }

  void signinbtn() {
    //first once the user taps sign in it shows the loading
    if (_formKey.currentState!.validate()) {
      //if eveerything looks good should show the sucess animation
    } else {
      //else it shows the error information
    }
  }
}

class SignInButton extends StatefulWidget {
  final Function()? onTap;

  SignInButton({super.key, required this.onTap});

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
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
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 35),
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

    setState(() {
      control = Control.play;
      // showGeneralDialog(
      //   barrierDismissible: true,
      //   barrierLabel: "Sign in",
      //   context: context,
      //   pageBuilder: (context, _, __) => Center(
      //     child: Container(
      //       height: 620,
      //       margin: EdgeInsets.symmetric(horizontal: 16),
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.all(
      //           Radius.circular(40),
      //         ),
      //       ),
      //     ),
      //   ),
      // );
      Future.delayed(const Duration(milliseconds: 200)).then((_) {
        Navigator.of(context).push(MaterialPageRoute(builder: (buildContext) {
          return const MobileDashboard();
        }));
      });
    });
  }

  void reverseShrink() {
    setState(() {
      control = Control.playReverse;
    });
  }
}
