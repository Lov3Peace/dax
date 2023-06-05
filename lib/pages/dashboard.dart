import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/constants.dart';
import 'package:flutter_application_1/util/dock.dart';
import 'package:flutter_application_1/util/projects_stacks_list.dart';
import '../util/dash_decks_list.dart';
import '../util/title_bubble.dart';
import 'main.dart';
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
  late double deckHeight;
  late double deckWidth;
  late double halfDeckWidth;
  final dashboardDecksList = dashboardDecks(0, 1, 2, 4);

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
      appBar: AppBar(
        backgroundColor: tran,
        shadowColor: tran,
        automaticallyImplyLeading: false,
        leadingWidth: MediaQuery.of(context).size.width * .9,
        flexibleSpace: Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.035,
              25,
              MediaQuery.of(context).size.width * 0.035,
              0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'title',
                flightShuttleBuilder: flightShuttleBuilder,
                child: TitleBubble(
                  deckHeight: MediaQuery.of(context).size.height * 0.1,
                  deckWidth: MediaQuery.of(context).size.width * 0.4,
                  deckName: 'Dashboard',
                  gradient1: tran,
                  gradient2: tran,
                  neonGlow: tran,
                ),
              ),
              Hero(
                tag: 'profile',
                flightShuttleBuilder: flightShuttleBuilder,
                child: ProfileBubble(
                  deckHeight: MediaQuery.of(context).size.height * 0.1,
                  deckWidth: MediaQuery.of(context).size.width * 0.30,
                  deckName: 's3rv',
                  gradient1: tran,
                  gradient2: tran,
                  neonGlow: tran,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth < 550) {
              deckHeight = screenHeight * 0.22;
              deckWidth = screenWidth * 0.90;
              halfDeckWidth = screenWidth * 0.41;
              return const Dashboard();
            } else if (constraints.maxWidth < 1100) {
              deckHeight = screenHeight * 0.23;
              deckWidth = screenWidth * 0.90;
              halfDeckWidth = screenWidth * 0.41;
              return const Dashboard();
            } else {
              deckHeight = screenHeight * 0.24;
              return const Dashboard();
            }
          }),
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
                                        dashboardDecks(
                                            ProjectsDeck(
                                                deckHeight: deckHeight,
                                                deckWidth: deckWidth),
                                            SocialsDeck(
                                                deckHeight: deckHeight,
                                                deckWidth: deckWidth),
                                            FinancesDeck(
                                              deckHeight: deckHeight,
                                              deckWidth: deckWidth,
                                              halfDeckWidth: halfDeckWidth,
                                            ),
                                            NewsDeck(
                                              deckHeight: deckHeight,
                                              deckWidth: deckWidth,
                                              halfDeckWidth: halfDeckWidth,
                                            )).dashboardDecks[index],
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
