// ignore_for_file: unused_import

import 'dart:ui';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/auth/auth_check.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:simple_animations/simple_animations.dart';
import '../providers/userAuthProvider.dart';
import '../providers/userProvider.dart';
import '../tactile_button.dart';
import '../../responsive/mobile/mob_constants.dart';
import 'forget_password_form.dart';
import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart' as httpClient;

final registerEndpoint = Uri.parse("$hostname/api/register");

Future register(username, password, email, rememberMe, context, mounted) async {
  try {
    // Hitting the Login endpoint
    print('Fetching...');
    final client = httpClient.BrowserClient()..withCredentials = true;
    var res = await client.post(
      registerEndpoint,
      headers: {
        "Content-Type": "application/json",
        "rememberMe": rememberMe.toString(),
        "username": username
      },
      body: jsonEncode(
          {"username": username, "password": password, "email": email}),
    );
    final body = json.decode(res.body);
    // cookie.sameSite
    // cookie.maxAge = 30;
    print('Fetched...');
    print(res.body);
    if (body is Map && res.statusCode == 201 && mounted) {
      print("Success");
      // access UserAuthProvider but set listen to false
      var userAuthProvider =
          Provider.of<UserAuthProvider>(context, listen: false);
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = res.headers["authorization"];
      userAuthProvider.setToken(token);
      userAuthProvider.loggedIn();
      userProvider.saveUserData(body);
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
      Future.delayed(Duration(seconds: 1), () {
        if (router.state != null) {
          router.pop();
        }
        router.go("/");
      });
      var loggedIn = userAuthProvider.isLoggedIn;
      print("Logged In: $loggedIn");
    } else {
      print(res.statusCode);
      showErrorMessage('Registration Failed: $body', context);
    }
  } catch (e) {
    showErrorMessage('Registration Failed: $e', context);
    print('Registration Failed: $e');
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
