import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:sizer/sizer.dart';

class PC1 extends StatelessWidget {
  PC1({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
