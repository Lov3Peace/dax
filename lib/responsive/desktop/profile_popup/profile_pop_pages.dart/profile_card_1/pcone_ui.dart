import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:sizer/sizer.dart';

class PC1 extends StatelessWidget {
  PC1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(182, 31, 31, 31)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "images/creator.png",
            height: 38.h,
          ),
          Text(
            "Creator",
            style: TextStyle(color: white, fontSize: 5.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
