// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_animations/simple_animations.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Control control = Control.play;
  @override
  void initState() {
    // create controller instances and use mirror animation behavior

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<double>(
      duration: const Duration(seconds: 1),
      control: control, // bind state variable to parameter
      tween: Tween(begin: -100.0, end: 100.0),
      builder: (context, value, child) {
        return Transform.translate(
          // animation that moves childs from left to right
          offset: Offset(value, 0),
          child: child,
        );
      },
      child: MaterialButton(
        // there is a button
        color: Colors.yellow,
        onPressed:
            toggleDirection, // clicking button changes animation direction
        child: const Text('Swap'),
      ),
    );
  }

  void toggleDirection() {
    // toggle between control instructions
    setState(() {
      control = (control == Control.play) ? Control.playReverse : Control.play;
    });
  }
}
//   bool _disappear = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             FadeOutParticle(
//               disappear: _disappear,
//               duration: const Duration(milliseconds: 700),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.flutter_dash,
//                     size: 52,
//                     color: Theme.of(context).primaryColorDark,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     'Fade out Particle',
//                     style: Theme.of(context).textTheme.headline6?.copyWith(
//                           fontWeight: FontWeight.w900,
//                         ),
//                   ),
//                 ],
//               ),
//               onAnimationEnd: () => print('animation ended'),
//             ),
//             const SizedBox(height: 150),
//             OutlinedButton(
//               onPressed: () => setState(() => _disappear = !_disappear),
//               child: Text(_disappear ? 'Reset' : 'Start'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
