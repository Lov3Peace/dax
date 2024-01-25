import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import '../util/gradient_container.dart';

class TactileButton extends StatefulWidget {
  TactileButton(
      {super.key, required this.child, this.onTap, this.scale = 0.95});
  VoidCallback? onTap;
  double? scale;
  Widget child;
  State<TactileButton> createState() => _TactileButtonState();
}

late Animation<double> scale;
Control control = Control.stop;

class _TactileButtonState extends State<TactileButton> with AnimationMixin {
  @override
  void initState() {
    // TODO: implement initState
    scale = Tween<double>(begin: 1.0, end: 0.9).animate(controller);
    // controller.stop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<double>(
      control: control,
      startPosition: 0,
      tween: Tween(begin: 1.0, end: widget.scale),
      duration: const Duration(milliseconds: 100),
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
      child: Listener(
        onPointerDown: (event) => pressed(),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onTap,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  void pressed() {
    setState(() {
      control = Control.play;
    });
  }

  void reverseShrink() {
    setState(() {
      control = Control.playReverse;
    });
  }
}
