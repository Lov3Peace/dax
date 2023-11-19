import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class GlobalProvider extends ChangeNotifier {
  Control slideControl;
  GlobalProvider({this.slideControl = Control.stop});

  void activateSlide() {
    slideControl = Control.play;
    notifyListeners();
  }

  void reverseSlide() {
    slideControl = Control.playReverse;
    notifyListeners();
  }

  void resetSlide() {
    slideControl = Control.stop;
    notifyListeners();
  }
}
