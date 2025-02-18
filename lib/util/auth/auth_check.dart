// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/desk_dashboard.dart';
import 'package:flutter_application_1/responsive/mobile/mobile_login/mobile_launch_page.dart';
import 'package:flutter_application_1/util/auth/onboarding_page.dart';
import 'package:flutter_application_1/responsive/responsive_layout.dart';
import 'package:flutter_application_1/responsive/tablet/tablet_dashboard.dart';
import '../../responsive/mobile/mobile_dashboard.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // ignore: prefer_const_constructors
            return ResponsiveLayout(
              // ignore: prefer_const_constructors
              mobileVersion: MobileDashboard(),
              // ignore: prefer_const_constructors
              tabletVersion: TabletDashboard(),
              // ignore: prefer_const_constructors
              desktopVersion: DesktopDashboard(),
            );
          } else {
            // ignore: prefer_const_constructors
            return ResponsiveLayout(
              desktopVersion: OnboardingScreen(),
              tabletVersion: OnboardingScreen(),
              mobileVersion: MobileLaunchPage(),
            );
          }
        },
      ),
    );
  }
}
