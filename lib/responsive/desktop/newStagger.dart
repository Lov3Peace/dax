import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/util/test/test_container.dart';
import 'package:flutter_application_1/util/test/test_list.dart';

class NewStagger extends StatelessWidget {
  NewStagger({
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
    return SingleChildScrollView(
      child: Container(
        width: rowWidth,
        child: Column(
          children: [
            for (int i = 0; i < test_big_list.length; i++)
              Container(
                child: test_big_list[i],
              )
                  // animation chaining
                  .animate()
                  .fadeIn(
                    duration: Duration(milliseconds: duration),
                    delay: Duration(milliseconds: i * delay),
                    // eg. (2(2) + (1+2)) * 200 = 1400 [if the index=1 and layer=2 and delay=200]
                  )
                  .scale(
                    duration: Duration(milliseconds: duration),
                    delay: Duration(milliseconds: i * delay),
                    begin: const Offset(1.0, 1.0),
                    end:
                        Offset(scale, scale), // initial scale (eg. 1.0 => 1.05)
                  )
                  .then()
                  .scale(
                    duration: Duration(milliseconds: duration),
                    begin: Offset(scale, scale),
                    end: Offset(
                        1.0 / scale,
                        1.0 /
                            scale), // eg. 1.0/1.05 to get original scale value (resetting it to normal val of 1.0)
                  )
          ],
        ),
      ),
    );
  }
}
