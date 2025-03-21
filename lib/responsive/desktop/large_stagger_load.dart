import 'package:flutter/material.dart';

import 'package:flutter_application_1/util/imports.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/util/test_container.dart';

class LargeStaggerLoad extends StatelessWidget {
  const LargeStaggerLoad({
    super.key,
    required this.widgets,
    required this.childWidth,
    required this.childHeight,
    this.padding,
    this.physics,
  });

  final List widgets;
  final double childWidth;
  final double childHeight;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widgets.length,
      itemBuilder: ((context, index) => Container(
            width: childWidth,
            height: childHeight,
            child: StaggerLoad(
              duration: 300,
              widgets: [widgets[index], widgets[(index + 1) * 2]],
              scrollDirection: Axis.horizontal,
              delay: 200,
              scale: 1.03,
              layer: 1,
              padding: padding,
              physics: physics,
            ),
          )),
    );
  }
}
