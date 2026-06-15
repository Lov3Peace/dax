import 'dart:ui';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/routes/go_routes.dart';
import 'package:flutter_application_1/util/auth/LoginRes.dart';
import 'package:flutter_application_1/util/auth/registerForm.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:rive/rive.dart';
import 'package:rive/rive.dart' as rive;
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

class _LaunchPageState extends State<LaunchPage> {
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
                                fit: Fit.cover,
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
            Container(
              constraints: 100.w(context) >= 3800
                  ? BoxConstraints(minHeight: 1100)
                  : BoxConstraints(minHeight: 900, minWidth: 500),
              height: 100.h(context),
              width: 100.w(context),
              child: Image.asset(
                "images/alex-pavor-T6kZsf30NW0-unsplash.jpg",
                fit: BoxFit.cover,
              ),
            ),
            // Main Container w/ Blur
            Container(
              clipBehavior: Clip.hardEdge,
              width: 40.w(context),
              height: 100.h(context),
              constraints: 100.w(context) >= 3800
                  ? BoxConstraints(minHeight: 1100)
                  : BoxConstraints(minHeight: 900, minWidth: 500),
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
                            'carbon',
                            style: TextStyle(
                                fontSize: 12.sp(context),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Container(
                        constraints: BoxConstraints(minHeight: 20),
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
                      Container(
                        constraints: BoxConstraints(minHeight: 20),
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
                          onSubmitted: (value) async {
                            final userAuthProvider =
                                context.read<UserAuthProvider>();
                            final userProvider = context.read<UserProvider>();
                            final LoginRes res = await userAuthProvider.login(
                              _usernameController.text,
                              _passwordController.text,
                              _rememberMe,
                            );
                            if (!context.mounted) return;
                            if (!res.success) {
                              showErrorMessage(res.error, context);
                            } else {
                              userProvider.saveUsername(res.body["username"]);
                              userProvider.saveUserData(res.body);
                              // Navigate to Dashboard
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Stack(
                                      children: [
                                        // ArtBoardScreen(),
                                        Center(
                                          child: Container(
                                              height: 350,
                                              child: rive.RiveWidgetBuilder(
                                                fileLoader:
                                                    rive.FileLoader.fromAsset(
                                                        "rive/completed.riv",
                                                        riveFactory:
                                                            rive.Factory.rive),
                                                builder: (context, state) =>
                                                    switch (state) {
                                                  RiveLoading() => const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                                  RiveFailed() =>
                                                    ErrorWidget.withDetails(
                                                      message: state.error
                                                          .toString(),
                                                      error: FlutterError(state
                                                          .error
                                                          .toString()),
                                                    ),
                                                  RiveLoaded() => RiveWidget(
                                                      controller:
                                                          state.controller,
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
                              Future.delayed(Duration(seconds: 2), () {
                                router.pop();
                                router.go("/");
                              });
                            }

                            _passwordController.clear();
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
                      Container(
                        constraints: BoxConstraints(minHeight: 20),
                        height: 5.sp(context),
                      ),

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
                                          height: 60.h(context),
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
                                                                top: 1.h(
                                                                    context)),
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
                                                                vertical: 2.h(
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
                      Container(
                        constraints: BoxConstraints(minHeight: 20),
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
                                // User and UserAuthProviders
                                final userAuthProvider =
                                    context.read<UserAuthProvider>();
                                final userProvider =
                                    context.read<UserProvider>();
                                // Return a LoginRes object from the login function for type safety
                                final LoginRes res =
                                    await userAuthProvider.login(
                                  _usernameController.text,
                                  _passwordController.text,
                                  _rememberMe,
                                );
                                // check mount after await
                                if (!context.mounted) return;

                                if (!res.success) {
                                  showErrorMessage(res.error, context);
                                } else {
                                  userProvider
                                      .saveUsername(res.body["username"]);
                                  userProvider.saveUserData(res.body);
                                  // Navigate to Dashboard
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Stack(
                                          children: [
                                            // ArtBoardScreen(),
                                            Center(
                                              child: Container(
                                                  height: 350,
                                                  child: rive.RiveWidgetBuilder(
                                                    fileLoader: rive.FileLoader
                                                        .fromAsset(
                                                            "rive/completed.riv",
                                                            riveFactory: rive
                                                                .Factory.rive),
                                                    builder: (context, state) =>
                                                        switch (state) {
                                                      RiveLoading() =>
                                                        const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                      RiveFailed() =>
                                                        ErrorWidget.withDetails(
                                                          message: state.error
                                                              .toString(),
                                                          error: FlutterError(
                                                              state.error
                                                                  .toString()),
                                                        ),
                                                      RiveLoaded() =>
                                                        RiveWidget(
                                                          controller:
                                                              state.controller,
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
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    if (!context.mounted) return;
                                    router.pop();
                                    // check mount after future
                                    router.go("/");
                                  });
                                }

                                // clear password always
                                _passwordController.clear();
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
                                borderRadius: 5.w(context),
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
