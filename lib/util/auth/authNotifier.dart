import 'package:flutter_application_1/util/imports.dart';

class AuthNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _rememberMe = false;
  String _token = '';
  bool get isLoggedIn => _isLoggedIn;
  bool get rememberMe => _rememberMe;
  String get token => _token;

  void loggedIn() {
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

  void enableRememberMe() {
    _rememberMe = true;
  }

  void disableRememberMe() {
    _rememberMe = false;
  }
}
