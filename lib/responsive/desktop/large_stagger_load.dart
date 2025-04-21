import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

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
      itemCount: ((widgets.length / 2)).ceil(),
      itemBuilder: (context, index) => Container(
        width: childWidth,
        height: childHeight,
        child: StaggerLoad(
          duration: 300,
          // had to use math and conditions for this. If the length of the
          // list is an odd number, only return the last item in the final
          // row (each row has two columns/items). Otherwise, return the item of the
          // list that has the index of (this listview's index * 2) for the first
          // column, and ((this listview's index * 2) + 1) for the second column (i think
          // this might scale with the amount of columns; like for 3 columns it would be
          // (this listview's index * 3) but im not sure yet; will test)
          widgets: (index * 2) + 1 >= widgets.length ? [widgets[index * 2]] : [widgets[index * 2], widgets[(index * 2) + 1]],
          scrollDirection: Axis.horizontal,
          delay: index <= 1 ? ((index + 1).abs() * 100) : 200, // experimenting with this
          scale: 1.02,
          layer: 1,
          padding: padding,
          physics: physics,
        ),
      ),
    );
  }
}
