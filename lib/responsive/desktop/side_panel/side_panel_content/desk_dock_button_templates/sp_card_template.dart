import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

class SPCardTemplate extends StatelessWidget {
  final double height;
  final double width;
  final double blurX;
  final double blurY;
  final double borderRadius;
  final double elevation;
  final Color backgroundColor;
  final Color borderColor;
  final Widget? child;
  final Alignment alignment;

  const SPCardTemplate({
    super.key,
    required this.height,
    required this.width,
    this.blurX = 20,
    this.blurY = 20,
    this.borderRadius = 24,
    this.elevation = 2,
    this.backgroundColor = const Color.fromARGB(140, 20, 20, 30),
    this.borderColor = const Color.fromRGBO(100, 100, 100, 0.5),
    this.child,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: alignment,
      child: Stack(
        alignment: alignment,
        children: [
          SizedBox(
            height: 77.h(context),
            width: 65.w(context),
            child: Material(
              shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
              color: backgroundColor,
              elevation: elevation,
              borderRadius: BorderRadius.circular(borderRadius + 8),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: blurX, sigmaY: blurY),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
