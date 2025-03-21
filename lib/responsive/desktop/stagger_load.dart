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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widgets.length,
        scrollDirection: scrollDirection,
        physics: physics,
        itemBuilder: (context, index) {
          return Container(
            padding: padding,
            child: widgets[index],
          )
              .animate()
              .fadeIn(
                duration: Duration(milliseconds: duration),
                // delay: Duration(milliseconds: (layer * ((index + 1) * delay)) + delay),
                delay: Duration(milliseconds: ((2 * layer) + (index + layer)) * delay),
                // Ex. (2(1) + (2+1) * 200 = 1200
              )
              .scale(
                duration: Duration(milliseconds: duration),
                delay: Duration(milliseconds: ((2 * layer) + (index + layer)) * delay),
                begin: Offset(1.0, 1.0),
                end: Offset(scale, scale),
              )
              .then()
              .scale(
                duration: Duration(milliseconds: duration),
                begin: Offset(scale, scale),
                end: Offset(1.0 / scale, 1.0 / scale),
              );
        });
  }
}
