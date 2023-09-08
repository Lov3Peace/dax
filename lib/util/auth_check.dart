import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desktop_dashboard.dart';
import 'package:flutter_application_1/responsive/mobile/login%20ui%20final/onboarding_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/responsive/responsive_layout.dart';
import 'package:flutter_application_1/responsive/tablet/tablet_dashboard.dart';
import '../responsive/mobile/mobile_dashboard.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // ignore: prefer_const_constructors
            return ResponsiveLayout(
              mobileVersion: MobileDashboard(),
              tabletVersion: TabletDashboard(),
              desktopVersion: DesktopDashboard(),
            );
          } else {
            return OnboardingScreen();
          }
        },
      ),
    );
  }
}
