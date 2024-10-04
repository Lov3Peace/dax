import 'package:flutter/material.dart';

class ProfileCardThree extends StatelessWidget {
  const ProfileCardThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, size: 50, color: Colors.yellow),
        SizedBox(height: 10),
        Text(
          'Achievements',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Multiple awards...',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ],
    );
  }
}
