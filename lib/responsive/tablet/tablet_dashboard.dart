import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/tablet/tablet_constants.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../main.dart';
import '../../util/dashboard_decks.dart';
import 'tablet_artboard_page.dart';
import 'tablet_dock.dart';

//import 'package:responsive_framework/responsive_framework.dart';

class TabletDashboard extends StatefulWidget {
  const TabletDashboard({Key? key}) : super(key: key);

  @override
  State<TabletDashboard> createState() => _TabletDashboardState();
}

class _TabletDashboardState extends State<TabletDashboard> with AnimationMixin {
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
      appBar: tabAppBar(),
      body: Stack(
        children: [
          const TabArtBoardScreen(),
          Positioned.fill(
            child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30), child: const SizedBox()),
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
                            padding:
                                EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.035, 90, MediaQuery.of(context).size.width * 0.035, 15),
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
                                          const ProjectsDeck(),
                                          const SocialsDeck(),
                                          const FinancesDeck(),
                                          const NewsDeck(),
                                        )[index]
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabDock(
                    newGlow: red,
                    newGrad1: purp,
                    newGrad2: red,
                  )
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
