import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/news_deck.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/profile_card.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/socials_deck.dart';
import 'package:flutter_application_1/responsive/desktop/desk_constants.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/messages.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';
import '../../../util/button_state.dart';
import '../../../util/desk_dash_lists.dart';
import '../../mobile/mob_artboard_page.dart';
import '../desk_sp/desk_side_panel.dart';

import 'communities_deck.dart';
import 'projects_deck.dart';
import 'title_bubble.dart';

//import 'package:responsive_framework/responsive_framework.dart';

class DesktopDashboard extends StatefulWidget {
  const DesktopDashboard({Key? key}) : super(key: key);

  @override
  State<DesktopDashboard> createState() => _DesktopDashboardState();
}

class _DesktopDashboardState extends State<DesktopDashboard> with AnimationMixin {
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
    return Consumer<ButtonState>(
      builder: (context, value, child) => Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: 100.h,
            // width: 100.w,
            constraints: const BoxConstraints(minHeight: 900),
            child: Stack(
              children: [
                // Background(),
                const ArtBoardScreen(),

                Row(
                  children: [
                    DesktopSidePanel(),
                    Container(
                      height: 90.sp,
                      constraints: const BoxConstraints(minHeight: 900),
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
                                  constraints: const BoxConstraints(minHeight: 450),
                                  height: 45.sp,
                                  width: 71.5.w,
                                  // color: red,
                                  child: AnimationLimiter(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
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
                                              child: Padding(
                                                padding: EdgeInsets.all(0.25.w),
                                                child: deskDashboardDecks1(
                                                  deck1: Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(bottom: 1.5.sp),
                                                        child: TitleBubble(
                                                          deckHeight: 3.sp,
                                                          deckName: 'Dashboard',
                                                          deckWidth: halfDeckWidth,
                                                          textSize: 4.sp,
                                                          leftPad: 1.sp,
                                                        ),
                                                      ),
                                                      Expanded(child: ProfileCard()),
                                                    ],
                                                  ),
                                                  deck2: Hero(
                                                      tag: ButtonState().projectsHeroTag,
                                                      flightShuttleBuilder: flightShuttleBuilder,
                                                      child: ProjectsDeck()),
                                                  deck3: Hero(
                                                      tag: ButtonState().communityHeroTag,
                                                      flightShuttleBuilder: flightShuttleBuilder,
                                                      child: CommunitiesDeck()),
                                                )[index],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              // This padding adds a little bit more to the left for the side panel
                              // and the right for messages
                              Padding(
                                padding: EdgeInsets.only(left: 0.25.w, right: 0.25.w),
                                child: Container(
                                  constraints: const BoxConstraints(minHeight: 450),
                                  // clipBehavior: Clip.none,
                                  height: 45.sp,
                                  width: 71.5.w,
                                  // constraints: BoxConstraints(minWidth: 700, minHeight: 800),
                                  child: AnimationLimiter(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
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
                                              child: Padding(
                                                padding: EdgeInsets.all(0.25.w),
                                                child: deskDashboardDecks2(
                                                  deck4: Hero(
                                                    flightShuttleBuilder: flightShuttleBuilder,
                                                    tag: ButtonState().socialsHeroTag,
                                                    child: SocialsDeck(),
                                                  ),
                                                  deck5: Hero(
                                                    flightShuttleBuilder: flightShuttleBuilder,
                                                    tag: ButtonState().newsHeroTag,
                                                    child: NewsDeck(),
                                                  ),
                                                )[index],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // ignore: prefer_const_constructors
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
      ),
    );
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }
}
