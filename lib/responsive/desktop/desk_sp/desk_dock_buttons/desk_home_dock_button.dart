import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/auth/auth_check.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import '../../../../util/button_state.dart';

class DeskHomeWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  DeskHomeWindowButton({super.key, required, required this.dockIcon});
  Widget dockIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Material(
        color: tran,
        child: dockIcon,
      ),
    );
  }
}

class DeskHomeDockButton extends StatefulWidget {
  const DeskHomeDockButton({super.key});

  @override
  State<DeskHomeDockButton> createState() => _DeskHomeDockButtonState();
}

class _DeskHomeDockButtonState extends State<DeskHomeDockButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    var buttonState = Provider.of<ButtonState>(context);
    bool isActive = buttonState.activeDeskButtonId == 'home';

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5.h, 0, 1.5.h),
      child: DeskHomeWindowButton(
        dockIcon: Material(
          color: Colors.transparent,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (event) {
              setState(() {
                isHover = true;
              });
            },
            onExit: (event) {
              setState(() {
                isHover = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                buttonState.setActiveDeskButton('home');
                buttonState.resetAllButtons();
                goHome();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: isActive || isHover ? const EdgeInsets.only(left: 10) : const EdgeInsets.only(left: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: isActive || isHover ? Colors.black87 : Colors.transparent),
                  boxShadow: [
                    BoxShadow(
                      color: isActive
                          ? Colors.white
                          : isHover
                              ? Colors.grey.shade700
                              : Colors.transparent,
                    ),
                  ],
                  gradient: isActive
                      ? const LinearGradient(
                          colors: [red, purp],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                ),
                width: 13.w,
                height: 5.h,
                alignment: Alignment.centerLeft,
                child: addElement(isActive, isHover),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addElement(bool isActive, bool isHover) {
    return Padding(
      padding: EdgeInsets.only(left: 0.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.dashboard_rounded,
            color: isActive
                ? Colors.white70
                : isHover
                    ? const Color.fromARGB(241, 255, 255, 255)
                    : Colors.white70,
            size: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: .5.w),
            child: Text(
              'Home',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 2.sp),
                fontWeight: FontWeight.w400,
                color: isActive ? Colors.white : Colors.white54,
              ),
            ),
          ),
        ],
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
          return const AuthCheck();
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }
}
