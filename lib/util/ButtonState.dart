import 'package:flutter/material.dart';
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
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

enum SlideType {
  info,
  help,
  settings,
  friend,
  wallet,
}

class ButtonState extends ChangeNotifier {
  // Slide control fields
  Control friendSlideControl;
  Control walletSlideControl;
  Control settingSlideControl;
  Control helpSlideControl;
  Control infoSlideControl;

// Active and hover desk button IDs
  String? activeDeskButtonId;
  String? hoverDeskButtonId;

  // Hero tags
  String projectsHeroTag;
  String socialsHeroTag;
  String financesHeroTag;
  String newsHeroTag;

  ButtonState({
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

  void setHoverDeskButton(String id) {
    hoverDeskButtonId = id;
    notifyListeners();
  }

  void clearHoverDeskButton(String id) {
    if (hoverDeskButtonId == id) {
      hoverDeskButtonId = null;
      notifyListeners();
    }
  }

  void setActiveDeskButton(String id) {
    if (activeDeskButtonId != null && activeDeskButtonId != id) {
      reverseSlide(getSlideType(activeDeskButtonId!));
    }
    activeDeskButtonId = id;
    notifyListeners();
  }

  void deactivateDeskButton() {
    activeDeskButtonId = null;
    notifyListeners();
  }

  SlideType getSlideType(String id) {
    switch (id) {
      case 'info':
        return SlideType.info;
      case 'help':
        return SlideType.help;
      case 'settings':
        return SlideType.settings;
      case 'friend':
        return SlideType.friend;
      case 'wallet':
        return SlideType.wallet;
      default:
        throw Exception('Unknown desk button ID');
    }
  }

  void callDeskFunctionForButton(String id) {
    activateSlide(getSlideType(id));
  }

  void activateSlide(SlideType slideType) {
    switch (slideType) {
      case SlideType.info:
        infoSlideControl = Control.play;
        break;
      case SlideType.help:
        helpSlideControl = Control.play;
        break;
      case SlideType.settings:
        settingSlideControl = Control.play;
        break;
      case SlideType.friend:
        friendSlideControl = Control.play;
        break;
      case SlideType.wallet:
        walletSlideControl = Control.play;
        break;
    }
    notifyListeners();
  }

  void reverseSlide(SlideType slideType) {
    switch (slideType) {
      case SlideType.info:
        infoSlideControl = Control.playReverse;
        break;
      case SlideType.help:
        helpSlideControl = Control.playReverse;
        break;
      case SlideType.settings:
        settingSlideControl = Control.playReverse;
        break;
      case SlideType.friend:
        friendSlideControl = Control.playReverse;
        break;
      case SlideType.wallet:
        walletSlideControl = Control.playReverse;
        break;
    }
    notifyListeners();
  }

  void resetSlide(SlideType slideType) {
    switch (slideType) {
      case SlideType.info:
        infoSlideControl = Control.stop;
        break;
      case SlideType.help:
        helpSlideControl = Control.stop;
        break;
      case SlideType.settings:
        settingSlideControl = Control.stop;
        break;
      case SlideType.friend:
        friendSlideControl = Control.stop;
        break;
      case SlideType.wallet:
        walletSlideControl = Control.stop;
        break;
    }
    notifyListeners();
  }

  void resetAllButtons() {
    resetSlide(SlideType.info);
    resetSlide(SlideType.help);
    resetSlide(SlideType.settings);
    resetSlide(SlideType.friend);
    resetSlide(SlideType.wallet);
    activeDeskButtonId = null;
    hoverDeskButtonId = null;
    notifyListeners();
  }

  void heroOff() {
    projectsHeroTag = 'projectsHero_Off';
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

  //
  //
  //Info Side Panel
  String _activeInfoButtonId = '';

  String get activeInfoButtonId => _activeInfoButtonId;

  void setActiveInfoButton(String infoButtonId) {
    _activeInfoButtonId = infoButtonId;
    notifyListeners();
  }

  void callInfoClassForButton(String infoButtonId) {
    if (infoButtonId == 'About Us') {
      const AboutUsInformation();
    } else if (infoButtonId == 'Contact Us') {
      const ContactUsInformation();
    } else if (infoButtonId == 'Goals') {
      const GoalsInformation();
    } else if (infoButtonId == 'Terms & Conditions') {
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
