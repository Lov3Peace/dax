import 'dart:convert';
import 'dart:ui';

import 'package:flutter_application_1/util/auth/login.dart';
import 'package:flutter_application_1/util/auth/registerForm.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:simple_animations/simple_animations.dart';
import '../gradient_label.dart';
import '../tactile_button.dart';
import 'forget_password_form.dart';
import 'package:http/browser_client.dart' as httpClient;
import 'package:flutter_application_1/util/auth/authNotifier.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

var loginEndpoint = Uri.parse('https://localhost:7777/api/login');
var registerEndpoint = Uri.parse('https://localhost:7777/api/register');
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
bool _rememberMe = false;

var initEndpoint = Uri.parse('https://localhost:7777/api/');

Future initLoginCheck(context) async {
  var authNotifier = Provider.of<AuthNotifier>(context, listen: false);
//Controls the switch
  final client = httpClient.BrowserClient()..withCredentials = true;
  try {
    var res = await client.get(initEndpoint, headers: {
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 5));
    final body = json.decode(res.body);
    final status = res.statusCode;
    print(body);
    _rememberMe = bool.parse(body["rememberMe"]);
    print(_rememberMe);
    status == 200 ? authNotifier.loggedIn() : authNotifier.loggedOut();
    print("Init Status Code: $status");
    return status;
  } catch (e) {
    print("initLoginCheck failed!");
    print("Error: $e");
  }
}

loginCheckRoute(context, mounted) {
  // final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
  initLoginCheck(context).then((res) {
    if (res == 200) {
      Navigator.pushReplacementNamed(context, "/");
    }
  });
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    var authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    print("AuthNotifier().isLoggedIn = " + authNotifier.toString());
    loginCheckRoute(context, mounted);
  }

  // bool isLoginDialogShown = false;
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (AuthNotifier().isLoggedIn == true) {
  //     loginCheckRoute(context, mounted);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // const ArtBoardScreen(),
            // const RiveAnimation.asset(
            //   'rive/anime_girl.riv',
            //   fit: BoxFit.fill,
            // ),
            SizedBox(
              height: 100.h(context),
              width: 100.w(context),
              child: Image.asset(
                "images/aperture-vintage-GlsKHybjdS0-unsplash.jpg",
                fit: BoxFit.fill,
              ),
            ),
            // Main Container w/ Blur
            Container(
              clipBehavior: Clip.hardEdge,
              width: 40.w(context),
              height: 100.h(context),
              constraints: BoxConstraints(minHeight: 900, minWidth: 500),
              padding:
                  EdgeInsets.only(left: 5.w(context), right: 10.w(context)),
              decoration: BoxDecoration(
                  border: Border.all(
                color: const Color.fromARGB(184, 59, 54, 61),
              )),
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    // blendMode: BlendMode.darken,
                    child: SizedBox(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 10.w(context),
                            // constraints: BoxConstraints(maxHeight: 5.w(context)),
                            // color: red,
                            child: Image.asset(
                              "images/omni-temp-logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            'Omni',
                            style: TextStyle(
                                fontSize: 12.sp(context),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.sp(context),
                      ),
                      //Username
                      Padding(
                        padding: EdgeInsets.only(left: 0.75.w(context)),
                        child: Text(
                          textAlign: TextAlign.start,
                          "Username",
                          style: TextStyle(
                              color: Colors.white, fontSize: 4.sp(context)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          // top: 2.sp(context),
                          // bottom: 3.sp(context),
                          left: 0.75.w(context),
                          right: 0.75.w(context),
                        ),
                        child: TextField(
                          autofocus: true,
                          style: TextStyle(fontSize: 3.sp(context)),
                          controller: _usernameController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(151, 255, 255, 255),
                                width: 0.05.w(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.sp(context),
                      ),

                      //Password
                      Padding(
                        padding: EdgeInsets.only(
                            left: 0.75.w(context), top: 3.sp(context)),
                        child: Text(
                          "Password",
                          style: TextStyle(
                              color: Colors.white, fontSize: 4.sp(context)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          // top: 2.sp(context),
                          // bottom: 3.sp(context),
                          left: 0.75.w(context),
                          right: 0.75.w(context),
                        ),
                        child: TextField(
                          style: TextStyle(fontSize: 3.sp(context)),
                          controller: _passwordController,
                          // handles pressing 'Enter'
                          onSubmitted: (value) {
                            var authnotifier = Provider.of<AuthNotifier>(
                                context,
                                listen: false);
                            login(
                                _usernameController.text,
                                _passwordController.text,
                                authnotifier.rememberMe,
                                context,
                                mounted);
                            if (authnotifier.rememberMe == true) {
                              authnotifier.enableRememberMe();
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIconColor: Colors.black,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(151, 255, 255, 255),
                                  width: 0.05.w(context)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.sp(context)),

                      //Row that contains rememeber me and Forgot Password button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // spacing: 1.w(context),
                        children: [
                          Row(
                            children: [
                              Text(
                                "Remember Me",
                                style: TextStyle(fontSize: 3.sp(context)),
                              ),

                              // Have to wrap Switch like this to change size...weird
                              Container(
                                padding: EdgeInsets.only(left: 0.5.w(context)),
                                width: 3.5.w(context),
                                // height: 30,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Switch(
                                    thumbIcon: const WidgetStatePropertyAll(
                                        Icon(Icons.lock_outline)),
                                    value: _rememberMe,
                                    activeColor: Colors.white,
                                    activeTrackColor: pink,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = !_rememberMe;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Forgot password
                          TactileButton(
                            scale: 1.1,
                            child: TextButton(
                              onPressed: () {
                                Future.delayed(
                                  const Duration(milliseconds: 400),
                                  () {
                                    //slide animation
                                    showGeneralDialog(
                                      barrierDismissible: true,
                                      barrierLabel: "Login",
                                      context: context,
                                      transitionDuration:
                                          const Duration(milliseconds: 400),
                                      transitionBuilder:
                                          (_, animation, __, child) {
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
                                          height: 60.sp(context),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(32)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 32, horizontal: 24),
                                          child: Material(
                                            shadowColor: const Color.fromRGBO(
                                                42, 41, 41, 0.631),
                                            color: const Color.fromARGB(
                                                42, 55, 52, 52),
                                            elevation: 2,
                                            borderRadius:
                                                BorderRadius.circular(32),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  child: BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                        sigmaX: 10, sigmaY: 10),
                                                    child: Container(
                                                        height: 85.h(context),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: const Color
                                                                  .fromARGB(182,
                                                                  31, 31, 31)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        )),
                                                  ),
                                                ),
                                                SingleChildScrollView(
                                                  reverse: true,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10),
                                                        child: const Text(
                                                          "Forgot Password",
                                                          style: TextStyle(
                                                            fontSize: 34,
                                                            fontFamily:
                                                                "Gontserrat",
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.sp(
                                                                    context)),
                                                        child: const Text(
                                                          "Please enter your email linked to the account!",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      ForgotPasswordForm(),
                                                    ],
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
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 3.sp(context)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.sp(context),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.75.w(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TactileButton(
                              scale: 1.05,
                              onTap: () async {
                                await login(
                                    _usernameController.text,
                                    _passwordController.text,
                                    _rememberMe,
                                    context,
                                    mounted);
                              },
                              child: GradientContainer(
                                gradient1: red,
                                gradient2: pink,
                                height: 4.h(context),
                                width: 7.w(context),
                                neonGlow: pink,
                                text: 'Launch',
                                textSize: 2.sp(context),
                                borderColor: tran,
                                borderRadius: 5.sp(context),
                              ),
                            ),
                            TactileButton(
                              scale: 1.1,
                              child: InitSignUpButton(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
