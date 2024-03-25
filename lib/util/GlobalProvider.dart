import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class GlobalProvider extends ChangeNotifier {
  Control walletSlideControl;
  Control settingSlideControl;
  Control friendSlideControl;
  Control helpSlideControl;
  Control infoSlideControl;
  String projectsHeroTag;
  String socialsHeroTag;
  String financesHeroTag;
  String newsHeroTag;

  GlobalProvider({
    this.friendSlideControl = Control.stop,
    this.walletSlideControl = Control.stop,
    this.settingSlideControl = Control.stop,
    this.helpSlideControl = Control.stop,
    this.infoSlideControl = Control.stop,
    this.projectsHeroTag = 'projectsHero',
    this.socialsHeroTag = 'socialsHero',
    this.financesHeroTag = 'financesHero',
    this.newsHeroTag = 'newsHero',
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

  void heroOff() {
    projectsHeroTag = 'projectHero_Off';
    socialsHeroTag = 'socialsHero_Off';
    financesHeroTag = 'financesHero_Off';
    newsHeroTag = 'newsHero_Off';
    notifyListeners();
  }

  void heroReset() {
    projectsHeroTag = 'projectsHero';
    socialsHeroTag = 'socialsHero';
    financesHeroTag = 'financesHero';
    newsHeroTag = 'newsHero';
    notifyListeners();
  }
}
