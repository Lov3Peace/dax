import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desktop_dashboard.dart';
import 'package:flutter_application_1/responsive/tablet/tablet_dashboard.dart';
import 'package:flutter_application_1/util/auth_check.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../main.dart';
import '../mob_constants.dart';
import '../mobile_dashboard.dart';

class SignButton extends StatefulWidget {
  final Function()? onTap;

  SignButton({super.key, required this.onTap});

  @override
  State<SignButton> createState() => _SignButtonState();
}

class _SignButtonState extends State<SignButton> {
  //controlls button
  Control control = Control.stop;

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<double>(
      control: control,
      startPosition: 0,
      tween: Tween(begin: 1.0, end: 0.8),
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
      onCompleted: () {
        reverseShrink();
      },
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: GestureDetector(
          // onTap: null,
          // child: Container(
          //   padding: const EdgeInsets.all(15),
          //   margin: const EdgeInsets.symmetric(horizontal: 35),
          //   decoration: BoxDecoration(
          //       gradient: const LinearGradient(colors: [purp, red]),
          //       boxShadow: const [
          //         BoxShadow(
          //             color: red, blurRadius: 10, blurStyle: BlurStyle.solid)
          //       ],
          //       borderRadius: BorderRadius.all(Radius.circular(screenWidth / 4))),
          //   child: const Center(
          //     child: Text(
          //       'Sign In',
          //       style: TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 1),
          //     ),
          //   ),
          // ),
          ),
    );
  }

  void pressed() {
    // toggle between control instructions

    setState(() {
      control = Control.play;

      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.linear);
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              if (screenWidth < 550) {
                // ignore: prefer_const_constructors
                return MobileDashboard(
                    // transitionAnimation: animation,
                    );
              } else if (screenWidth < 1100) {
                // ignore: prefer_const_constructors
                return TabletDashboard(
                    // transitionAnimation: animation,
                    );
              } else {
                // ignore: prefer_const_constructors
                return DesktopDashboard(
                    // transitionAnimation: animation,
                    );
              }
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      });
    });
  }

  void reverseShrink() {
    setState(() {
      control = Control.playReverse;
    });
  }
}
