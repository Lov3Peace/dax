import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/constants.dart';
import 'package:flutter_application_1/util/background.dart';
import 'package:flutter_application_1/util/dock.dart';
import 'package:flutter_application_1/util/projects_stacks_list.dart';
import '../util/dashboard_decks.dart';
import '../util/title_bubble.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//import 'package:responsive_framework/responsive_framework.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with AnimationMixin {
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
    double deckHeight = screenHeight * 0.22;
    double deckWidth = screenWidth * 0.90;
    double halfDeckWidth = screenWidth * 0.45;
    double profileBubbleHeight = screenHeight * 0.04;
    double profileBubbleWidth = screenWidth * 0.3;
    double titleBubbleHeight = screenHeight * 0.04;
    double titleBubbleWidth = screenWidth * 0.3;

    if (screenWidth < 550) {
      deckHeight = screenHeight * 0.22;
    } else if (screenWidth < 1100) {
      deckHeight = screenHeight * 0.24;
    } else {
      deckHeight = screenHeight * 0.26;
    }

    if (screenWidth < 550) {
      profileBubbleHeight = screenHeight * 0.05;
      titleBubbleHeight = screenHeight * 0.05;
      titleBubbleWidth = screenWidth * 0.4;
    } else if (screenWidth < 1100) {
      profileBubbleHeight = screenHeight * 0.04;
    } else {
      deckHeight = screenHeight * 0.26;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: mobTabAppBar(),
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
                            itemCount: mobTabDashboardDecks(
                              ProjectsDeck(),
                              SocialsDeck(),
                              FinancesDeck(),
                              NewsDeck(),
                            ).length,
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
                                            NewsDeck())[index]
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
