import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:simple_animations/simple_animations.dart';

class TactileButton extends StatefulWidget {
  TactileButton({super.key, required this.child, this.onTap, this.scale = 1.015});
  VoidCallback? onTap;
  double scale;
  Widget child;
  @override
  State<TactileButton> createState() => _TactileButtonState();
}

class _TactileButtonState extends State<TactileButton> with AnimationMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  double hoverScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Listener(
      // onPointerDown: (event) => pressed(),
      child: MouseRegion(
        onEnter: (event) => setState(() {
          hoverScale = widget.scale;
        }),
        onExit: (event) => setState(() {
          hoverScale = 1.0;
        }),
        cursor: SystemMouseCursors.click,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 100),
          scale: hoverScale,
          child: GestureDetector(
            onTap: widget.onTap,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
