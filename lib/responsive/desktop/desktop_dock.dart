import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/responsive/constants.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../util/home_button.dart';

class DesktopDock extends StatefulWidget {
  const DesktopDock({super.key});

  @override
  State<DesktopDock> createState() => _DesktopDockState();
}

class _DesktopDockState extends State<DesktopDock> with AnimationMixin {
  late Animation<double> scale;
  late Animation<double> opacity;
  void initState() {
    // TODO: implement initState

    scale = Tween<double>(begin: 1.0, end: 0.7).animate(controller);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'dock',
      child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(134, 10, 10, 10),
                    Color.fromARGB(230, 24, 24, 24),
                  ], transform: GradientRotation(180)),
                  borderRadius: BorderRadius.circular(50),
                  border:
                      Border.all(color: const Color.fromARGB(148, 37, 37, 37)),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color.fromARGB(255, 8, 8, 8),
                      offset: Offset(0, 0),
                    ),
                    // BoxShadow(
                    //   blurRadius: 10,
                    //   color: Color.fromARGB(255, 37, 37, 37),
                    //   offset: Offset(0, 0),
                    // )
                  ]),
              width: screenWidth * 0.12,
              height: screenHeight * 0.75,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                clipBehavior: Clip.antiAlias,
                children: [
                  /*PAGE 1
                  */
                  DockButton(icon: Ionicons.person_circle_outline),

                  //Home
                  HomeButton(
                    gradient1: purp,
                    gradient2: red,
                    glow: red,
                  ),

                  //Messages
                  DockButton(
                    icon: Ionicons.chatbox,
                  ),

                  //PAGE 2
                  DockButton(icon: Ionicons.settings_sharp),

                  //Wallet
                  DockButton(icon: Ionicons.wallet),

                  //Friends
                  DockButton(icon: Ionicons.people),

                  //PAGE 3
                  DockButton(icon: Ionicons.help_circle_outline),

                  //About Us/Info
                  DockButton(icon: Icons.info_sharp),

                  //Logout
                  DockButton(icon: Icons.logout_outlined),
                ],
              ))),
    );
  }
}
