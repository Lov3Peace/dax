import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/routes/go_routes.dart';
import 'package:flutter_application_1/util/ErrorMessage.dart';
import 'package:flutter_application_1/util/auth/LoginRes.dart';
import 'package:flutter_application_1/util/auth/launch_page/LaunchPagePasswordField.dart';
import 'package:flutter_application_1/util/auth/registerForm.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/pillButton.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rive/rive.dart';
import 'package:rive/rive.dart' as rive;
import 'package:simple_animations/animation_mixin/animation_mixin.dart';
import '../providers/userAuthProvider.dart';
import '../providers/userProvider.dart';
import '../ui/tactile_button.dart';
import 'forget_password_form.dart';
import 'package:provider/provider.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> with AnimationMixin {
//
  final ipApiEndpoint = Uri.parse(
      "https://api.ipapi.com/api/check?access_key=5b20163bd553535fc71b6addd2ab130c");
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    // Instantiate Providers and run initLoginCheck in Future.microtask to protect the context. (Runs the Future right after the widget is mounted in the
    // widget tree)
    Future.microtask(() async {
      final userAuthProvider = context.read<UserAuthProvider>();
      final userProvider = context.read<UserProvider>();
      final LoginRes res = await userAuthProvider.initLoginCheck();

      // check if widget still mounted (async gap)
      if (!context.mounted) return;

      print(res.success);
      if (res.success == true && res.body["rememberMe"] == "true") {
        userProvider.saveUsername(res.body["username"]);
        userProvider.saveUserData(res.body);

        showDialog(
            context: context,
            builder: (dialogContext) {
              return Stack(
                children: [
                  // ArtBoardScreen(),
                  Center(
                    child: Container(
                        height: 350,
                        child: rive.RiveWidgetBuilder(
                          fileLoader: rive.FileLoader.fromAsset(
                              "rive/completed.riv",
                              riveFactory: rive.Factory.rive),
                          builder: (context, state) => switch (state) {
                            RiveLoading() =>
                              const Center(child: CircularProgressIndicator()),
                            RiveFailed() => ErrorWidget.withDetails(
                                message: state.error.toString(),
                                error: FlutterError(state.error.toString()),
                              ),
                            RiveLoaded() => RiveWidget(
                                controller: state.controller,
                                fit: Fit.contain,
                              )
                          },
                          // fit: rive.Fit.cover,
                        )),
                    // RiveAnimation.asset("rive/progress_bar_concept.riv")),
                    // RiveAnimation.asset("rive/loadingsquare.riv")),
                  ),
                ],
              );
            });

        await Future.delayed(Duration(seconds: 3));
        // check mount after future
        if (!context.mounted) return;
        router.pop();
        router.go("/");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool showPasswordField = false;
  double usernameFieldOpacity = 1;
  double usernameFieldY = 0;
  double passwordFieldOpacity = 0;
  double passwordFieldY = 1;
  FocusNode passwordFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();
  late AnimationController usernameToPasswordAnimationController =
      AnimationController(vsync: this);
  late AnimationController passwordAnimationController =
      AnimationController(vsync: this);
  Curve usernameToPasswordAnimationCurve = Curves.easeOutBack;
  Duration usernameToPasswordAnimationDuration = 500.milliseconds;
  Curve pageLoadAnimationCurve = Curves.easeOutBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //
        // Main Page Container
        child: Container(
          constraints: BoxConstraints(minWidth: 1250, minHeight: 950),
          child: Stack(
            alignment: Alignment.center,
            children: [
              //
              // Background
              Container(
                height: 100.h(context),
                width: 100.w(context),
                child: Stack(
                  children: [
                    Image.asset(
                        "images/aperture-vintage-3FS0H6gB3uY-unsplash.jpg"),
                    Opacity(
                      child: Image.asset("images/bright-blue-yellow-orbs.jpg"),
                      opacity: 0.7,
                    ),
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 100,
                          sigmaY: 100,
                        ),
                        child: Container(
                            // color: Color.fromARGB(48, 0, 0, 0),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              //
              // Welcome
              Padding(
                padding: EdgeInsets.only(right: 40.w(context), bottom: 300),
                child: const Text(
                  "Welcome",
                  style: TextStyle(fontSize: 120),
                ),
              )
                  .animate()
                  .fadeIn(
                      duration: 1000.milliseconds,
                      delay: 500.milliseconds,
                      begin: 0)
                  .slideY(
                      duration: 1000.milliseconds,
                      delay: 500.milliseconds,
                      begin: 0.1,
                      end: 0,
                      curve: pageLoadAnimationCurve),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    //
                    // Username Text and TextField
                    SizedBox(
                      width: 40.w(context),
                      child: Column(
                        children: [
                          //
                          // Username Help Text
                          Animate(
                            autoPlay: false,
                            controller: usernameToPasswordAnimationController,
                            effects: [
                              SlideEffect(
                                duration: 300.milliseconds,
                                begin: Offset(0, 0),
                                end: Offset(0, -2),
                                curve: usernameToPasswordAnimationCurve,
                              ),
                              FadeEffect(
                                  duration: 300.milliseconds, begin: 1, end: 0),
                            ],
                            child: Text(
                              "New or existing users, enter your username.",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 3.sp(context),
                                  fontStyle: FontStyle.italic),
                            )
                                //On Page Load Animation
                                .animate()
                                .fadeIn(
                                    duration: 1000.milliseconds,
                                    delay: 625.milliseconds,
                                    begin: 0)
                                .slideY(
                                    duration: 1000.milliseconds,
                                    delay: 625.milliseconds,
                                    begin: 2,
                                    end: 0,
                                    curve: pageLoadAnimationCurve),
                          ),
                          SizedBox(height: 1.w(context)),
                          //
                          // Username TextField
                          SizedBox(
                            width: 40.w(context),
                            child: Animate(
                              controller: usernameToPasswordAnimationController,
                              autoPlay: false,
                              effects: [
                                SlideEffect(
                                  delay: 50.milliseconds,
                                  duration: 300.milliseconds,
                                  begin: Offset(0, 0),
                                  end: Offset(0, -1),
                                  curve: usernameToPasswordAnimationCurve,
                                ),
                                FadeEffect(
                                  delay: 50.milliseconds,
                                  duration: 300.milliseconds,
                                  begin: 1,
                                  end: 0,
                                ),
                              ],
                              child: TextField(
                                onSubmitted: (_) {
                                  if (_usernameController.text.trim().isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const ErrorMessage(
                                              message:
                                                  "Username Cannot Be Empty");
                                        });
                                    usernameFocusNode.requestFocus();
                                  } else {
                                    usernameToPasswordAnimationController
                                        .forward();
                                    passwordFocusNode.requestFocus();
                                  }
                                },
                                focusNode: usernameFocusNode,
                                autofocus: true,
                                cursorColor: red,
                                style: TextStyle(fontSize: 3.sp(context)),
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.all(1.25.w(context)),
                                  hintText: "Username",
                                  hintStyle: TextStyle(
                                    color: grey,
                                  ),
                                  suffixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(right: 1.w(context)),
                                    child: TactileButton(
                                        onTap: () {
                                          if (_usernameController.text
                                              .trim()
                                              .isEmpty) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const ErrorMessage(
                                                      message:
                                                          "Username Cannot Be Empty");
                                                });
                                            usernameFocusNode.requestFocus();
                                          } else {
                                            usernameToPasswordAnimationController
                                                .forward();
                                            passwordFocusNode.requestFocus();
                                          }
                                        },
                                        scale: 1.1,
                                        child: Icon(
                                          Icons.arrow_circle_right_rounded,
                                          size: 1.5.w(context),
                                        )),
                                  ),
                                  // contentPadding:
                                  //     EdgeInsets.all(1.25.w(context)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.w(context)),
                                    borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                          151, 255, 255, 255),
                                      width: 0.05.w(context),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.w(context)),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(151, 255, 255, 255)),
                                  ),
                                ),
                              ),
                            ),
                          )
                              //On Page Load Animation
                              .animate()
                              .fadeIn(
                                  duration: 1000.milliseconds,
                                  delay: 750.milliseconds,
                                  begin: 0)
                              .slideY(
                                  duration: 1000.milliseconds,
                                  delay: 750.milliseconds,
                                  begin: 1,
                                  end: 0,
                                  curve: pageLoadAnimationCurve),
                        ],
                      ),
                    ),
                    //
                    // Password Text and TextField
                    SizedBox(
                      width: 40.w(context),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              //
                              // "Enter your password" Help Text
                              Animate(
                                controller:
                                    usernameToPasswordAnimationController,
                                autoPlay: false,
                                effects: [
                                  SlideEffect(
                                    delay: 100.milliseconds,
                                    duration: 300.milliseconds,
                                    begin: Offset(0, 1),
                                    end: Offset(0, 0),
                                    curve: usernameToPasswordAnimationCurve,
                                  ),
                                  FadeEffect(
                                    delay: 100.milliseconds,
                                    duration: 300.milliseconds,
                                    begin: 0,
                                    end: 1,
                                  ),
                                ],
                                child: Text(
                                  "Enter your password.",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 3.sp(context),
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              SizedBox(height: 1.w(context)),
                              //
                              // Password Textfield
                              SizedBox(
                                width: 40.w(context),
                                child: Animate(
                                  controller:
                                      usernameToPasswordAnimationController,
                                  autoPlay: false,
                                  effects: [
                                    SlideEffect(
                                      delay: 200.milliseconds,
                                      duration: 300.milliseconds,
                                      begin: Offset(0, 1),
                                      end: Offset(0, 0),
                                      curve: usernameToPasswordAnimationCurve,
                                    ),
                                    FadeEffect(
                                        delay: 200.milliseconds,
                                        duration: 300.milliseconds,
                                        begin: 0,
                                        end: 1),
                                  ],
                                  child: LaunchPagePasswordField(
                                      passwordFocusNode: passwordFocusNode,
                                      passwordController: _passwordController,
                                      usernameController: _usernameController,
                                      rememberMe: _rememberMe),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: max(10, 1.w(context))),
                                    child: Animate(
                                      controller:
                                          usernameToPasswordAnimationController,
                                      autoPlay: false,
                                      effects: [
                                        SlideEffect(
                                          delay: 300.milliseconds,
                                          duration: 300.milliseconds,
                                          begin: const Offset(0, 1),
                                          end: const Offset(0, 0),
                                          curve:
                                              usernameToPasswordAnimationCurve,
                                        ),
                                        FadeEffect(
                                            delay: 300.milliseconds,
                                            duration: 300.milliseconds,
                                            begin: 0,
                                            end: 1),
                                      ],
                                      child: Row(
                                        spacing: 1.w(context),
                                        children: [
                                          //
                                          // Back Button
                                          PillButton(
                                              onTap: () {
                                                usernameFocusNode
                                                    .requestFocus();
                                                usernameToPasswordAnimationController
                                                    .reverse();
                                              },
                                              scale: 1.05,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.5.w(context),
                                                  vertical: 0.5.w(context)),
                                              borderRadius: 20.w(context),
                                              borderColor: deckBorderColor,
                                              child: const Text("Back")),
                                          //
                                          // Forgot Password Button
                                          PillButton(
                                              onTap: () {},
                                              scale: 1.05,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.5.w(context),
                                                  vertical: 0.5.w(context)),
                                              borderRadius: 20.w(context),
                                              borderColor: deckBorderColor,
                                              child: const Text(
                                                  "Forgot Password?")),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: max(10, 1.w(context))),
                                    child: Animate(
                                      controller:
                                          usernameToPasswordAnimationController,
                                      autoPlay: false,
                                      effects: [
                                        SlideEffect(
                                          delay: 300.milliseconds,
                                          duration: 300.milliseconds,
                                          begin: Offset(0, 1),
                                          end: Offset(0, 0),
                                          curve:
                                              usernameToPasswordAnimationCurve,
                                        ),
                                        FadeEffect(
                                            delay: 300.milliseconds,
                                            duration: 300.milliseconds,
                                            begin: 0,
                                            end: 1),
                                      ],
                                      child: Row(
                                        children: [
                                          //
                                          // Remember Me Text
                                          Text(
                                            "Remember Me",
                                            style: TextStyle(
                                                fontSize:
                                                    max(12, 2.5.sp(context))),
                                          ),
                                          //
                                          // Remember Me Switch
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 0.5.w(context)),
                                            width: 3.5.w(context),
                                            // height: 30,
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Switch(
                                                thumbIcon:
                                                    const WidgetStatePropertyAll(
                                                        Icon(Icons
                                                            .lock_outline)),
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
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //
              // Carbon Footer
              Positioned(
                bottom: 3.h(context),
                right: 3.w(context),
                child: Text(
                  'Carbon',
                  style: TextStyle(
                      fontSize: 7.sp(context),
                      fontWeight: FontWeight.bold,
                      color: grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//
// Show Error Message Function
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
                      border: Border.all(color: deckBorderColor)),
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
}
