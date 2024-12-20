import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ContactUsInformation extends StatelessWidget {
  const ContactUsInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 72.5.h,
        width: 45.w,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(25, 25, 29, 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ));
  }
}
