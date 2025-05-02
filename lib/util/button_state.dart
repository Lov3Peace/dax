import 'package:flutter/material.dart';

class ButtonState extends ChangeNotifier {
  // Slide control fields

  // Hero tags
  String projectsHeroTag;
  String socialsHeroTag;
  String communityHeroTag;
  String newsHeroTag;
  String profileHeroTag;

  ButtonState(
      {this.projectsHeroTag = 'projectsHero',
      this.socialsHeroTag = 'socialsHero',
      this.communityHeroTag = 'financesHero',
      this.newsHeroTag = 'newsHero',
      this.profileHeroTag = 'profileHero'});

  void heroOff() {
    projectsHeroTag = 'projectsHero_Off';
    socialsHeroTag = 'socialsHero_Off';
    communityHeroTag = 'communityHero_Off';
    newsHeroTag = 'newsHero_Off';
    profileHeroTag = 'profileHero_Off';
    notifyListeners();
  }

  void heroReset() {
    projectsHeroTag = 'projectsHero';
    socialsHeroTag = 'socialsHero';
    communityHeroTag = 'communityHero';
    newsHeroTag = 'newsHero';
    profileHeroTag = 'profileHero';
    notifyListeners();
  }
}
