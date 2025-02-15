import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/auth/auth_check.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import '../../../../util/button_state.dart';

class DeskHomeButton extends StatefulWidget {
  const DeskHomeButton({super.key});

  @override
  State<DeskHomeButton> createState() => _DeskHomeButtonState();
}

class _DeskHomeButtonState extends State<DeskHomeButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          isHover = true;
          // print(isHover);
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
          // print(isHover);
        });
      },
      child: GestureDetector(
        onTap: () {
          goHome();
        },
        child: Stack(
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [red, pink]),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  width: isHover ? 11.15.w : 0.25.w,
                  height: 5.h,
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    // color: blue,
                    height: 2.h,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 1.h,
              left: 0.5.w,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0.5.w),
                    child: Icon(
                      Icons.dashboard_rounded,
                      size: 3.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.5.w),
                    child: Text(
                      'Home',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(fontSize: 2.sp),
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goHome() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.linear);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          // ignore: prefer_const_constructors
          return AuthCheck();
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }
}
