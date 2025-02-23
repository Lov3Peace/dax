import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/communities_deck.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/profile_card.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/projects_deck.dart';
import 'package:flutter_application_1/responsive/desktop/desk_constants.dart';
import 'package:flutter_application_1/util/desk_dash_lists.dart';

import '../../main.dart';

class StaggerLoad extends StatelessWidget {
  const StaggerLoad({super.key, required this.duration, required this.widgets, required this.scrollDirection});
  final List widgets;
  final int duration;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //     itemCount: widgets.length,
    //     itemBuilder: (context, index) => Container(height: 50, width: 50, color: red)
    //         .animate()
    //         .fadeIn(duration: Duration(milliseconds: duration), delay: Duration(milliseconds: (index + 1) * 200))
    //         .scale(duration: Duration(milliseconds: duration), begin: Offset(1, 1), end: Offset(1.1, 1.1)));
    return ListView.builder(
        itemCount: widgets.length,
        scrollDirection: scrollDirection,
        itemBuilder: (context, index) {
          return Container(child: widgets[index])
              .animate()
              .fadeIn(duration: Duration(milliseconds: duration), delay: Duration(milliseconds: (index + 1) * 200))
              .scale(duration: Duration(milliseconds: duration), begin: Offset(1, 1), end: Offset(1.1, 1.1));
        });
  }
}
