import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_constants.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/desk_side_panel.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/wallet/desk_wallet_popup/desk_wallet_popup.dart.dart';
import 'package:flutter_application_1/responsive/desktop/messages.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';
import '../../util/button_state.dart';
import '../../util/desk_dashboard_decks.dart';
import '../mobile/mob_artboard_page.dart';
import 'desk_sp/desk_button_functions.dart';
import 'desk_sp/desk_dock_buttons/connections/desk_connections_popup.dart';
import 'desk_sp/desk_dock_buttons/help/desk_help_popup.dart';
import 'desk_sp/desk_dock_buttons/info/desk_info_popup.dart';
import 'desk_sp/desk_dock_buttons/settings/desk_settings_popup.dart.dart';

//import 'package:responsive_framework/responsive_framework.dart';

class DesktopDashboard extends StatefulWidget {
  const DesktopDashboard({Key? key}) : super(key: key);

  @override
  State<DesktopDashboard> createState() => _DesktopDashboardState();
}

class _DesktopDashboardState extends State<DesktopDashboard> with AnimationMixin {
  //globals
  late Animation<double> scale;
  late Animation<double> opacity;
  late AnimationController widthController;
  late AnimationController heightController;
  late AnimationController colorController;

  @override
  void initState() {
    // TODO: implement initState
    scale = Tween<double>(begin: 1.0, end: 0.9).animate(controller);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    controller.stop();
    super.initState();

    final heroReset = context.read<ButtonState>();
    heroReset.heroReset();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ButtonState>(
      builder: (context, value, child) => Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SingleChildScrollView(
          // physics: AlwaysScrollableScrollPhysics(),

          child: Container(
            height: 100.h,
            width: 100.w,
            constraints: BoxConstraints(minWidth: 1200, minHeight: 500),
            child: Stack(
              children: [
                // Background(),
                ArtBoardScreen(),
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
                            Padding(
                              padding: EdgeInsets.only(left: 0.25.w, right: 0.25.w),
                              child: Container(
                                clipBehavior: Clip.none,
                                height: 45.h,
                                width: 71.5.w,
                                // color: red,
                                constraints: BoxConstraints(minWidth: 700, minHeight: 250),
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
                                              padding: EdgeInsets.fromLTRB(0.25.w, 0.5.h, 0.25.w, 0.5.h),
                                              child: deskDashboardDecks1(
                                                deck1: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 1.5.h),
                                                      child: TitleBubble(
                                                        deckHeight: 5.5.h,
                                                        deckName: 'Dashboard',
                                                        deckWidth: 17.25.w,
                                                        textSize: 3.sp,
                                                        leftPad: 30,
                                                      ),
                                                    ),
                                                    Expanded(child: DProfileCard()),
                                                  ],
                                                ),
                                                deck2: Hero(
                                                    tag: ButtonState().projectsHeroTag,
                                                    flightShuttleBuilder: flightShuttleBuilder,
                                                    child: ProjectsDeck()),
                                                deck3: Hero(
                                                    tag: ButtonState().communityHeroTag,
                                                    flightShuttleBuilder: flightShuttleBuilder,
                                                    child: CommunityDeck()),
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
                              padding: EdgeInsets.only(left: 0.25.w, right: 0.25.w),
                              child: Container(
                                clipBehavior: Clip.none,
                                height: 45.h,
                                width: 71.5.w,
                                constraints: BoxConstraints(minWidth: 700, minHeight: 250),
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
                                              padding: EdgeInsets.fromLTRB(0.25.w, 0.5.h, 0.25.w, 0.5.h),
                                              child: deskDashboardDecks2(
                                                deck4: Hero(
                                                  flightShuttleBuilder: flightShuttleBuilder,
                                                  tag: ButtonState().socialsHeroTag,
                                                  child: SocialsDeck(),
                                                ),
                                                deck5: Hero(
                                                    flightShuttleBuilder: flightShuttleBuilder, tag: ButtonState().newsHeroTag, child: NewsDeck()),
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
                    DimOverlay(),
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
