import 'dart:async';

import 'package:http/browser_client.dart' as httpClient;
import 'package:flutter_application_1/util/imports.dart';

Future loginCheck() async {
  final client = httpClient.BrowserClient()..withCredentials = true;
  final loginCheckEndpoint = Uri.parse('https://localhost:7777/api/loginCheck');
  var res = await client
      .get(loginCheckEndpoint, headers: {"Content-Type": "application/json"});
  return await res.statusCode;
}
