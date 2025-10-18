import 'dart:async';

import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/browser_client.dart' as httpClient;
import 'package:flutter_application_1/util/imports.dart';
import 'package:provider/provider.dart';

import '../providers/userAuthProvider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

Future loginCheck(context) async {
  final client = httpClient.BrowserClient()..withCredentials = true;
  const hostname =
      String.fromEnvironment("HOSTNAME", defaultValue: "localhost:7777");
  final loginCheckEndpoint = Uri.parse('https://$hostname/api/loginCheck');
  final res = await client
      .get(loginCheckEndpoint, headers: {"Content-Type": "application/json"});
  final userAuthProvider =
      Provider.of<UserAuthProvider>(context, listen: false);
  // bool isLoggedIn = userAuthProvider.isLoggedIn;
  print("Running loginCheck...");
  final statusCode = res.statusCode;
  print("Status: $statusCode");
  // Log out if res != 200 and navigate to /launch route
  if (statusCode != 200) {
    userAuthProvider.loggedOut();
    // addPostFrameCallback because navigating in async and outside of build
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   navigatorKey.currentState?.pushReplacementNamed('/launch');
    // });
    router.go("/");
    print("LoginCheck failed - user has been automatically logged out.");
  } else {
    userAuthProvider.loggedIn();
    bool isLoggedIn = userAuthProvider.isLoggedIn;
    print("Updated isLoggedIn: $isLoggedIn");
  }
  return res.statusCode;
}
