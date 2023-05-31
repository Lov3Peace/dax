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
      backgroundColor: tran,
      extendBody: true,
      appBar: myAppBar,
    );
  }
}
