import 'dart:ui';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/auth/authNotifier.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/auth/auth_check.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import '../tactile_button.dart';
import '../../responsive/mobile/mob_constants.dart';
import 'forget_password_form.dart';
import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart' as httpClient;

final registerEndpoint = Uri.parse("https://localhost:7778/register");

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
    if (body is Map && res.statusCode == 201 && mounted) {
      print("Success");
      // access AuthNotifier Provider but set listen to false
      var authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      authNotifier.loggedIn();
      // Navigate to Dashboard
      Navigator.pushNamed(context, "/");
      var loggedIn = authNotifier.isLoggedIn;
      print("Logged In: $loggedIn");
    } else {
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
