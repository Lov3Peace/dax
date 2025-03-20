import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

class HeroTagModel extends ChangeNotifier {
  String _heroTag = '';

  String get heroTag => _heroTag;

  set heroTag(String value) {
    _heroTag = value;
    notifyListeners();
  }
}
