import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/responsive/desktop/hero_deck_pages/communities/communities_post_list.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/desk_deck_bubbles.dart';
import 'package:flutter_application_1/util/test_list.dart';
import '../../../../main.dart';
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
                        textSize: 3.sp(context),
                        leftPad: 30,
                      ),

                      //
                      //Houses Deck Buttons
                      Container(
                        color: tran,
                        child: CommunitiesBubbleDock(),
                      ),
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
      height: 3.sp(context),
      width: 30.w(context),
      constraints: 100.w(context) > 1920 ? BoxConstraints(minHeight: 110) : BoxConstraints(minHeight: 55),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.w(context)),
        color: const Color.fromARGB(185, 21, 19, 22),
        border: Border.all(color: deckBorderColor),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SocialsButton(),
          NewsButton(),
          CommunitiesButton(),
        ],
      ),
    );
  }
}
