import 'package:flutter/material.dart';

import '../pages/main.dart';

class Background extends StatelessWidget {
  Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 21, 22, 34),
          Color.fromARGB(255, 24, 11, 27),
          Color.fromARGB(255, 21, 22, 34),
        ],
        transform: GradientRotation(180),
      )),
    );
  }
}
