import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/projects_deck.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/stagger_load.dart';
import 'package:sizer/sizer.dart';
import '../../mobile/mob_artboard_page.dart';
import '../desk_sp/desk_side_panel.dart';
import 'package:rive/rive.dart' as r;

import '../messages.dart';

//import 'package:responsive_framework/responsive_framework.dart';

class DesktopDashboard extends StatefulWidget {
  const DesktopDashboard({Key? key}) : super(key: key);

  @override
  State<DesktopDashboard> createState() => _DesktopDashboardState();
}

class _DesktopDashboardState extends State<DesktopDashboard> {
  //globals
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // final heroReset = context.read<ButtonState>();
    // heroReset.heroReset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: 100.h,
          // width: 100.w,
          constraints: 100.w > 1920 ? BoxConstraints(minHeight: 1440) : BoxConstraints(minHeight: 900),
          child: Stack(
            children: [
              // Background(),
              ArtBoardScreen(),

              Row(
                children: [
                  DesktopSidePanel(),
                  Container(
                    height: 90.h,
                    constraints: 100.w > 1920 ? BoxConstraints(minHeight: 1440) : BoxConstraints(minHeight: 900),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // This padding adds a little bit more to the left for the side panel
                            // and the right for messages
                            Padding(
                              padding: EdgeInsets.only(left: 0.25.w, right: 0.25.w),
                              child: Container(
                                constraints: 100.w > 1920 ? BoxConstraints(minHeight: 720) : BoxConstraints(minHeight: 450),
                                height: 45.h,
                                width: 71.5.w,
                                // color: red,
                                child: Padding(
                                  padding: EdgeInsets.all(0.25.w),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: StaggerLoad(scrollDirection: Axis.horizontal, duration: 500, widgets: [
                                          ProjectsDeck(),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // This padding adds a little bit more to the left for the side panel
                            // and the right for messages
                            Padding(
                              padding: EdgeInsets.only(left: 0.25.w, right: 0.25.w),
                              child: Container(
                                constraints: 100.w > 1920 ? BoxConstraints(minHeight: 720) : BoxConstraints(minHeight: 450),
                                // clipBehavior: Clip.none,
                                height: 45.h,
                                // width: 71.5.w,
                                // child: AnimationLimiter(
                                //   child: ListView.builder(
                                //     scrollDirection: Axis.horizontal,
                                //     itemCount: 2,
                                //     itemBuilder: (BuildContext context, int index) {
                                //       return AnimationConfiguration.staggeredList(
                                //         delay: const Duration(milliseconds: 200),
                                //         position: index,
                                //         duration: const Duration(milliseconds: 700),
                                //         child: ScaleAnimation(
                                //           scale: 0.7,
                                //           curve: Curves.easeOutBack,
                                //           child: FadeInAnimation(
                                //             child: Padding(
                                //               padding: EdgeInsets.all(0.25.w),
                                //               child: deskDashboardDecks2(
                                //                 deck4: Hero(
                                //                   flightShuttleBuilder: flightShuttleBuilder,
                                //                   tag: ButtonState().socialsHeroTag,
                                //                   child: SocialsDeck(),
                                //                 ),
                                //                 deck5: Hero(
                                //                   flightShuttleBuilder: flightShuttleBuilder,
                                //                   tag: ButtonState().newsHeroTag,
                                //                   child: NewsDeck(),
                                //                 ),
                                //               )[index],
                                //             ),
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // ),
                              ),
                            ),
                          ],
                        ),
                        // // ignore: prefer_const_constructors
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.25.w),
                          child: Messages(),
                        ),
                      ],
                    ),
                  ),

                  // ignore: prefer_const_constructors
                ],
              ),

              // Positioned.fill(
              //   child: BackdropFilter(
              //       filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
              //       child:  SizedBox()),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }
}
