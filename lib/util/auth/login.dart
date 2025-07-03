import 'dart:ui';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/auth/auth_check.dart';
import 'package:flutter_application_1/util/auth/signup.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:simple_animations/simple_animations.dart';
import '../tactile_button.dart';
import '../../responsive/mobile/mob_constants.dart';
import 'forget_password_form.dart';
import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart' as httpClient;

Future login(endpoint, username, password, context, mounted) async {
  try {
    // Hitting the Login endpoint
    print('Fetching...');
    final client = httpClient.BrowserClient()..withCredentials = true;
    var res = await client
        .post(
          endpoint,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"username": username, "password": password}),
        )
        .timeout(const Duration(seconds: 5));
    final body = json.decode(res.body);
    // cookie.sameSite
    // cookie.maxAge = 30;
    print('Fetched...');
    print(res.body);
    if (body is Map && res.statusCode == 200 && mounted) {
      Navigator.pushNamed(context, '/');
    } else {
      showErrorMessage('Login Failed: $body', context);
    }
  } catch (e) {
    showErrorMessage('Login Failed: $e', context);
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
