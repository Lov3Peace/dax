import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/desk_profile_popup.dart';
import 'package:flutter_application_1/responsive/desktop/routes/go_routes.dart';
import 'package:flutter_application_1/util/auth/registerForm.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/logger/CarbonLogger.dart';
import 'package:flutter_application_1/util/ui/CarbonCircleAvatar.dart';
import 'package:flutter_application_1/util/ui/pillButton.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../mobile/mob_constants.dart';
import 'package:http/browser_client.dart' as httpClient;
import '../../../../util/providers/userAuthProvider.dart';
import '../../../../util/providers/userProvider.dart';

class CompactLogout extends StatefulWidget {
  const CompactLogout({
    Key? key,
  }) : super(key: key);
  @override
  State<CompactLogout> createState() => _CompactLogoutState();
}

class _CompactLogoutState extends State<CompactLogout> {
  bool logoutIconClicked = false;
  // logoutIcon and avatar
  double logoutIconY = 0;
  double avatarY = 0;
  double logoutIconOpacity = 1;
  double avatarOpacity = 1;
  // logoutButton and cancelButton
  double logoutButtonY = 2;
  double cancelButtonY = 2;
  double logoutButtonOpacity = 0;
  double cancelButtonOpacity = 0;

//
// Logout Function
  final logoutEndpoint = Uri.parse("$hostname/api/logout");
  Future logout() async {
    try {
      // Hitting the Login endpoint
      print('Fetching...');
      final client = httpClient.BrowserClient()..withCredentials = true;
      final userProvider = context.read<UserProvider>();
      final username = userProvider.username;
      print("Got Username: $username");
      var res = await client
          .post(
            logoutEndpoint,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"username": username}),
          )
          .timeout(const Duration(seconds: 5));
      // final body = json.decode(res.body);
      // cookie.sameSite
      // cookie.maxAge = 30;
      print('Fetched...');
      print(res.body);
      if (res.statusCode == 200 && mounted) {
        var userAuthProvider =
            Provider.of<UserAuthProvider>(context, listen: false);
        userAuthProvider.loggedOut();
        return true;
      } else {
        logger.e("Unable to log out");
        return false;
      }
    } catch (e) {
      // showErrorMessage('Could not log out - try again later. $e', context);
      print('Could not log out - try again later. $e');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
        borderRadius: 50.w(context),
        height: max(100, 10.w(context)),
        color: tran,
        // padding: EdgeInsetsGeometry.symmetric(
        // vertical: 2.w(context), horizontal: 5.w(context)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //
                // User Avatar
                AnimatedSlide(
                    duration: Duration(milliseconds: 500),
                    offset: Offset(0, avatarY),
                    curve: Curves.fastOutSlowIn,
                    child: AnimatedOpacity(
                      opacity: avatarOpacity,
                      duration: const Duration(milliseconds: 250),
                      child: Visibility(
                        visible: !logoutIconClicked,
                        child: TactileButton(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false,
                                barrierDismissible: true,
                                fullscreenDialog: false,
                                transitionDuration:
                                    const Duration(milliseconds: 700),
                                pageBuilder: (_, __, ___) {
                                  return Hero(
                                    tag: 'profileHeroTag',
                                    flightShuttleBuilder: flightShuttleBuilder,
                                    child: Center(
                                      child: ProfilePopup(),
                                    ),
                                  );
                                },
                                transitionsBuilder: (_, anim, __, child) =>
                                    FadeTransition(opacity: anim, child: child),
                              ),
                            );
                          },
                          scale: 1.05,
                          child: const Stack(
                            children: [
                              CarbonCircleAvatar(),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: green,
                                  radius: 5,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                //
                // Logout Arrow Icon
                AnimatedSlide(
                  duration: Duration(milliseconds: 250),
                  offset: Offset(0, logoutIconY),
                  curve: Curves.fastOutSlowIn,
                  child: AnimatedOpacity(
                    opacity: logoutIconOpacity,
                    duration: Duration(milliseconds: 250),
                    child: Visibility(
                      visible: !logoutIconClicked,
                      child: TactileButton(
                          scale: 1.05,
                          onTap: () {
                            setState(() {
                              logoutIconClicked = !logoutIconClicked;
                              // logoutIcon and avatar
                              logoutIconY = -1;
                              avatarY = -1;
                              logoutIconOpacity = 0;
                              avatarOpacity = 0;
                              // logoutButton and cancelButton
                              logoutButtonOpacity = 1;
                              cancelButtonOpacity = 1;
                              logoutButtonY = 0;
                              cancelButtonY = 0;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.all(0.5.w(context)),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: deckBorderColor)),
                              child: Icon(
                                Ionicons.chevron_back,
                                size: 1.5.w(context),
                              ))),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //
                // Cancel Button
                AnimatedSlide(
                    duration: Duration(milliseconds: 250),
                    offset: Offset(0, cancelButtonY),
                    curve: Curves.fastOutSlowIn,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 250),
                      opacity: cancelButtonOpacity,
                      child: Visibility(
                        visible: logoutIconClicked,
                        child: TactileButton(
                          scale: 1.05,
                          onTap: () => setState(() {
                            logoutIconClicked = !logoutIconClicked;
                            // logoutIcon and avatar
                            logoutIconOpacity = 1;
                            avatarOpacity = 1;
                            logoutIconY = 0;
                            avatarY = 0;
                            // logoutButton and cancelButton
                            logoutButtonOpacity = 0;
                            cancelButtonOpacity = 0;
                            logoutButtonY = 1;
                            cancelButtonY = 1;
                          }),
                          child: Container(
                              padding: EdgeInsets.all(max(5, 0.5.w(context))),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: deckBorderColor)),
                              child: Icon(
                                Icons.close,
                                size: 1.5.w(context),
                              )),
                        ),
                      ),
                    )),
                //
                // Logout Button
                AnimatedSlide(
                  duration: Duration(milliseconds: 500),
                  offset: Offset(0, logoutButtonY),
                  curve: Curves.fastOutSlowIn,
                  child: AnimatedOpacity(
                      opacity: logoutButtonOpacity,
                      duration: Duration(milliseconds: 250),
                      child: Visibility(
                        visible: logoutIconClicked,
                        child: TactileButton(
                          scale: 1.05,
                          onTap: () async {
                            bool res = await logout();
                            if (!res && mounted) {
                              showErrorMessage("Unable to log out!", context);
                            } else {
                              router.go("/launch");
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.all(0.5.w(context)),
                              decoration: BoxDecoration(
                                  color: red, shape: BoxShape.circle),
                              child: Icon(
                                Ionicons.chevron_back,
                                size: 1.5.w(context),
                              )),
                        ),
                      )),
                ),
              ],
            ),
          ],
        ));
  }
}
