import 'dart:async';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/providers/userProvider.dart';
import 'package:flutter_application_1/util/auth/authNotifier.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:provider/provider.dart';
import 'package:http/browser_client.dart' as httpClient;
import 'package:rive/rive.dart';

final loginEndpoint = Uri.parse("https://localhost:7777/api/login");
Future login(username, password, rememberMe, context, mounted) async {
  try {
    // Hitting the Login endpoint
    print('Fetching...');
    final client = httpClient.BrowserClient()..withCredentials = true;
    print("(login) RememberMe: $rememberMe");
    var res = await client
        .post(
          loginEndpoint,
          headers: {
            "Content-Type": "application/json",
            "rememberMe": rememberMe.toString()
          },
          body: jsonEncode({
            "username": username,
            "password": password,
          }),
        )
        .timeout(const Duration(seconds: 5));
    final body = json.decode(res.body);
    final headers = res.headers;
    final token = headers["authorization"];
    // cookie.sameSite
    // cookie.maxAge = 30;
    print('Fetched!');
    print('Headers: $headers');
    print("Login Endpoint resBody: " + res.body);
    if (body is Map && res.statusCode == 200 && mounted) {
      print("Success");
      // access AuthNotifier Provider but set listen to false
      var authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      authNotifier.loggedIn();
      authNotifier.setToken(token);
      userProvider.saveUsername(body["username"]);
      userProvider.saveUserData(body);
      // print(userProvider.username);
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
                      child:
                          RiveAnimation.asset("rive/futuristic-loading.riv")),
                  // RiveAnimation.asset("rive/progress_bar_concept.riv")),
                  // RiveAnimation.asset("rive/loadingsquare.riv")),
                ),
              ],
            );
          });
      Future.delayed(
          Duration(seconds: 2), () => Navigator.pushNamed(context, "/"));

      var loggedIn = authNotifier.isLoggedIn;
      print("Logged In: $loggedIn");
    } else {
      showErrorMessage('Login Failed: $body', context);
    }
  } catch (e) {
    showErrorMessage('Error - Login Failed: $e', context);
    print('Login Failed: $e');
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

void cancelTimer() {}
// @override
// void dispose() {
//   _timer.cancel();
// }
