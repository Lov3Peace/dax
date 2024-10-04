import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileCircle extends StatelessWidget {
  const ProfileCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4.5.w,
      height: 4.5.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade800, width: 3),
        shape: BoxShape.circle,
        color: Colors.grey.shade700,
      ),
    );
  }
}
