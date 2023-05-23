import 'package:flutter/material.dart';

class HeroTagModel extends ChangeNotifier {
  String _heroTag = '';

  String get heroTag => _heroTag;

  set heroTag(String value) {
    _heroTag = value;
    notifyListeners();
  }
}
