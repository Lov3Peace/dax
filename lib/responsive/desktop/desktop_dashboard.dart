import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/projects_page.dart';
import 'package:flutter_application_1/responsive/constants.dart';
import 'package:flutter_application_1/util/background.dart';
import 'package:flutter_application_1/util/dock.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../util/dash_decks_list.dart';

//import 'package:responsive_framework/responsive_framework.dart';
final dashboardDecksList = dashboardDecks(0, 1, 2, 4);

class DesktopDashboard extends StatefulWidget {
  const DesktopDashboard({Key? key}) : super(key: key);

  @override
  State<DesktopDashboard> createState() => _DesktopDashboardState();
}

class _DesktopDashboardState extends State<DesktopDashboard>
    with AnimationMixin {
  late Animation<double> scale;
  late Animation<double> opacity;
  late AnimationController widthController;
  late AnimationController heightController;
  late AnimationController colorController;

  @override
  void initState() {
    // TODO: implement initState
    scale = Tween<double>(begin: 1.0, end: 0.9).animate(controller);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    controller.stop();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (screenHeight < 1) {}
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: globalAppBar(
          profileBubbleHeight: screenHeight * 0.2,
          profileBubbleWidth: screenWidth * 0.3,
          titleBubbleHeight: screenHeight * 0.2,
          titleBubbleWidth: screenWidth * 0.3),
      body: Stack(
        children: [
          Background(),
          Positioned.fill(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: const SizedBox()),
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  controller.play();
                });
                Future.delayed(const Duration(milliseconds: 500)).then((_) {
                  controller.playReverse();
                });
              },
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        AnimationLimiter(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(screenWidth * 0.035,
                                90, screenWidth * 0.035, 15),
                            itemCount: dashboardDecksList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                delay: const Duration(milliseconds: 200),
                                position: index,
                                duration: const Duration(milliseconds: 700),
                                child: ScaleAnimation(
                                  scale: 0.7,
                                  curve: Curves.easeOutBack,
                                  child: FadeInAnimation(
                                    child: Column(
                                      children: [
                                        //dashboardDecks().dashboardDecks[index],
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: Column(
                        //     children: ProjectStacks().projectStacks,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: Column(
                        //     children: ProjectStacks2().projectStacks2,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  //const DesktopDock()
                ],
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
