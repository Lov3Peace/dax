import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CarouselContentsTemp extends StatelessWidget {
  final Widget child;

  CarouselContentsTemp({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      width: 17.5.w,
      child: child,
    );
  }
}
