import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class ActionsButtons extends StatelessWidget {
  const ActionsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TactileButton(
          child: Container(
            padding: EdgeInsets.fromLTRB(1.w, 0.5.w, 1.w, 0.5.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(1.5.w)), gradient: LinearGradient(colors: [purp, Colors.purple.shade300])),
            child: const Icon(
              Ionicons.chatbubble_sharp,
              size: 20,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        TactileButton(
          child: Container(
            padding: EdgeInsets.fromLTRB(1.w, 0.5.w, 1.w, 0.5.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(1.5.w)),
                gradient: LinearGradient(colors: [Colors.grey.shade800, Colors.grey.shade700])),
            child: const Icon(
              Ionicons.ellipsis_horizontal,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
