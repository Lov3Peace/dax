import 'package:flutter_application_1/responsive/desktop/devPage.dart';
import 'package:flutter_application_1/responsive/desktop/node_test.dart';
import 'package:flutter_application_1/util/auth/launch_page.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profilePage.dart';
import '../../../util/imports.dart';

var routes = {
  '/profile': ProfilePage(),
  '/': DesktopDashboard(),
  '/launch': LaunchPage(),
  '/dev': Devpage(),
  '/projects': DesktopProjectsPage(),
  '/project-posts': DesktopProjectPostsPage(),
  '/communities': DesktopCommunitiesPage(),
  '/socials': DesktopSocialsPage(),
  '/news': DesktopNewsPage(),
  '/nodetest': NodeTest(),
};
