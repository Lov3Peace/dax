import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

class PcCarouselTemplate extends StatelessWidget {
  final Widget child;

  const PcCarouselTemplate({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w(context),
      decoration: BoxDecoration(
        // border: Border.all(color: const Color.fromARGB(182, 31, 31, 31)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }
}
