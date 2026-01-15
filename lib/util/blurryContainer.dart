import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/responsive_shorthand.dart';

class BlurryContainer extends StatelessWidget {
  BlurryContainer(
      {super.key,
      this.height,
      this.width,
      this.borderRadius = 100,
      this.color = const Color.fromARGB(220, 22, 19, 22),
      required this.child,
      this.padding = 0});
  final double? height;
  final double? width;
  final Color color;
  final Widget child;
  final double borderRadius;

  final double padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1.5.w(context)),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Container(
          height: height,
          width: width,
          child: Stack(children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: SizedBox(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: color,
                border:
                    Border.all(color: const Color.fromARGB(182, 75, 75, 75)),
              ),
              // constraints: const BoxConstraints(minHeight: 500, minWidth: 700),
            ),
            child,
          ]),
        ),
      ),
    );
  }
}
