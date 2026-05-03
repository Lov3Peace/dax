import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/test/test_container.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Vis extends StatelessWidget {
  const Vis({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: Key("1"), onVisibilityChanged: (info) => true, child: child);
  }
}
