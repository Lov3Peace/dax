import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/util/error_page.dart';
import 'package:flutter_application_1/responsive/desktop/util/test_page.dart';

import '../../../util/imports.dart';
import 'package:flutter_animate/flutter_animate.dart';

var routes = {
  '/': AuthCheck(),
  '/projects': DeskHeroProjectsPage(),
  '/communities': DeskHeroCommunitiesPage(),
  '/socials': DeskHeroSocialsPage(),
  '/news': DeskHeroNewsPage(),
};
