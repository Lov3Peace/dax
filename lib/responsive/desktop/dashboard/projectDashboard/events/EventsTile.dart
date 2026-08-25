import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/ShimmerButton.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class EventsTile extends StatelessWidget {
  EventsTile({
    super.key,
    required this.day,
    required this.time,
    required this.animate,
    this.color = const Color.fromARGB(255, 255, 85, 0),
    this.borderColor = const Color.fromARGB(255, 250, 140, 140),
  });
  final String day;
  final String time;
  final bool animate;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ShimmerButton(
      animate: animate,
      shimmerAnimationDelay: 1.75.seconds,
      color: color,
      borderColor: borderColor,
      height: max(100, 8.w(context)),
      width: max(150, 10.w(context)),
      padding: 0.5.w(context),
      borderRadius: 1.w(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: TextStyle(
                fontSize: max(20, 3.5.sp(context)),
                color: darkGrey,
                fontWeight: FontWeight.bold),
          ),
          Text(
            time,
            style: TextStyle(
                fontSize: max(24, 5.5.sp(context)),
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
