import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/projects_deck.dart';
import 'package:flutter_application_1/responsive/desktop/desk_deck_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/desk_constants.dart';

import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/wallet/desk_wallet_popup/desk_wallet_popup.dart.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';

import 'package:simple_animations/simple_animations.dart';
import '../../../main.dart';
import '../../../pages/keyboards_deck.dart';
import '../../mobile/mob_artboard_page.dart';
import '../../../util/button_state.dart';

import '../dashboard/title_bubble.dart';
import '../desk_decks.dart';
import '../desk_sp/desk_dock_buttons/connections/desk_connections_popup.dart';
import '../desk_sp/desk_dock_buttons/help/desk_help_popup.dart';
import '../desk_sp/desk_dock_buttons/info/desk_info_popup.dart';
import '../desk_sp/desk_dock_buttons/settings/desk_settings_popup.dart.dart';
import '../desk_sp/desk_side_panel.dart';
import '../messages.dart';

class DeskHeroProjectsPage extends StatefulWidget {
  const DeskHeroProjectsPage({Key? key}) : super(key: key);

  @override
  State<DeskHeroProjectsPage> createState() => _DeskHeroProjectsPageState();
}

class _DeskHeroProjectsPageState extends State<DeskHeroProjectsPage> with AnimationMixin {
  //globals

  //final dashboardDecksList = dashboardDecks(0, 1, 2, 4);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ButtonState>(
      builder: (context, value, child) => Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: WebUITemplate(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //
                    // Title of Screen
                    Padding(
                      padding: EdgeInsets.only(right: 23.6.w(context)),
                      child: TitleBubble(
                        deckHeight: 5.5.h(context),
                        deckName: 'Projects',
                        deckWidth: 17.25.w(context),
                        textSize: 3.sp(context),
                        leftPad: 30,
                      ),
                    ),
                    //
                    //Houses Decks Buttons
                    Container(
                      color: tran,
                      child: const Column(
                        children: [ProjectsBubbleDock()],
                      ),
                    ),
                  ],
                ),
                Container(
                  color: tran,
                  child: Column(
                    children: [
                      Hero(
                        tag: ButtonState().projectsHeroTag,
                        flightShuttleBuilder: flightShuttleBuilder,
                        child: DeskProjectsCont(),
                      ),
                    ],
                  ),
                ),
              ],
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

class DeskProjectsCont extends StatefulWidget {
  const DeskProjectsCont({super.key});

  @override
  State<DeskProjectsCont> createState() => _DeskProjectsContState();
}

class _DeskProjectsContState extends State<DeskProjectsCont> {
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
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 20.0, // Horizontal spacing between items
          mainAxisSpacing: 20.0, // Vertical spacing between items
          childAspectRatio: 1.3, // Aspect ratio of the items
        ),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredGrid(
            delay: const Duration(milliseconds: 500),
            position: index,
            duration: const Duration(milliseconds: 700),
            columnCount: 2, // Number of columns for staggered effect
            child: SlideAnimation(
              horizontalOffset: 100,
              curve: Curves.easeOutBack,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const KeyboardsDeck();
                    }));
                  },
                  child: Container(
                    height: 40.h(context),
                    width: 30.w(context),
                    color: red,
                  ),
                ),
              ),
            ),
          );
        },
      ).animate().fadeIn(begin: 0.5, delay: const Duration(milliseconds: 600)),
    );
  }
}

class ProjectsBubbleDock extends StatelessWidget {
  const ProjectsBubbleDock({super.key});

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
          NewsButton(),
          CommunityButton(),
        ],
      ),
    );
  }
}
