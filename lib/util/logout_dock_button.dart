import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/auth/login.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import '../responsive/mobile/mob_constants.dart';
import 'Window Route/logout_window_route.dart';
import 'package:http/browser_client.dart' as httpClient;

import 'providers/userAuthProvider.dart';
import 'providers/userProvider.dart';

const hostname = String.fromEnvironment("HOSTNAME", defaultValue: "localhost");

class LogoutWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const LogoutWindowButton({super.key, required});

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      onTap: () {
        Navigator.of(context).push(LogoutWindowRoute(builder: (context) {
          return LogoutWindowPopupCard(
            onPressed: () {},
          );
        }));
      },
      child: Hero(
        tag: heroLogoutWindow,
        child: Material(
          color: tran,
          child: Icon(
            Ionicons.log_out_outline,
            size: 5.sp(context),
          ),
        ),
      ),
    );
  }
}

const String heroLogoutWindow = 'Logout-window-hero';

class LogoutWindowPopupCard extends StatefulWidget {
  const LogoutWindowPopupCard({
    Key? key,
    required dynamic Function()? onPressed,
  }) : super(key: key);
  @override
  State<LogoutWindowPopupCard> createState() => _LogoutwindowPopupCardState();
  // TODO: implement createState
}

/// {@macro add_todo_popup_card}
class _LogoutwindowPopupCardState extends State<LogoutWindowPopupCard>
    with AnimationMixin {
  var logoutEndpoint = Uri.parse("https://$hostname/api/logout");
  Future logout() async {
    try {
      // Hitting the Login endpoint
      print('Fetching...');
      final client = httpClient.BrowserClient()..withCredentials = true;
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final username = userProvider.username;
      print("Got Username: $username");
      var res = await client
          .post(
            logoutEndpoint,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"username": username}),
          )
          .timeout(const Duration(seconds: 5));
      final body = json.decode(res.body);
      // cookie.sameSite
      // cookie.maxAge = 30;
      print('Fetched...');
      print(res.body);
      if (res.statusCode == 200 && mounted) {
        var userAuthProvider =
            Provider.of<UserAuthProvider>(context, listen: false);
        userAuthProvider.loggedOut();
        router.pop();
        router.go("/launch");
      } else {
        showErrorMessage('Could not log out - try again later. $body', context);
      }
    } catch (e) {
      showErrorMessage('Could not log out - try again later. $e', context);
      print('Could not log out - try again later. $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h(context), top: 4.h(context)),
            child: Center(
              child: Container(
                height: 35.h(context),
                width: 50.w(context),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(32)),
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Hero(
                  tag: heroLogoutWindow,
                  flightShuttleBuilder: flightShuttleBuilder,
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
                                      color: const Color.fromARGB(
                                          182, 31, 31, 31)),
                                  borderRadius: BorderRadius.circular(24),
                                )),
                          ),
                        ),
                        Center(
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 2.h(context)),
                                  child: const Text(
                                    "Logout",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Would you like to sign out?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2.h(context)),
                                  child: TextButton(
                                    onPressed: () async {
                                      logout();
                                    },
                                    child: const LogOutButton(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
