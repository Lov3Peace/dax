import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/responsive/constants.dart';
import 'package:flutter_application_1/util/background.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../util/desk_dashboard_decks.dart';
//import 'package:responsive_framework/responsive_framework.dart';

class DesktopDashboard extends StatefulWidget {
  const DesktopDashboard({Key? key}) : super(key: key);

  @override
  State<DesktopDashboard> createState() => _DesktopDashboardState();
}

class _DesktopDashboardState extends State<DesktopDashboard>
    with AnimationMixin {
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
      appBar: AppBar(
        backgroundColor: tran,
        shadowColor: tran,
        automaticallyImplyLeading: false,
        leadingWidth: screenWidth * 0.9,
        toolbarHeight: lerpDouble(0, 18, 8),
        flexibleSpace: Padding(
          padding:
              EdgeInsets.fromLTRB(screenWidth * .05, 30, screenWidth * .05, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'title',
                flightShuttleBuilder: flightShuttleBuilder,
                child: TitleBubble(
                  deckHeight: screenHeight * 0.07,
                  deckWidth: screenWidth * 0.30,
                  deckName: 'Dashboard',
                  gradient1: tran,
                  gradient2: tran,
                  neonGlow: tran,
                  textSize: titleTextSize,
                  leftPad: 30,
                ),
              ),
            ],
          ),
        ),
      ),
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
              child: Row(
                children: [
                  Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
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
                                child: deskDashboardDecks(
                                  lane1: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FinancesDeck(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ProjectsDeck(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FinancesDeck(),
                                      )
                                    ],
                                  ),
                                  lane2: FinancesDeck(),
                                  lane3: SocialsDeck(),
                                )[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
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
