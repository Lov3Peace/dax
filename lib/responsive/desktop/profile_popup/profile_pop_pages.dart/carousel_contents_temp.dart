import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

class CarouselContentsTemp extends StatelessWidget {
  final Widget child;

  CarouselContentsTemp({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h(context),
      width: 17.5.w(context),
      child: child,
    );
  }
}
