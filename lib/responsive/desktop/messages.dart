import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 200, minHeight: 750),
      // margin: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color.fromARGB(227, 0, 0, 0),
          Color.fromARGB(212, 16, 16, 16),
        ], transform: GradientRotation(180)),
        borderRadius: BorderRadius.circular(1.w),
        border: Border.all(color: const Color.fromARGB(149, 41, 41, 41)),
        boxShadow: const [
          // BoxShadow(
          //   blurRadius: 5,
          //   color: Color.fromARGB(255, 14, 14, 14),
          //   offset: Offset(5, 5),
          // ),
          //   BoxShadow(
          //     blurRadius: 10,
          //     color: Color.fromARGB(255, 37, 37, 37),
          //     offset: Offset(-5, -5),
          //   )
        ],
      ),

      height: 80.h,
      width: 15.w,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(1.w),
            child: Text(
              'Messages',
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(fontSize: 5.sp, height: 1.0),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(1.w, 0.5.h, 1.w, 0.5.h),
            child: Container(
              constraints: const BoxConstraints(minWidth: 500, minHeight: 600),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.w),
                color: const Color.fromARGB(227, 28, 28, 28),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Color.fromARGB(255, 0, 0, 0),
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              height: 65.h,
            ),
          )
        ],
      ),
    );
  }
}
