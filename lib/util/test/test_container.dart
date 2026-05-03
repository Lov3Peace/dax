import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

class TestContainer extends StatelessWidget {
  const TestContainer(
      {super.key, required this.color, this.height = 50, this.width = 50});
  final Color color;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }
}
