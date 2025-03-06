import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/communities_deck.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/profile_card.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/projects_deck.dart';
import 'package:flutter_application_1/responsive/desktop/desk_constants.dart';
import 'package:flutter_application_1/util/desk_dash_lists.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';

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
  });
  final List widgets;
  final double scale;
  final int layer;
  final int duration;
  final int delay;
  final Axis scrollDirection;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widgets.length,
        scrollDirection: scrollDirection,
        itemBuilder: (context, index) {
          return Container(
            padding: padding,
            child: widgets[index],
          )
              .animate()
              .fadeIn(
                duration: Duration(milliseconds: duration),
                delay: Duration(milliseconds: (index + 1) * delay * layer),
              )
              .scale(
                duration: Duration(milliseconds: duration),
                delay: Duration(milliseconds: (index + 1) * delay * layer),
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
