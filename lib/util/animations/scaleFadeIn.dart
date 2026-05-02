import 'package:flutter_animate/flutter_animate.dart';

import '../imports.dart';

class ScaleFadeIn extends StatelessWidget {
  const ScaleFadeIn({
    super.key,
    required this.child,
    required this.duration,
    required this.delay,
    this.scale = 1.015,
  });
  final Widget child;
  final int duration;
  final int delay;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(child: child)
        .animate()
        .fadeIn(
            duration: Duration(milliseconds: duration),
            delay: Duration(milliseconds: delay))
        .scale(
          duration: Duration(milliseconds: duration),
          delay: Duration(milliseconds: delay),
          begin: Offset(1.0, 1.0),
          end: Offset(scale, scale), // initial scale (eg. 1.0 => 1.05)
        )
        .then()
        .scale(
          duration: Duration(milliseconds: duration),
          begin: Offset(scale, scale),
          end: Offset(
              1.0 / scale,
              1.0 /
                  scale), // eg. 1.0/1.05 to get original scale value (resetting it to normal val of 1.0)
        );
  }
}
