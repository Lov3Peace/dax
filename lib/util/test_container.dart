import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

class TestContainer extends StatelessWidget {
  const TestContainer({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h(context),
      width: 35.w(context),
      color: color,
    );
  }
}
