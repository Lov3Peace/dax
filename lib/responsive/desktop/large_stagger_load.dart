import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/util/test_container.dart';

class LargeStaggerLoad extends StatefulWidget {
  const LargeStaggerLoad({
    super.key,
    required this.widgets,
    required this.childHeight,
    required this.scale,
    required this.constraints,
    this.childWidth,
    this.listPadding,
    this.childPadding,
    this.physics,
  });

  final List widgets;
  final double scale;
  final BoxConstraints constraints;
  final double? childWidth;
  final double childHeight;
  final EdgeInsets? listPadding;
  final EdgeInsets? childPadding;
  final ScrollPhysics? physics;

  @override
  State<LargeStaggerLoad> createState() => _LargeStaggerLoadState();
}

class _LargeStaggerLoadState extends State<LargeStaggerLoad> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // scrollController.addListener(() {
    //   print(scrollController.offset);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ((widget.widgets.length / 2)).ceil(),
      controller: scrollController,
      padding: widget.listPadding,
      itemBuilder: (context, index) => Container(
        // width: widget.childWidth,
        constraints: widget.constraints,
        height: widget.childHeight,
        child: StaggerLoad(
          duration: 300,
          // had to use math and conditions for this. If the length of the
          // list is an odd number, only return the last item in the final
          // row (each row has two columns/items). Otherwise, return the item of the
          // list that has the index of (this listview's index * 2) for the first
          // column, and ((this listview's index * 2) + 1) for the second column (i think
          // this might scale with the amount of columns; like for 3 columns it would be
          // (this listview's index * 3) but im not sure yet; will test)
          widgets: (index * 2) + 1 >= widget.widgets.length
              ? [widget.widgets[index * 2]]
              : [widget.widgets[index * 2], widget.widgets[(index * 2) + 1]],
          scrollDirection: Axis.horizontal,
          // delay: index % 2 == 0 ? 400 : 600,
          delay: (index * widget.childHeight) < 100.h(context)
              ? (index * 100)
              : 300,
          scale: widget.scale,
          layer: 1,
          childPadding: widget.childPadding,
          physics: widget.physics,
        ),
      ),
    );
  }
}
