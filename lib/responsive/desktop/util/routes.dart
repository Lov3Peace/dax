import 'package:flutter_application_1/responsive/desktop/devPage.dart';
import 'package:flutter_application_1/responsive/desktop/node_test.dart';
import 'package:flutter_application_1/util/auth/onboarding_page.dart';
import '../../../util/imports.dart';

var routes = {
  '/': DesktopDashboard(),
  '/launch': OnboardingScreen(),
  '/dev': Devpage(),
  '/projects': DeskHeroProjectsPage(),
  '/communities': DeskHeroCommunitiesPage(),
  '/socials': DeskHeroSocialsPage(),
  '/news': DeskHeroNewsPage(),
  '/nodetest': NodeTest(),
};
