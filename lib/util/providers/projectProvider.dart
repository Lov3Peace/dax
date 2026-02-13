import 'package:flutter/material.dart';

class ProjectProvider with ChangeNotifier {
  List _teammates = [];

  List get teammates => _teammates;

  void saveTeammates(teammates) {
    _teammates = teammates;
    notifyListeners();
  }
}
