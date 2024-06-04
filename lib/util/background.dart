import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  const Background({super.key});

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
          Color.fromARGB(255, 11, 12, 18),
          Color.fromARGB(255, 14, 6, 16),
          Color.fromARGB(255, 12, 13, 20),
        ],
        transform: GradientRotation(180),
      )),
    );
  }
}
