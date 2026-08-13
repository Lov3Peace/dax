import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';

class ShimmerButton extends StatefulWidget {
  ShimmerButton({
    super.key,
    required this.height,
    required this.width,
    required this.child,
    required this.animate,
    this.color = const Color.fromARGB(255, 255, 85, 0),
    this.borderColor = const Color.fromARGB(255, 250, 140, 140),
    this.padding = 0,
    this.animationCurve = Curves.linear,
    this.animationCurve2 = Curves.linear,
    this.borderRadius = 25,
  });

  final double height;
  final double width;
  final Widget child;
  final bool animate;
  final Color color;
  final Color borderColor;
  double padding;
  double borderRadius;
  Curve animationCurve;
  Curve animationCurve2;

  @override
  State<ShimmerButton> createState() => _ShimmerButtonState();
}

class _ShimmerButtonState extends State<ShimmerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: 1.seconds);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TactileButton(
        child: Container(
      height: widget.height,
      width: widget.width,
      padding: EdgeInsets.all(widget.padding),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        border: Border.all(color: widget.borderColor),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.child,
          OverflowBox(
            maxHeight: widget.height + widget.width,
            maxWidth: widget.height + widget.width,
            child: Animate(
              controller: animationController,
              autoPlay: widget.animate,
              effects: [
                RotateEffect(
                  curve: widget.animationCurve,
                  delay: 1.5.seconds,
                  duration: 2.seconds,
                ),
                ScaleEffect(
                  curve: widget.animationCurve2,
                  delay: 1.5.seconds,
                  duration: 2.seconds,
                  begin: const Offset(1, 1),
                  end: const Offset(1.2, 1.2),
                ),
                SlideEffect(
                  delay: 1.5.seconds,
                  duration: 2.seconds,
                  begin: Offset(0, 0),
                  end: Offset(0.2, 0),
                )
                // ShimmerEffect(
                //   curve: Curves.linear,
                //   delay: 1.5.seconds,
                //   duration: 1.seconds,
                // ),
              ],
              onPlay: (controller) {
                controller.loop(reverse: true);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [tran, widget.color],
                    stops: [0, 1],
                    // focalRadius: 1.5,
                    radius: 0.75,
                    center: Alignment(-0.2, 0),
                  ),
                ),
                // gradient: RadialGradient(
                //   colors: [Color.fromARGB(100, 250, 100, 100), tran],
                //   radius: 2,
                // ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
