import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/mobile/mob_constants.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'mob_artboard_page.dart';
import 'mobile_dock.dart';
//import 'package:responsive_framework/responsive_framework.dart';

class MobileDashboard extends StatefulWidget {
  const MobileDashboard({Key? key}) : super(key: key);

  @override
  State<MobileDashboard> createState() => _MobileDashboardState();
}

class _MobileDashboardState extends State<MobileDashboard> with AnimationMixin {
  //globals
  late Animation<double> scale;
  late Animation<double> opacity;
  late AnimationController widthController;
  late AnimationController heightController;
  late AnimationController colorController;

  //final dashboardDecksList = dashboardDecks(0, 1, 2, 4);

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: mobAppBar(),
      body: Stack(
        children: [
          const ArtBoardScreen(),
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
                SizedBox(
                  height: 60.h(context),
                  // color: red,
                  child: AnimationLimiter(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.035,
                          90,
                          MediaQuery.of(context).size.width * 0.035,
                          0),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          delay: const Duration(milliseconds: 200),
                          position: index,
                          duration: const Duration(milliseconds: 700),
                          child: ScaleAnimation(
                            scale: 0.7,
                            curve: Curves.easeOutBack,
                            child: FadeInAnimation(
                              // child: mobTabDashboardDecks1(
                              //   const ProjectsDeck(),
                              //   const SocialsDeck(),
                              // )[index],
                              child: BlurryContainer(
                                child: SizedBox(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h(context),
                  // color: red,
                  child: AnimationLimiter(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          delay: const Duration(milliseconds: 200),
                          position: index,
                          duration: const Duration(milliseconds: 700),
                          child: ScaleAnimation(
                            scale: 0.7,
                            curve: Curves.easeOutBack,
                            child: FadeInAnimation(
                              child: BlurryContainer(child: SizedBox()),
                              // child: mobTabDashboardDecks2(
                              //   Padding(
                              //     padding: EdgeInsets.fromLTRB(
                              //         MediaQuery.of(context).size.width * 0.035,
                              //         0,
                              //         0,
                              //         15),
                              //     child: const FinancesDeck(),
                              //   ),
                              //   Padding(
                              //     padding: EdgeInsets.fromLTRB(
                              //         MediaQuery.of(context).size.width * 0.035,
                              //         0,
                              //         0,
                              //         15),
                              //     child: const NewsDeck(),
                              //   ),
                              // )[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                MobDock(newGlow: red, newGrad1: purp, newGrad2: red)
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }
}
