import 'package:flutter_application_1/util/imports.dart';

class AuthNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void loggedIn() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void loggedOut() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
