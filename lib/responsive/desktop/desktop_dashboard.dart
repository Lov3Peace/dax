import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/responsive/desktop/desktop_constants.dart';
import 'package:flutter_application_1/responsive/desktop/desktop_dock.dart';
import 'package:flutter_application_1/responsive/desktop/messages.dart';
import 'package:flutter_application_1/util/background.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';
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
              EdgeInsets.fromLTRB(screenWidth * .08, 30, screenWidth * .05, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'title',
                flightShuttleBuilder: flightShuttleBuilder,
                child: TitleBubble(
                  deckHeight: screenHeight * 0.07,
                  deckWidth: screenWidth * 0.15,
                  deckName: 'SMFH',
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
      body: ListView(
        children: [
          Container(
            height: 100.h,
            width: 100.w,
            // constraints: const BoxConstraints(minWidth: 2000, minHeight: 1000),
            child: Stack(
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
                    Future.delayed(const Duration(milliseconds: 300)).then((_) {
                      controller.playReverse();
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DesktopDock(),
                      Expanded(
                        child: ListView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40.h,
                                  width: 75.w,
                                  constraints: const BoxConstraints(
                                      minWidth: 800, minHeight: 600),
                                  child: AnimationLimiter(
                                    child: ListView.builder(
                                      // shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 3,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return AnimationConfiguration
                                            .staggeredList(
                                          delay:
                                              const Duration(milliseconds: 200),
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 700),
                                          child: ScaleAnimation(
                                            scale: 0.7,
                                            curve: Curves.easeOutBack,
                                            child: FadeInAnimation(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0.25.w,
                                                    0.25.w,
                                                    0.25.w,
                                                    0.25.w),
                                                child: deskDashboardDecks1(
                                                  deck1: FinancesDeck(),
                                                  deck2: ProjectsDeck(),
                                                  deck3: FinancesDeck(),
                                                )[index],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40.h,
                                  width: 75.w,
                                  constraints: const BoxConstraints(
                                      minWidth: 800, minHeight: 600),
                                  child: AnimationLimiter(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 2,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return AnimationConfiguration
                                            .staggeredList(
                                          delay:
                                              const Duration(milliseconds: 200),
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 700),
                                          child: ScaleAnimation(
                                            scale: 0.7,
                                            curve: Curves.easeOutBack,
                                            child: FadeInAnimation(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0.25.w,
                                                    0.25.w,
                                                    0.25.w,
                                                    0.25.w),
                                                child: deskDashboardDecks2(
                                                  deck4: SocialsDeck(),
                                                  deck5: NewsDeck(),
                                                )[index],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: ListView(
                      //     children: [
                      //       Column(
                      //         children: [
                      //           Expanded(
                      //             child: AnimationLimiter(
                      //               child: ListView.builder(
                      //                 // shrinkWrap: true,
                      //                 padding: EdgeInsets.fromLTRB(
                      //                     MediaQuery.of(context).size.width * 0.035,
                      //                     0,
                      //                     MediaQuery.of(context).size.width * 0.035,
                      //                     0),
                      //                 scrollDirection: Axis.horizontal,
                      //                 itemCount: 3,
                      //                 itemBuilder: (BuildContext context, int index) {
                      //                   return AnimationConfiguration.staggeredList(
                      //                     delay: const Duration(milliseconds: 200),
                      //                     position: index,
                      //                     duration: const Duration(milliseconds: 700),
                      //                     child: ScaleAnimation(
                      //                       scale: 0.7,
                      //                       curve: Curves.easeOutBack,
                      //                       child: FadeInAnimation(
                      //                         child: Padding(
                      //                             padding: const EdgeInsets.fromLTRB(
                      //                                 0, 0, 0, 0),
                      //                             child: Row(
                      //                               children: [
                      //                                 Container(
                      //                                     height: 40.h,
                      //                                     width: 25.w,
                      //                                     color: red),
                      //                                 Container(
                      //                                     height: 40.h,
                      //                                     width: 25.w,
                      //                                     color: purp),
                      //                                 Container(
                      //                                     height: 40.h,
                      //                                     width: 25.w,
                      //                                     color: blue),
                      //                               ],
                      //                             )),
                      //                       ),
                      //                     ),
                      //                   );
                      //                 },
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Messages(),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
