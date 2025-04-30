import 'package:supercharged/supercharged.dart';
import '../../../util/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {
  String _username = '';

  String get username => _username;

  void loadUsername(User? user) {
    if (user != null) {
      _username = user.displayName ?? user.email?.split('@')[0] ?? '';
      notifyListeners();
    }
  }

  void updateUsername(String newName) {
    _username = newName;
    notifyListeners();
  }
}

String getCurrentUsername() {
  return auth.currentUser?.displayName ?? auth.currentUser?.email?.allBefore('@') ?? '';
}
