import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'constants.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({super.key});

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tran,
      extendBodyBehindAppBar: true,
      appBar: myAppBar,
    );
  }
}
