import 'package:animated_image_list/photoViewerArbnb/PhotoViewerArbnb_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_buttons/desk_friends_dock_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_buttons/desk_help_dock_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_buttons/desk_info_dock_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_buttons/desk_settings_dock_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_buttons/desk_wallet_dock_button.dart';
import 'package:flutter_application_1/responsive/desktop/desktop_constants.dart';
import 'package:flutter_application_1/responsive/desktop/desktop_side_panel.dart';
import 'package:flutter_application_1/responsive/desktop/messages.dart';
import 'package:indexed/indexed.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';
import '../../util/desk_dashboard_decks.dart';
import '../mobile/mob_artboard_page.dart';

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
      extendBody: true,
      body: SingleChildScrollView(
        // physics: AlwaysScrollableScrollPhysics(),

        child: Container(
          height: 100.h,
          width: 100.w,
          constraints: const BoxConstraints(minWidth: 1200, minHeight: 500),
          child: Stack(
            children: [
              // Background(),
              const ArtBoardScreen(),
              Indexer(
                children: [
                  Indexed(
                    index: 2,
                    child: DesktopSidePanel(
                      newGrad1: purp,
                      newGrad2: red,
                      newGlow: red,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 12.5.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Positioned(
                          //   top: 100,
                          //   left: 5.w,
                          //   child: Hero(
                          //     tag: 'title',
                          //     flightShuttleBuilder: flightShuttleBuilder,
                          //     child: TitleBubble(
                          //       deckHeight: screenHeight * 0.07,
                          //       deckWidth: screenWidth * 0.15,
                          //       deckName: 'SMFH',
                          //       gradient1: tran,
                          //       gradient2: tran,
                          //       neonGlow: tran,
                          //       textSize: titleTextSize,
                          //       leftPad: 30,
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 0.25.w, right: 0.25.w),
                            child: Container(
                              height: 45.h,
                              width: 71.5.w,
                              // color: red,
                              constraints: const BoxConstraints(
                                  minWidth: 700, minHeight: 250),
                              child: AnimationLimiter(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AnimationConfiguration.staggeredList(
                                      delay: const Duration(milliseconds: 200),
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 700),
                                      child: ScaleAnimation(
                                        scale: 0.7,
                                        curve: Curves.easeOutBack,
                                        child: FadeInAnimation(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.25.w, 0.0.w, 0.25.w, 1.5.h),
                                            child: deskDashboardDecks1(
                                              deck1: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 1.5.h),
                                                    child: TitleBubble(
                                                      deckHeight: 5.5.h,
                                                      deckName: 'Dashboard',
                                                      deckWidth: 17.25.w,
                                                      textSize: 3.sp,
                                                      leftPad: 30,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: ProfileCard()),
                                                ],
                                              ),
                                              deck2: Hero(
                                                  tag: "projects",
                                                  flightShuttleBuilder:
                                                      flightShuttleBuilder,
                                                  child: ProjectsDeck()),
                                              deck3: Hero(
                                                  tag: "finances",
                                                  flightShuttleBuilder:
                                                      flightShuttleBuilder,
                                                  child: FinancesDeck()),
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
                          Padding(
                            padding:
                                EdgeInsets.only(left: 0.25.w, right: 0.25.w),
                            child: Container(
                              height: 45.h,
                              width: 71.5.w,
                              constraints: const BoxConstraints(
                                  minWidth: 700, minHeight: 250),
                              child: AnimationLimiter(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 2,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AnimationConfiguration.staggeredList(
                                      delay: const Duration(milliseconds: 200),
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 700),
                                      child: ScaleAnimation(
                                        scale: 0.7,
                                        curve: Curves.easeOutBack,
                                        child: FadeInAnimation(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.25.w, 0.0.w, 0.25.w, 0.h),
                                            child: deskDashboardDecks2(
                                              deck4: Hero(
                                                tag: "socials",
                                                child: SocialsDeck(),
                                              ),
                                              deck5: Hero(
                                                  flightShuttleBuilder:
                                                      flightShuttleBuilder,
                                                  tag: "news",
                                                  child: NewsDeck()),
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
                      Messages(),
                    ],
                  ),
                  Indexed(
                    index: 1,
                    child: Positioned(
                      left: -70.w,
                      child: WalletPopUp(),
                    ),
                  ),
                  Indexed(
                    index: 1,
                    child: Positioned(
                      left: -70.w,
                      child: FriendsPopUp(),
                    ),
                  ),
                  Indexed(
                    index: 1,
                    child: Positioned(
                      left: -70.w,
                      child: SettingsPopUp(),
                    ),
                  ),
                  Indexed(
                    index: 1,
                    child: Positioned(
                      left: -70.w,
                      child: HelpPopUp(),
                    ),
                  ),
                  Indexed(
                    index: 1,
                    child: Positioned(
                      left: -70.w,
                      child: InfoPopUp(),
                    ),
                  ),
                ],
              ),

              // Positioned.fill(
              //   child: BackdropFilter(
              //       filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
              //       child: const SizedBox()),
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
