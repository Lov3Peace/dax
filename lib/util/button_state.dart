import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel_info/help_communies_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel_info/help_faqs_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel_info/help_news_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel_info/help_projects_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel_info/help_socials_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel_info/help_tips_tricks_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel_info/help_wallet_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/info/info_side_panel_info/info_about_us.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/info/info_side_panel_info/info_contact_us.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/info/info_side_panel_info/info_goals.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/info/info_side_panel_info/info_terms_conditions.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/access_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/billing_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/general_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/privacy_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/profile_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/security_settings.dart';
import 'package:simple_animations/simple_animations.dart';

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

  //
  //
  //Info Side Panel
  String _activeInfoButtonId = '';
  int _currentIndex = 0;
  final CarouselSliderController _CarouselSliderController = CarouselSliderController();

  String get activeInfoButtonId => _activeInfoButtonId;
  int get currentIndex => _currentIndex;

  void setActiveInfoButton(String infoButtonId) {
    _activeInfoButtonId = infoButtonId;
    notifyListeners();
    _navigateToSlide(infoButtonId);
  }

  void setSlide(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void goToSlide(int index) {
    _CarouselSliderController.animateToPage(index);
    setSlide(index);
  }

  void _navigateToSlide(String infoButtonId) {
    final Map<String, int> buttonToSlideMap = {
      'button1': 0, // 'About Us'
      'button2': 1, // 'Contact Us'
      'button3': 2, // 'Goals'
      'button4': 3, // 'Terms & Conditions'
    };

    final index = buttonToSlideMap[infoButtonId];
    if (index != null) {
      goToSlide(index);
    }
  }

  void callInfoClassForButton(String infoButtonId) {
    if (infoButtonId == 'button1') {
      const AboutUsInformation();
    } else if (infoButtonId == 'button2') {
      const ContactUsInformation();
    } else if (infoButtonId == 'button3') {
      const GoalsInformation();
    } else if (infoButtonId == 'button4') {
      const TermsConditionsInformation();
    }
  }

  //
  //
  // FAQs Side Panel
  String _activeFAQsButtonId = '';

  String get activeFAQsButtonId => _activeFAQsButtonId;

  void setActiveFAQsButton(String faqsButtonId) {
    _activeFAQsButtonId = faqsButtonId;
    notifyListeners();
  }

  void callFAQsClassForButton(String faqsButtonId) {
    if (faqsButtonId == 'FAQs') {
      const FAQsInformation();
    } else if (faqsButtonId == 'Projects') {
      const ProjectsInformation();
    } else if (faqsButtonId == 'Communities') {
      const CommunitiesInformation();
    } else if (faqsButtonId == 'Socials') {
      const SocialsInformation();
    } else if (faqsButtonId == 'News') {
      const NewsInformation();
    } else if (faqsButtonId == 'Wallet') {
      const WalletInformation();
    } else if (faqsButtonId == 'Tips & Tricks') {
      const TipsTricksInformation();
    }
  }

  //
  //
  // Settings Side Panel
  String _activeSetButtonId = '';

  String get activeSetButtonId => _activeSetButtonId;

  void setActiveSetButton(String setButtonId) {
    _activeSetButtonId = setButtonId;
    notifyListeners();
  }

  void callSetClassForButton(String setButtonId) {
    if (setButtonId == 'General') {
      GeneralSettingsInfo();
    } else if (setButtonId == 'Profile') {
      const ProfileSettingsInfo();
    } else if (setButtonId == 'Billing') {
      const BillingSettingsInfo();
    } else if (setButtonId == 'Accessibility') {
      const AccessSettingsInfo();
    } else if (setButtonId == 'Security') {
      const SecuritySettingsInfo();
    } else if (setButtonId == 'Policy') {
      const PrivacySettingsInfo();
    }
  }
}
