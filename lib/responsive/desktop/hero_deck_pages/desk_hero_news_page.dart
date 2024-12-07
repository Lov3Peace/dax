import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_deck_bubbles.dart';

import 'package:flutter_application_1/responsive/desktop/desk_constants.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_side_panel.dart';
import 'package:flutter_application_1/responsive/desktop/messages.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:indexed/indexed.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';

import '../../../pages/keyboards_deck.dart';
import '../../../util/ButtonState.dart';
import '../../mobile/mob_artboard_page.dart';
import '../desk_sp/desk_dock_buttons/connections/desk_connections_popup.dart';
import '../desk_sp/desk_dock_buttons/help/desk_help_popup.dart';
import '../desk_sp/desk_dock_buttons/info/desk_info_popup.dart';
import '../desk_sp/desk_dock_buttons/settings/desk_settings_popup.dart.dart';
import '../desk_sp/desk_dock_buttons/wallet/desk_wallet_popup/desk_wallet_popup.dart.dart';

class DeskHeroNewsPage extends StatefulWidget {
  const DeskHeroNewsPage({Key? key}) : super(key: key);

  @override
  State<DeskHeroNewsPage> createState() => _DeskHeroNewsPageState();
}

class _DeskHeroNewsPageState extends State<DeskHeroNewsPage> with AnimationMixin {
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
                      child: DesktopSidePanel(
                        newGrad1: purp,
                        newGrad2: red,
                        newGlow: red,
                      ),
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
                                    deckName: 'News',
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
                                      NewsButtonHolder(),
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
                                    tag: ButtonState().newsHeroTag,
                                    flightShuttleBuilder: flightShuttleBuilder,
                                    child: const DeskNewsCont(),
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
                        child: const InfoPopUp(),
                      ),
                    ),
                  ],
                ),
              ),
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

class DeskNewsCont extends StatefulWidget {
  const DeskNewsCont({super.key});

  @override
  State<DeskNewsCont> createState() => _DeskNewsContState();
}

class _DeskNewsContState extends State<DeskNewsCont> {
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
        itemCount: NewsStacks().deskNewsStacks.length,
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
                        child: NewsStacks().deskNewsStacks[index]),
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

class NewsButtonHolder extends StatelessWidget {
  const NewsButtonHolder({super.key});

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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SocialsButton(),
          CommunityButton(),
          ProjectsButton(),
        ],
      ),
    );
  }
}
