import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../../../../util/gradient_label.dart';
import '../../../../../util/tactile_button.dart';

class ConnectionTactile extends StatefulWidget {
  final Function(int) onButtonTap;

  const ConnectionTactile({super.key, required this.onButtonTap});

  @override
  State<ConnectionTactile> createState() => ConnectionTactileState();
}

class ConnectionTactileState extends State<ConnectionTactile> {
  int selectedIndex = 0; // <-- this makes the first button look selected on load

  @override
  Widget build(BuildContext context) {
    final List<String> buttonLabels = ['All', 'Favorite', 'Partner'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(buttonLabels.length, (index) {
        final bool isSelected = selectedIndex == index;

        return TactileButton(
          onTap: () {
            setState(() => selectedIndex = index);
            widget.onButtonTap(index); // still trigger the linked page
          },
          child: GradientContainer(
            gradient1: isSelected ? red : Colors.transparent,
            gradient2: isSelected ? purp : Colors.transparent,
            height: 3.h(context),
            width: 7.w(context),
            neonGlow: tran,
            text: buttonLabels[index],
            textSize: 2.5.sp(context),
            borderColor: Colors.white38,
            borderRadius: 500,
          ),
        );
      }),
    );
  }
}
