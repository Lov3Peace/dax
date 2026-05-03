import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/util/responsive_shorthand.dart';

class BlurryContainer extends StatelessWidget {
  BlurryContainer(
      {super.key,
      this.height,
      this.width,
      this.borderRadius = 100,
      this.color = const Color.fromARGB(220, 22, 19, 22),
      this.constraints,
      required this.child,
      this.padding = const EdgeInsets.all(0)});
  final double? height;
  final double? width;
  final Color color;
  final Widget child;
  final double borderRadius;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: width,
        constraints: constraints,
        child: Stack(children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: SizedBox(),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: color,
              border: Border.all(color: deckBorderColor),
            ),
            // constraints: const BoxConstraints(minHeight: 500, minWidth: 700),
          ),
          Padding(
            padding: padding,
            child: child,
          ),
        ]),
      ),
    );
  }
}
