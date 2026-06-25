// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/homeDashboard/desktop_home_dashboard.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:simple_animations/simple_animations.dart';
import '../responsive/mobile/mob_constants.dart';
import '../responsive/mobile/mobile_dashboard.dart';

class HomeButton extends StatefulWidget {
  HomeButton(
      {super.key,
      required this.gradient1,
      required this.gradient2,
      required this.glow});
  Color gradient1;
  Color gradient2;
  Color glow;
  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  Control control = Control.stop;
  Color activeColor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: tran,
      shadowColor: tran,
      child: CustomAnimationBuilder<double>(
        control: control,
        startPosition: 0,
        tween: Tween(begin: 1.5, end: 1),
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
        child: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [widget.gradient1, widget.gradient2]),
              boxShadow: [
                BoxShadow(
                    color: widget.glow,
                    blurRadius: 10,
                    blurStyle: BlurStyle.solid)
              ],
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: IconButton(
            icon: const Icon(Icons.dashboard_rounded),
            highlightColor: tran,
            splashColor: tran,
            onPressed: pressed,
          ),
        ),
      ),
    );
  }

  void pressed() {
    // toggle between control instructions
    setState(() {
      if (screenWidth < 550) {
        control = Control.play;
        Future.delayed(const Duration(milliseconds: 200)).then((_) {
          Navigator.of(context).push(MaterialPageRoute(builder: (buildContext) {
            return const MobileDashboard();
          }));
        });
      } else if (screenWidth < 1100) {
        control = Control.play;
        Future.delayed(const Duration(milliseconds: 200)).then((_) {
          Navigator.of(context).push(MaterialPageRoute(builder: (buildContext) {
            return const MobileDashboard();
          }));
        });
      } else {
        control = Control.play;
        Future.delayed(const Duration(milliseconds: 200)).then((_) {
          Navigator.of(context).push(MaterialPageRoute(builder: (buildContext) {
            // ignore: prefer_const_constructors
            return DesktopDashboard();
          }));
        });
      }
    });
  }

  void reverseShrink() {
    setState(() {
      control = Control.playReverse;
    });
  }
}
