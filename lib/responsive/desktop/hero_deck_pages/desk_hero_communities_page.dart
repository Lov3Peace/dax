import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/error_page.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/communities_deck.dart';
import 'package:flutter_application_1/responsive/desktop/desk_deck_bubbles.dart';

import 'package:flutter_application_1/responsive/desktop/desk_constants.dart';
import 'package:flutter_application_1/util/test_container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../main.dart';
import '../../../pages/keyboards_deck.dart';
import '../../../util/button_state.dart';
import '../../../util/test_list.dart';
import '../../mobile/mob_artboard_page.dart';

import '../dashboard/title_bubble.dart';
import '../desk_decks.dart';
import '../desk_sp/desk_dock_buttons/connections/desk_connections_popup.dart';
import '../desk_sp/desk_dock_buttons/help/desk_help_popup.dart';
import '../desk_sp/desk_dock_buttons/info/desk_info_popup.dart';
import '../desk_sp/desk_dock_buttons/settings/desk_settings_popup.dart.dart';

import '../desk_sp/desk_side_panel.dart';
import '../large_stagger_load.dart';
import '../messages.dart';
import '../util/web_ui_template.dart';

class DeskHeroCommunitiesPage extends StatefulWidget {
  const DeskHeroCommunitiesPage({Key? key}) : super(key: key);

  @override
  State<DeskHeroCommunitiesPage> createState() => _DeskHeroCommunitiesPageState();
}

class _DeskHeroCommunitiesPageState extends State<DeskHeroCommunitiesPage> {
  //globals
  late Animation<double> scale;
  late Animation<double> opacity;
  late AnimationController widthController;
  late AnimationController heightController;
  late AnimationController colorController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ButtonState>(
      builder: (context, value, child) => Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: WebUiTemplate(
            //Column for Title, Dock Buttons, and Content
            child: Container(
              height: 90.h(context),
              width: 71.w(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.sp(context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //
                        // Title of Screen
                        TitleBubble(
                          deckHeight: 6.5.h(context),
                          deckName: 'Projects',
                          deckWidth: 17.25.w(context),
                          textSize: 3.sp(context),
                          leftPad: 30,
                        ),

                        //
                        //Houses Deck Buttons
                        Container(
                          color: tran,
                          child: const Column(
                            children: [ProjectsBubbleDock()],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Community Posts").orderBy("Timestamp", descending: false).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                              child: LargeStaggerLoad(widgets: snapshot.data!.docs, childWidth: 40.w(context), childHeight: 40.h(context)));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        }
                        return Container();
                      },
                    ),
                  ),
                  // Expanded(
                  //   child: StaggerLoad(duration: 200, widgets: test_big_list, scrollDirection: Axis.vertical, delay: 20, scale: 1.03, layer: 1),
                  // ),
                ],
              ),
            ),
          )),
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
      height: 80.h(context),
      width: 71.w(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.5.w(context)),
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
      height: 6.5.h(context),
      width: 30.w(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.5.w(context)),
        color: const Color.fromARGB(185, 21, 19, 22),
        border: Border.all(color: deckBorderColor),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SocialsButton(),
          ProjectsButton(),
          NewsButton(),
        ],
      ),
    );
  }
}
