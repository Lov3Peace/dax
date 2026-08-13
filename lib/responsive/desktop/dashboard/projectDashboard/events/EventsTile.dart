import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/ShimmerButton.dart';

class EventsTile extends StatelessWidget {
  EventsTile(
      {super.key,
      required this.animate,
      this.color = const Color.fromARGB(255, 255, 85, 0),
      this.borderColor = const Color.fromARGB(255, 250, 140, 140)});
  final bool animate;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ShimmerButton(
      animate: animate,
      color: color,
      borderColor: borderColor,
      height: max(50, 8.w(context)),
      width: max(80, 10.w(context)),
      padding: 1.w(context),
      borderRadius: 1.w(context),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Today",
              style: TextStyle(
                  fontSize: 3.5.sp(context),
                  color: darkGrey,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "9:00AM",
            style:
                TextStyle(fontSize: 6.sp(context), fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
