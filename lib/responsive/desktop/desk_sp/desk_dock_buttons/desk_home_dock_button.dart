import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/auth/auth_check.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import '../../../../util/button_state.dart';

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
            width: 8.w,
            height: 1.h,
            margin: isHover ? EdgeInsets.only(right: 7.w) : EdgeInsets.only(right: 0.w)),
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
