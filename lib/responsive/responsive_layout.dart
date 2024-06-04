import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileVersion;
  final Widget tabletVersion;
  final Widget desktopVersion;

  const ResponsiveLayout({
    super.key,
    required this.mobileVersion,
    required this.tabletVersion,
    required this.desktopVersion,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 550) {
        return mobileVersion;
      } else if (constraints.maxWidth < 1000) {
        return tabletVersion;
      } else {
        return desktopVersion;
      }
    });
  }
}
