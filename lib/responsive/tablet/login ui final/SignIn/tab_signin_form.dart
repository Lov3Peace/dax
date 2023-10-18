import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../main.dart';
import '../../../mobile/mobile_constants.dart';
import '../../../mobile/mobile_dashboard.dart';
import '../tab_final_signin.dart';
import 'tab_forget_password_form.dart';

class TabSignInForm extends StatefulWidget {
  const TabSignInForm({
    super.key,
  });

  @override
  State<TabSignInForm> createState() => _TabSignInFormState();
}

class _TabSignInFormState extends State<TabSignInForm> {
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
              style: TextStyle(color: Colors.white, fontSize: 30),
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
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const Text(
              "Password",
              style: TextStyle(color: Colors.white, fontSize: 30),
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
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        "Remember Me",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Switch(
                        value: isSwitch,
                        activeColor: Colors.white,
                        activeTrackColor:
                            const Color.fromARGB(255, 221, 83, 245),
                        onChanged: (bool newBool) {
                          setState(() {
                            isSwitch = newBool;
                          });
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 94.0),
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
                                transitionDuration:
                                    const Duration(milliseconds: 400),
                                transitionBuilder: (_, animation, __, child) {
                                  Tween<Offset> tween;
                                  tween = Tween(
                                      begin: const Offset(0, -1),
                                      end: Offset.zero);
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
                                    height: 500,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 32, horizontal: 24),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(225, 50, 50, 50)
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
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TabSignButton(
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
