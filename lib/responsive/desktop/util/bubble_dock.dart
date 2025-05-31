import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/util/imports.dart';

import '../../../util/soft_close.dart';
import '../desk_dock_bubbles.dart';
import '../desk_decks.dart';

class BubbleDock extends StatelessWidget {
  const BubbleDock({super.key, required this.child1, required this.child2, required this.child3});
  final Widget child1;
  final Widget child2;
  final Widget child3;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.75.w(context)),
      height: 7.h(context),
      constraints: BoxConstraints(minHeight: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.w(context)),
        color: const Color.fromARGB(185, 21, 19, 22),
        border: Border.all(color: deckBorderColor),
      ),
      // padding: EdgeInsets.fromLTRB(1.w(context), 1.sp(context), 1.w(context), 1.sp(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(child: child1)
              .animate()
              .slideX(
                  begin: 0.25,
                  end: 0,
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 400),
                  curve: const SoftClose())
              .fadeIn(begin: 0, duration: const Duration(milliseconds: 500)),
          SizedBox(child: child2)
              .animate()
              .slideX(
                  begin: 0.25,
                  end: 0,
                  delay: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 400),
                  curve: const SoftClose())
              .fadeIn(begin: 0, duration: const Duration(milliseconds: 500)),
          SizedBox(child: child3)
              .animate()
              .slideX(
                  begin: 0.25,
                  end: 0,
                  delay: const Duration(milliseconds: 600),
                  duration: const Duration(milliseconds: 400),
                  curve: const SoftClose())
              .fadeIn(begin: 0, duration: const Duration(milliseconds: 500)),
        ],
      ),
    );
  }
}
