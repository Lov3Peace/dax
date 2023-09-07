import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/tablet/tablet_dashboard.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../main.dart';
import '../tab_constants.dart';

class TabSignButton extends StatefulWidget {
  final Function()? onTap;

  TabSignButton({super.key, required this.onTap});

  @override
  State<TabSignButton> createState() => _TabSignButtonState();
}

class _TabSignButtonState extends State<TabSignButton> {
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
        onTap: pressed,
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 35),
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [purp, red]),
              boxShadow: const [
                BoxShadow(
                    color: red, blurRadius: 20, blurStyle: BlurStyle.solid)
              ],
              borderRadius: BorderRadius.all(Radius.circular(screenWidth / 4))),
          child: const Center(
            child: Text(
              'Sign In',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  void pressed() {
    // toggle between control instructions

    setState(() {
      control = Control.play;

      Future.delayed(const Duration(milliseconds: 200)).then((_) {
        Navigator.of(context).push(MaterialPageRoute(builder: (buildContext) {
          return const TabletDashboard();
        }));
      });
    });
  }

  void reverseShrink() {
    setState(() {
      control = Control.playReverse;
    });
  }
}
