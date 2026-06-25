// ignore_for_file: prefer_const_constructors

import 'package:flutter_application_1/responsive/desktop/dashboard/homeDashboard/desktop_home_dashboard.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/communities/desk_hero_communities_page.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/desktop_projects_page.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectPostsPage.dart';
import 'package:flutter_application_1/responsive/desktop/devPage.dart';
import 'package:flutter_application_1/responsive/desktop/node_test.dart';
import 'package:flutter_application_1/util/auth/launch_page.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profilePage.dart';

var routes = {
  '/profile': ProfilePage(),
  '/': DesktopDashboard(),
  '/launch': LaunchPage(),
  '/dev': Devpage(),
  '/projects': DesktopProjectsPage(),
  '/project-posts': DesktopProjectPostsPage(),
  '/communities': DesktopCommunitiesPage(),
  '/nodetest': NodeTest(),
};
