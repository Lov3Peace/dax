import 'package:flutter/material.dart';

class ProfileCardTwo extends StatelessWidget {
  const ProfileCardTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.business, size: 50, color: Colors.white),
        SizedBox(height: 10),
        Text(
          'Company Overview',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Leading tech company...',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ],
    );
  }
}
