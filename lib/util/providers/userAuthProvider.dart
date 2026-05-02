import 'dart:convert';
import 'package:flutter_application_1/util/auth/LoginRes.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:http/browser_client.dart' as httpClient;

class UserAuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _token = '';
  bool get isLoggedIn => _isLoggedIn;
  String get token => _token;

  final client = httpClient.BrowserClient()..withCredentials = true;
  final initLoginCheckEndpoint = Uri.parse("$hostname/api/");
  final loginEndpoint = Uri.parse("$hostname/api/login");
  final registerEndpoint = Uri.parse("$hostname/api/register");

//
// Initial Login Check on Launch Page Load
  Future initLoginCheck() async {
    final client = httpClient.BrowserClient()..withCredentials = true;
    try {
      final res = await client.get(initLoginCheckEndpoint, headers: {
        "Content-Type": "application/json",
      });
      final Map body = json.decode(res.body);
      final int status = res.statusCode;
      debugPrint(json.encode(body));
      if (status == 200) {
        final token = res.headers["authorization"];
        setLoggedIn();
        setToken(token);
        print("Init Status Code from API: $status");
        return LoginRes(body: body, success: true, error: "");
      } else {
        debugPrint("Unable to log in: ${body["error"]}");
        return LoginRes(body: body, success: false, error: body["error"]);
      }
    } catch (e, stackTrace) {
      print("initLoginCheck failed!");
      print("Error: $e" + stackTrace.toString());
      return LoginRes(body: {"error": e}, success: false, error: e.toString());
    }
  }

//
// Login Function
  Future login(username, password, rememberMe) async {
    try {
      // Hitting the Login endpoint
      print('Fetching...');
      print(loginEndpoint);
      final client = httpClient.BrowserClient()..withCredentials = true;
      print("(login) RememberMe: $rememberMe");
      var res = await client.post(
        loginEndpoint,
        headers: {
          "Content-Type": "application/json",
          "rememberMe": rememberMe.toString()
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );
      // .timeout(const Duration(seconds: 5));
      final body = json.decode(res.body);
      final headers = res.headers;
      final token = headers["authorization"];

      print('Fetched!');
      print('Headers: $headers');
      print("Login Body: $body");
      print("Login Endpoint resBody: " + res.body);
      if (body is Map && res.statusCode == 200) {
        print("Success");
        // access AuthNotifier Provider but set listen to false
        setLoggedIn();
        setToken(token);
        return LoginRes(body: body, success: true, error: body["error"]);
      } else {
        return LoginRes(body: body, success: false, error: body["error"]);
      }
    } catch (e, trace) {
      print('Login Failed: $e' + trace.toString());
      return LoginRes(body: {"error": e}, success: false, error: e.toString());
    }
  }

  Future register(username, password, email, rememberMe) async {
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
      final headers = res.headers;
      final token = headers["authorization"];

      print('Fetched!');
      print('Headers: $headers');
      print("Login Body: $body");
      print("Login Endpoint resBody: " + res.body);
      if (res.statusCode == 201) {
        setLoggedIn();
        setToken(token);
        return LoginRes(body: body, success: true, error: body["error"]);
      } else {
        return LoginRes(body: body, success: false, error: body["error"]);
      }
    } catch (e, trace) {
      print('Registration Failed: $e' + trace.toString());
      return LoginRes(body: {"error": e}, success: false, error: e.toString());
    }
  }

  void setLoggedIn() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void loggedOut() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void setToken(token) {
    _token = token;
    notifyListeners();
  }
}
