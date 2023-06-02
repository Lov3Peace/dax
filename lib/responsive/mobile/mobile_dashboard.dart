import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import '../constants.dart';

class MobileDashboard extends StatefulWidget {
  const MobileDashboard({super.key});

  @override
  State<MobileDashboard> createState() => _MobileDashboardState();
}

class _MobileDashboardState extends State<MobileDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      extendBody: true,
      appBar: globalAppBar(
          profileBubbleHeight: screenHeight * 0.2,
          profileBubbleWidth: screenWidth * 0.3,
          titleBubbleHeight: screenHeight * 0.2,
          titleBubbleWidth: screenWidth * 0.3),
    );
  }
}
