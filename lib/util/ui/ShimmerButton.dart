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
        child: Animate(
      controller: animationController,
      autoPlay: true,
      effects: [
        ShimmerEffect(
          color: Color.fromARGB(255, 250, 140, 140),
          curve: Curves.fastOutSlowIn,
          delay: 3.seconds,
          duration: 1.seconds,
        )
      ],
      onPlay: (controller) {
        controller.loop(reverse: true);
      },
      child: Container(
        height: 5.h(context),
        width: 10.w(context),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 250, 140, 140)),
          borderRadius: BorderRadius.circular(50.w(context)),
          gradient: RadialGradient(
            colors: [tran, Color.fromARGB(255, 255, 85, 0)],
            stops: [0, 1],
            focalRadius: 0.5,
            radius: 2.5,
            center: Alignment(-0.2, 0),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                "Open",
                style: TextStyle(fontSize: 2.sp(context)),
              ),
            ),
            Animate(
                controller: animationController,
                autoPlay: true,
                effects: [
                  ShimmerEffect(
                    curve: Curves.linear,
                    delay: 2.seconds,
                    duration: 1.seconds,
                  )
                ],
                onPlay: (controller) {
                  controller.loop();
                },
                child: Container(
                  height: 5.h(context),
                  width: 10.w(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.w(context)),
                    // gradient: RadialGradient(
                    //   colors: [Color.fromARGB(100, 250, 100, 100), tran],
                    //   radius: 2,
                    // ),
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
