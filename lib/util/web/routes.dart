import '../imports.dart';
import 'package:flutter_animate/flutter_animate.dart';

var routes = {
  // ignore: prefer_const_constructors
  '/': (context) => ResponsiveLayout(
        mobileVersion: AuthCheck(),
        tabletVersion: AuthCheck(),
        desktopVersion: AuthCheck(),
      ).animate().fadeIn(begin: 50, duration: Duration(milliseconds: 300)),
  '/projects': (context) => DeskHeroProjectsPage(),
  '/socials': (context) => DeskHeroSocialsPage(),
  '/communities': (context) => DeskHeroCommunitiesPage(),
  '/news': (context) => DeskHeroNewsPage(),
};
