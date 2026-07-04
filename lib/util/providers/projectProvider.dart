import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/logger/CarbonLogger.dart';

class ProjectProvider with ChangeNotifier {
  List _teammates = [];
  List _rolesNeeded = [];
  List _images = [];

  List get teammates => _teammates;
  void saveTeammates(teammates) {
    _teammates = teammates;
    notifyListeners();
  }

  List get rolesNeeded => _rolesNeeded;
  void saveRolesNeeded(rolesNeeded) {
    _rolesNeeded = rolesNeeded;
    notifyListeners();
  }

  List get images => _images;
  void saveImages(images) {
    _images = images;
    notifyListeners();
  }

  void clearData() {
    _teammates = [];
    _rolesNeeded = [];
    _images = [];
    notifyListeners();
    print("Project Data Cleared! Teammates: $_teammates");
  }
}
