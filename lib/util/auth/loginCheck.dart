import 'dart:async';

import 'package:flutter_application_1/util/auth/authNotifier.dart';
import 'package:http/browser_client.dart' as httpClient;
import 'package:flutter_application_1/util/imports.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

Future loginCheck(context) async {
  final client = httpClient.BrowserClient()..withCredentials = true;
  final loginCheckEndpoint = Uri.parse('https://localhost:7777/api/loginCheck');
  final res = await client
      .get(loginCheckEndpoint, headers: {"Content-Type": "application/json"});
  var authNotifier = Provider.of<AuthNotifier>(context, listen: false);
  // bool isLoggedIn = authNotifier.isLoggedIn;
  print("Running loginCheck...");
  final statusCode = res.statusCode;
  print("Status: $statusCode");
  // Log out if res != 200 and navigate to /launch route
  if (statusCode != 200) {
    authNotifier.loggedOut();
    // addPostFrameCallback because navigating in async and outside of build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.pushReplacementNamed('/launch');
    });
    print("LoginCheck failed - user has been automatically logged out.");
  } else {
    authNotifier.loggedIn();
    bool isLoggedIn = authNotifier.isLoggedIn;
    print("Updated isLoggedIn: $isLoggedIn");
  }
  return res.statusCode;
}
