import 'package:flutter/material.dart';

import '../../../../../util/gradient_label.dart';

import '../../../../../util/imports.dart';
import '../../../../../util/tactile_button.dart';

class SelectableTactile extends StatefulWidget {
  const SelectableTactile({super.key});

  @override
  State<SelectableTactile> createState() => SelectableTactileState();
}

class SelectableTactileState extends State<SelectableTactile> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final List<String> buttonLabels = ['Transfer', 'Deposit', 'Send'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(buttonLabels.length, (index) {
        final bool isSelected = selectedIndex == index;

        return TactileButton(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: GradientContainer(
            gradient1: isSelected ? Colors.blue : Colors.transparent,
            gradient2: isSelected
                ? const Color.fromARGB(255, 85, 221, 89)
                : Colors.transparent,
            height: 1.h(context),
            width: 1.h(context),
            neonGlow: tran,
            text: buttonLabels[index],
            textSize: 3.sp(context),
            borderColor: Colors.white38,
            borderRadius: 500,
          ),
        );
      }),
    );
  }
}
