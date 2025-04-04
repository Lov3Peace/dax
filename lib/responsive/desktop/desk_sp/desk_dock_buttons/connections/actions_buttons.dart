import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:ionicons/ionicons.dart';

class ActionsButtons extends StatelessWidget {
  const ActionsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TactileButton(
          child: Container(
            padding: EdgeInsets.fromLTRB(1.w(context), 0.5.w(context), 1.w(context), 0.5.w(context)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(1.5.w(context))), gradient: LinearGradient(colors: [purp, Colors.purple.shade300])),
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
            padding: EdgeInsets.fromLTRB(1.w(context), 0.5.w(context), 1.w(context), 0.5.w(context)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(1.5.w(context))),
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
