import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/keyboards_deck.dart';
import 'package:flutter_application_1/responsive/desktop/decks_buttons.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_buttons/desk_friends_dock_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_buttons/desk_help_dock_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_buttons/desk_info_dock_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_buttons/desk_settings_dock_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_buttons/desk_wallet_dock_button.dart';

import 'package:flutter_application_1/responsive/desktop/desktop_constants.dart';
import 'package:flutter_application_1/responsive/desktop/desktop_dock.dart';
import 'package:flutter_application_1/responsive/desktop/messages.dart';
import 'package:indexed/indexed.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';
import '../mobile/mob_artboard_page.dart';

class DeskSocialsPageDash extends StatefulWidget {
  const DeskSocialsPageDash({Key? key}) : super(key: key);

  @override
  State<DeskSocialsPageDash> createState() => _DeskSocialsPageDashState();
}

class _DeskSocialsPageDashState extends State<DeskSocialsPageDash>
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
                      child: DesktopDock(
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
                                    deckName: 'Socials',
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
                                      SocialsButtonHolder(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: tran,
                              child: const Column(
                                children: [
                                  DeskSocialsPage(),
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

class DeskSocialsPage extends StatefulWidget {
  const DeskSocialsPage({
    super.key,
  });

  @override
  State<DeskSocialsPage> createState() => _DeskSocialsPageState();
}

class _DeskSocialsPageState extends State<DeskSocialsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 71.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.5.w),
        color: Color.fromARGB(185, 21, 19, 22),
        border: Border.all(color: deckBorderColor),
      ),
      child: ListView.builder(
        itemExtent: 420,
        physics: const BouncingScrollPhysics(),
        itemCount: SocialsStacks().deskSocialsStacks.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            delay: const Duration(milliseconds: 200),
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const KeyboardsDeck();
                          }));
                        },
                        child: SocialsStacks().deskSocialsStacks[index]),
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

class SocialsButtonHolder extends StatelessWidget {
  const SocialsButtonHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.5.h,
      width: 30.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.5.w),
        color: Color.fromARGB(185, 21, 19, 22),
        border: Border.all(color: deckBorderColor),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ProjectsButton(),
          FinancesButton(),
          NewsButton(),
        ],
      ),
    );
  }
}
