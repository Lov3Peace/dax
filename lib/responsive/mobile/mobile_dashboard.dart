import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/responsive/constants.dart';
import 'package:flutter_application_1/util/background.dart';
import 'package:flutter_application_1/util/decks.dart';
import 'package:flutter_application_1/util/dock.dart';
import 'package:flutter_application_1/util/projects_stacks_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../util/dashboard_decks.dart';
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
    /*
    double deckHeight = screenHeight * 0.22;
    double deckWidth = screenWidth * 0.90;
    double halfDeckWidth = screenWidth * 0.45;

    if (screenWidth < 550) {
      deckHeight = screenHeight * 0.22;
    } else if (screenWidth < 1100) {
      deckHeight = screenHeight * 0.24;
    } else {
      deckHeight = screenHeight * 0.26;
    } */

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: mobAppBar(),
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
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.035,
                                90,
                                MediaQuery.of(context).size.width * 0.035,
                                15),
                            itemCount: 3,
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
                                        mobTabDashboardDecks(
                                          ProjectsDeck(),
                                          SocialsDeck(),
                                          FinancesDeck(),
                                          NewsDeck(),
                                        )[index]
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
                  const Dock()
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
