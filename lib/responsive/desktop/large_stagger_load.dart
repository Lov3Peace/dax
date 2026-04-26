import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/util/test_container.dart';

class LargeStaggerLoad extends StatelessWidget {
  LargeStaggerLoad({
    super.key,
    required this.duration,
    required this.widgets,
    required this.delay,
    required this.rowWidth,
    this.scale = 1.015,
    this.layer = 1,
    this.scrollController,
    this.listPadding,
    this.childPadding,
    this.physics,
    this.childWidth,
    required this.childHeight,
    required this.itemsPerRow,
  });
  final List widgets;
  final double rowWidth;
  final int itemsPerRow;
  final double scale;
  final int layer;
  final int duration;
  final int delay;
  final double? childWidth;
  final double childHeight;
  final EdgeInsets? listPadding;
  final EdgeInsets? childPadding;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ((widgets.length / 2)).ceil(),
      controller: scrollController,
      padding: listPadding,
      itemBuilder: (context, index) => Container(
        // constraints: constraints,
        height: childHeight,
        width: rowWidth,
        child: StaggerLoad(
          childWidth: rowWidth / itemsPerRow,
          duration: 300,
          // childWidth: childWidth,
          // had to use math and conditions for this. If the length of the
          // list is an odd number, only return the last item in the final
          // row (each row has two columns/items). Otherwise, return the item of the
          // list that has the index of (this listview's index * 2) for the first
          // column, and ((this listview's index * 2) + 1) for the second column (i think
          // this might scale with the amount of columns; like for 3 columns it would be
          // (this listview's index * 3) but im not sure yet; will test)
          widgets: (index * 2) + 1 >= widgets.length
              ? [widgets[index * 2]]
              : [widgets[index * 2], widgets[(index * 2) + 1]],
          scrollDirection: Axis.horizontal,
          // delay: index % 2 == 0 ? 400 : 600,
          delay: (index * childHeight) < 100.h(context) ? (index * 100) : 300,
          scale: scale,
          layer: 3,
          childPadding: childPadding,
          physics: physics,
        ),
      ),
    );
  }
}
