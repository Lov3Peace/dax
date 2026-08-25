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
    this.rotationAnimationDuration = const Duration(seconds: 2),
    this.shimmerAnimationDuration = const Duration(seconds: 2),
    this.scaleAnimationDuration = const Duration(seconds: 2),
    this.slideAnimationDuration = const Duration(seconds: 2),
    this.rotationAnimationDelay = const Duration(seconds: 2),
    this.shimmerAnimationDelay = const Duration(seconds: 2),
    this.scaleAnimationDelay = const Duration(seconds: 2),
    this.slideAnimationDelay = const Duration(seconds: 2),
    this.rotationAnimationCurve = Curves.easeInOutSine,
    this.shimmerAnimationCurve = Curves.easeInOutSine,
    this.scaleAnimationCurve = Curves.easeInOutSine,
    this.slideAnimationCurve = Curves.easeInOutSine,
    this.borderRadius = 25,
  });

  final double height;
  final double width;
  final Widget child;
  final bool animate;
  final Color color;
  final Color borderColor;
  final Duration rotationAnimationDuration;
  final Duration shimmerAnimationDuration;
  final Duration scaleAnimationDuration;
  final Duration slideAnimationDuration;
  final Duration rotationAnimationDelay;
  final Duration shimmerAnimationDelay;
  final Duration scaleAnimationDelay;
  final Duration slideAnimationDelay;
  double padding;
  double borderRadius;
  Curve rotationAnimationCurve;
  Curve shimmerAnimationCurve;
  Curve scaleAnimationCurve;
  Curve slideAnimationCurve;

  @override
  State<ShimmerButton> createState() => _ShimmerButtonState();
}

class _ShimmerButtonState extends State<ShimmerButton>
    with SingleTickerProviderStateMixin {
  // controller
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
                  delay: widget.rotationAnimationDelay,
                  duration: widget.rotationAnimationDuration,
                  curve: widget.rotationAnimationCurve,
                ),
                ShimmerEffect(
                  angle: -45,
                  color: widget.color,
                  curve: widget.shimmerAnimationCurve,
                  delay: widget.shimmerAnimationDelay,
                  duration: widget.shimmerAnimationDuration,
                ),
              ],
              // this is causing a message to print out every time
              // because onPlay isn't called if autoPlay = false. I just
              // dont care...
              onPlay: (controller) {
                controller.loop(reverse: false);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [tran, widget.color],
                    stops: [0, 1],
                    // focalRadius: 1.5,
                    radius: 0.60,
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
