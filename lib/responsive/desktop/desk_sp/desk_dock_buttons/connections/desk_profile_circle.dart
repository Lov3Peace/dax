import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:sizer/sizer.dart';

class ProfileCircle extends StatelessWidget {
  const ProfileCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Padding(
        //   padding: EdgeInsets.only(left: 1.75.w),
        //   child: Container(
        //     width: 7.w,
        //     height: 7.h,
        //     decoration: const BoxDecoration(
        //       gradient: LinearGradient(colors: [purp, red]),
        //       shape: BoxShape.circle,
        //       // color: Colors.grey,
        //     ),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.only(left: 1.5.w),
          child: Container(
            width: 7.w,
            height: 7.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade800, width: 3),
              shape: BoxShape.circle,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5.5.w, 5.h, 0, 0),
          child: Container(
            width: 2.w,
            height: 2.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 118, 123, 118),
            ),
          ),
        ),
      ],
    );
  }
}
