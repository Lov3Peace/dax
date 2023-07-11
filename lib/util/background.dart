import 'package:flutter/material.dart';

import '../pages/main.dart';

class Background extends StatefulWidget {
  Background({super.key});

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
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
