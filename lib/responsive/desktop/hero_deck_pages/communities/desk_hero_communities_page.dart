import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/hero_deck_pages/communities/communities_post_list.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/desk_deck_bubbles.dart';
import 'package:flutter_application_1/util/test_list.dart';
import '../../../../main.dart';
import '../../../../util/soft_close.dart';
import '../../dashboard/title_bubble.dart';
import '../../desk_decks.dart';
import '../../large_stagger_load.dart';
import '../../util/web_ui_template.dart';
import 'communities_post.dart';

class DeskHeroCommunitiesPage extends StatefulWidget {
  const DeskHeroCommunitiesPage({Key? key}) : super(key: key);

  @override
  State<DeskHeroCommunitiesPage> createState() => _DeskHeroCommunitiesPageState();
}

class _DeskHeroCommunitiesPageState extends State<DeskHeroCommunitiesPage> {
  //globals
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebUiTemplate(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.5.w(context), 0, 0.5.w(context), 0.5.w(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //
                      // Title of Screen
                      TitleBubble(
                        deckHeight: 3.sp(context),
                        deckName: 'Communities',
                        deckWidth: 17.25.w(context),
                        textSize: 3.5.sp(context),
                        rightPad: 0.w(context),
                      ),

                      //
                      //Houses Deck Buttons
                      CommunitiesBubbleDock(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: LargeStaggerLoad(
              widgets: comm_post_list,
              childHeight: 250,
              padding: EdgeInsets.all(0.5.w(context)),
              // physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }
}

class CommunitiesBubbleDock extends StatelessWidget {
  const CommunitiesBubbleDock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.sp(context),
      // width: 30.w(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.w(context)),
        color: const Color.fromARGB(185, 21, 19, 22),
        border: Border.all(color: deckBorderColor),
      ),
      // padding: EdgeInsets.fromLTRB(1.w(context), 1.sp(context), 1.w(context), 1.sp(context)),
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
          const CommunitiesButton()
              .animate()
              .slideX(
                  begin: 0.25,
                  end: 0,
                  delay: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 400),
                  curve: const SoftClose())
              .fadeIn(begin: 0, duration: const Duration(milliseconds: 500)),
          const ProjectsButton()
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
