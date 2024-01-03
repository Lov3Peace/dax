import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class GlobalProvider extends ChangeNotifier {
  Control walletSlideControl;
  Control settingSlideControl;
  Control friendSlideControl;
  Control helpSlideControl;
  Control infoSlideControl;

  GlobalProvider({
    this.friendSlideControl = Control.stop,
    this.walletSlideControl = Control.stop,
    this.settingSlideControl = Control.stop,
    this.helpSlideControl = Control.stop,
    this.infoSlideControl = Control.stop,
  });

  void infoReverseSlide() {
    infoSlideControl = Control.playReverse;
    notifyListeners();
  }

  void infoActivateSlide() {
    infoSlideControl = Control.play;
    notifyListeners();
  }

  void infoResetSlide() {
    infoSlideControl = Control.stop;
    notifyListeners();
  }

  void helpActivateSlide() {
    helpSlideControl = Control.play;
    notifyListeners();
  }

  void helpResetSlide() {
    helpSlideControl = Control.stop;
    notifyListeners();
  }

  void helpReverseSlide() {
    helpSlideControl = Control.playReverse;
    notifyListeners();
  }

  void settingsReverseSlide() {
    settingSlideControl = Control.playReverse;
    notifyListeners();
  }

  void settingsActivateSlide() {
    settingSlideControl = Control.play;
    notifyListeners();
  }

  void settingsResetSlide() {
    settingSlideControl = Control.stop;
    notifyListeners();
  }

  void friendActivateSlide() {
    friendSlideControl = Control.play;
    notifyListeners();
  }

  void friendReverseSlide() {
    friendSlideControl = Control.playReverse;
    notifyListeners();
  }

  void friendResetSlide() {
    friendSlideControl = Control.stop;
    notifyListeners();
  }

  void walletActivateSlide() {
    walletSlideControl = Control.play;
    notifyListeners();
  }

  void walletReverseSlide() {
    walletSlideControl = Control.playReverse;
    notifyListeners();
  }

  void walletResetSlide() {
    walletSlideControl = Control.stop;
    notifyListeners();
  }
}

// class WalletGlobalProvider extends ChangeNotifier {
//   Control slideControl;
//   WalletGlobalProvider({this.slideControl = Control.stop});

//   void activateSlide() {
//     slideControl = Control.play;
//     notifyListeners();
//   }

//   void reverseSlide() {
//     slideControl = Control.playReverse;
//     notifyListeners();
//   }

//   void resetSlide() {
//     slideControl = Control.stop;
//     notifyListeners();
//   }
// }

// class FriendsGlobalProvider extends ChangeNotifier {
//   Control slideControl;
//   FriendsGlobalProvider({this.slideControl = Control.stop});

//   void activateSlide() {
//     slideControl = Control.play;
//     notifyListeners();
//   }

//   void reverseSlide() {
//     slideControl = Control.playReverse;
//     notifyListeners();
//   }

//   void resetSlide() {
//     slideControl = Control.stop;
//     notifyListeners();
//   }
// }

// class SettingGlobalProvider extends ChangeNotifier {
//   Control slideControl;
//   SettingGlobalProvider({this.slideControl = Control.stop});

//   void activateSlide() {
//     slideControl = Control.play;
//     notifyListeners();
//   }

//   void reverseSlide() {
//     slideControl = Control.playReverse;
//     notifyListeners();
//   }

//   void resetSlide() {
//     slideControl = Control.stop;
//     notifyListeners();
//   }
// }
