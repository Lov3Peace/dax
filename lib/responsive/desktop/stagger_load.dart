import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StaggerLoad extends StatelessWidget {
  const StaggerLoad({
    super.key,
    required this.duration,
    required this.widgets,
    required this.scrollDirection,
    required this.delay,
    required this.scale,
    required this.layer,
    this.controller,
    this.padding,
    this.physics,
  });
  final List widgets;
  final double scale;
  final int layer;
  final int duration;
  final int delay;
  final Axis scrollDirection;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widgets.length, // the length of the listview is the length of the list passed into it
        scrollDirection: scrollDirection,
        physics: physics,
        controller: controller,
        itemBuilder: (context, index) {
          return Container(
            padding: padding,
            child: widgets[index], //
            // animation chaining
          )
              .animate()
              .fadeIn(
                duration: Duration(milliseconds: duration),
                delay: Duration(milliseconds: ((2 * layer) + (index + layer)) * delay),
                // eg. (2(2) + (1+2)) * 200 = 1400 [if the index=1 and layer=2 and delay=200]
              )
              .scale(
                duration: Duration(milliseconds: duration),
                delay: Duration(milliseconds: ((2 * layer) + (index + layer)) * delay),
                begin: Offset(1.0, 1.0),
                end: Offset(scale, scale), // initial scale (eg. 1.0 => 1.05)
              )
              .then()
              .scale(
                duration: Duration(milliseconds: duration),
                begin: Offset(scale, scale),
                end: Offset(1.0 / scale,
                    1.0 / scale), // eg. 1.0/1.05 to get original scale value (resetting it to normal val of 1.0)
              );
        });
  }
}
