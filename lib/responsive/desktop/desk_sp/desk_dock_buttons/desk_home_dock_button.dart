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
    var buttonState = Provider.of<ButtonState>(context);
    bool isActive = buttonState.activeDeskButtonId == 'home';

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
          buttonState.setActiveDeskButton('home');
          buttonState.resetAllButtons();
          goHome();
        },
        child: Stack(
          children: [
            // Container(
            //   color: red,
            //   width: double.infinity,
            //   height: 3.h,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    // padding: EdgeInsets.only(left: isActive || isHover ? 10 : 0),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: tran,
                          spreadRadius: 1,
                          blurRadius: 0,
                          // changes position of shadow
                        ),
                      ],
                      gradient: const LinearGradient(colors: [red, pink]),
                      // color: LinearGradient(colors: colors),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    height: 4.h,
                    // margin: isHover ? EdgeInsets.only(right: 7.w) : EdgeInsets.only(right: 0.w),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: isHover ? 1.w : 11.15.w,
                  height: 2.h,
                )
              ],
            ),
            Positioned(
              top: 0.5.h,
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
                        color: isActive ? Colors.white : Colors.white,
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
