import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';

class ShimmerButton extends StatefulWidget {
  const ShimmerButton({super.key});

  @override
  State<ShimmerButton> createState() => _ShimmerButtonState();
}

class _ShimmerButtonState extends State<ShimmerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: 1.seconds);

  double gradientX = -0.2;
  double gradientY = 0;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TactileButton(
        child: Container(
      height: 4.5.h(context),
      width: 10.w(context),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 250, 140, 140)),
        borderRadius: BorderRadius.circular(50.w(context)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text("Open"),
          OverflowBox(
            maxHeight: 20.h(context),
            child: Animate(
              controller: animationController,
              autoPlay: true,
              effects: [
                RotateEffect(
                  curve: Curves.easeInToLinear,
                  // delay: 1.5.seconds,
                  duration: 2.seconds,
                ),
                ScaleEffect(
                  curve: Curves.easeOutBack,
                  delay: 1.seconds,
                  duration: 2.seconds,
                  begin: Offset(1, 1),
                  end: Offset(1.25, 1.25),
                )
                // ShimmerEffect(
                //   curve: Curves.linear,
                //   delay: 1.5.seconds,
                //   duration: 1.seconds,
                // ),
              ],
              onPlay: (controller) {
                controller.loop(reverse: true);
              },
              child: Container(
                height: 20.h(context),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [tran, Color.fromARGB(255, 255, 85, 0)],
                    stops: [0, 1],
                    focalRadius: 1,
                    radius: 1,
                    center: Alignment(-0.2, 0),
                  ),
                ),
                // gradient: RadialGradient(
                //   colors: [Color.fromARGB(100, 250, 100, 100), tran],
                //   radius: 2,
                // ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
