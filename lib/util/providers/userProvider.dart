import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {
  String _username = '';

  String get username => _username;

  Map _userdata = {};
  Map get userData => _userdata;

  void loadUsername(User? user) {
    if (user != null) {
      _username = user.displayName ?? user.email?.split('@')[0] ?? '';
      notifyListeners();
    }
  }

  void saveUserData(Map userData) {
    _userdata = userData;
    notifyListeners();
  }

  void saveUsername(username) {
    _username = username;
    notifyListeners();
  }

  void updateUsername(String newName) {
    _username = newName;
    notifyListeners();
  }
}

String getCurrentUsername() {
  return 'User';
  // return auth.currentUser?.displayName ??
  //     auth.currentUser?.email?.allBefore('@') ??
  '';
}
