import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/desk_deck_bubbles.dart';

import 'package:flutter_application_1/responsive/desktop/desk_constants.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_side_panel.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../../main.dart';
import '../../../pages/keyboards_deck.dart';
import '../../../util/button_state.dart';
import '../../../util/soft_close.dart';
import '../../mobile/mob_artboard_page.dart';

import '../dashboard/communities_deck.dart';
import '../dashboard/title_bubble.dart';
import '../desk_decks.dart';
import '../desk_sp/desk_dock_buttons/connections/desk_connections_popup.dart';
import '../desk_sp/desk_dock_buttons/help/desk_help_popup.dart';
import '../desk_sp/desk_dock_buttons/info/desk_info_popup.dart';
import '../desk_sp/desk_dock_buttons/settings/desk_settings_popup.dart.dart';
import '../desk_sp/desk_dock_buttons/wallet/desk_wallet_popup/desk_wallet_popup.dart.dart';
import '../messages.dart';

class DeskCommunityPage extends StatefulWidget {
  const DeskCommunityPage({Key? key}) : super(key: key);

  @override
  State<DeskCommunityPage> createState() => _DeskCommunityPageState();
}

class _DeskCommunityPageState extends State<DeskCommunityPage> with AnimationMixin {
  //globals
  late Animation<double> scale;
  late Animation<double> opacity;
  late AnimationController widthController;
  late AnimationController heightController;
  late AnimationController colorController;

  @override
  void initState() {
    scale = Tween<double>(begin: 1.0, end: 0.9).animate(controller);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    controller.stop();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ButtonState>(
      builder: (context, value, child) => Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SingleChildScrollView(
          child: Container(
            height: 100.h,
            width: 100.w,
            constraints: const BoxConstraints(minWidth: 1200, minHeight: 500),
            child: Stack(
              children: [
                const ArtBoardScreen(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.play();
                    });
                    Future.delayed(const Duration(milliseconds: 300)).then((_) {
                      controller.playReverse();
                    });
                  },
                  child: Indexer(
                    children: [
                      Indexed(
                        index: 2,
                        child: DesktopSidePanel(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 12.5.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //
                                  // Title of Screen
                                  Padding(
                                    padding: EdgeInsets.only(right: 23.6.w),
                                    child: TitleBubble(
                                      deckHeight: 5.5.h,
                                      deckName: 'Community',
                                      deckWidth: 17.25.w,
                                      textSize: 3.sp,
                                      leftPad: 30,
                                    ),
                                  ),
                                  //
                                  //Houses Decks Buttons
                                  Container(
                                    color: tran,
                                    child: const Column(
                                      children: [
                                        CommunityButtonHolder(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                color: tran,
                                child: Column(
                                  children: [
                                    Hero(
                                      tag: ButtonState().communityHeroTag,
                                      flightShuttleBuilder: flightShuttleBuilder,
                                      child: const DeskCommunityCont(),
                                    ),
                                  ],
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
                          child: const WalletPopUp(),
                        ),
                      ),
                      Indexed(
                        index: 1,
                        child: Positioned(
                          left: -70.w,
                          child: const FriendsPopUp(),
                        ),
                      ),
                      Indexed(
                        index: 1,
                        child: Positioned(
                          left: -70.w,
                          child: const SettingsPopUp(),
                        ),
                      ),
                      Indexed(
                        index: 1,
                        child: Positioned(
                          left: -70.w,
                          child: const HelpPopUp(),
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
                ),
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

class DeskCommunityCont extends StatefulWidget {
  const DeskCommunityCont({super.key});

  @override
  State<DeskCommunityCont> createState() => _DeskCommunityContState();
}

class _DeskCommunityContState extends State<DeskCommunityCont> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 71.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.5.w),
        color: const Color.fromARGB(185, 21, 19, 22),
        border: Border.all(color: deckBorderColor),
      ),
      child: ListView.builder(
        itemExtent: 420,
        physics: const BouncingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            delay: const Duration(milliseconds: 500),
            position: index,
            duration: const Duration(milliseconds: 700),
            child: SlideAnimation(
              horizontalOffset: 100,
              curve: Curves.easeOutBack,
              child: FadeInAnimation(
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return const KeyboardsDeck();
                          }));
                        },
                        child: CommunitiesDeck()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CommunityButtonHolder extends StatelessWidget {
  const CommunityButtonHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.5.h,
      width: 30.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.5.w),
        color: const Color.fromARGB(185, 21, 19, 22),
        border: Border.all(color: deckBorderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SocialsButton()
              .animate()
              .slideX(
                  begin: 0.25,
                  end: 0,
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 400),
                  curve: const SoftClose())
              .fadeIn(begin: 0, duration: const Duration(milliseconds: 500)),
          const ProjectsButton()
              .animate()
              .slideX(
                  begin: 0.25,
                  end: 0,
                  delay: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 400),
                  curve: const SoftClose())
              .fadeIn(begin: 0, duration: const Duration(milliseconds: 500)),
          const NewsButton()
              .animate()
              .slideX(
                  begin: 0.25,
                  end: 0,
                  delay: const Duration(milliseconds: 600),
                  duration: const Duration(milliseconds: 400),
                  curve: const SoftClose())
              .fadeIn(begin: 0, duration: const Duration(milliseconds: 500)),
        ],
      ),
    );
  }
}
