import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:sizer/sizer.dart';

class ProfileCircle extends StatelessWidget {
  const ProfileCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: .5.h,
        vertical: .3.h,
      ),
      child: Container(
        height: 8.h,
        width: 100.h,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(42, 41, 41, 0.631).withOpacity(0.1),
          // border: Border.all(
          //   color: Colors.white,
          //   width: 1,
          // ),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h),
          child: Stack(
            children: [
              Container(
                width: 13.w,
                height: 13.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [purp, red]),
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              Container(
                width: 12.5.w,
                height: 12.5.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.h, left: 4.5.h),
                child: Container(
                  width: 4.5.w,
                  height: 4.5.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 118, 123, 118),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
