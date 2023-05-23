// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:simple_animations/simple_animations.dart';

class DockButton extends StatefulWidget {
  DockButton({super.key, required this.icon, this.onPressed});
  IconData icon;
  VoidCallback? onPressed;
  @override
  State<DockButton> createState() => _DockButtonState();
}

class _DockButtonState extends State<DockButton> {
  Control control = Control.stop;
  Color activeColor = Colors.white;
  Color inactiveColor = Colors.white30;
  Color currentColor = Colors.white30;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: tran,
      child: CustomAnimationBuilder<double>(
        control: control,
        startPosition: 0,
        tween: Tween(begin: 2, end: 1.5),
        duration: const Duration(milliseconds: 150),
        curve: Curves.linear,
        onCompleted: () {
          reverseShrink();
        },
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: IconButton(
          icon: Icon(widget.icon),
          color: currentColor,
          onPressed: toggleShrink,
          highlightColor: tran,
          splashColor: tran,
        ),
      ),
    );
  }

  void toggleShrink() {
    // toggle between control instructions
    setState(() {
      control = Control.play;
      currentColor =
          (currentColor == activeColor) ? inactiveColor : activeColor;
    });
  }

  void reverseShrink() {
    setState(() {
      control = Control.playReverse;
    });
  }
}
