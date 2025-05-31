import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/responsive/desktop/hero_deck_pages/communities/communities_post.dart';
import 'package:flutter_application_1/responsive/desktop/hero_deck_pages/communities/test_communities_post_list.dart';
import 'package:flutter_application_1/responsive/desktop/util/bubble_dock.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';

import 'package:simple_animations/simple_animations.dart';

import '../../../../util/test_list.dart';
import '../../dashboard/title_bubble.dart';
import '../../desk_decks.dart';
import '../../large_stagger_load.dart';

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
    return Scaffold(
      body: WebUiTemplate(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  // Uniform 0.5.w padding on Row and LargeStagger items (wanted it on the parent but couldnt because of
                  // the padding on the LargeStagger list items)
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.5.w(context), 0, 0.5.w(context), 2.sp(context)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //
                        // Title of Screen
                        TitleBubble(
                          deckName: 'Communities',
                        ),

                        //
                        //Houses Deck Buttons
                        BubbleDock(child1: ProjectsButton(), child2: SocialsButton(), child3: NewsButton()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: LargeStaggerLoad(
                widgets: test_big_list,
                childHeight: 50.h(context),
                childWidth: 35.w(context),
                padding: EdgeInsets.all(0.5.w(context)),
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
            // CommunitiesPost(
            //   postTitle: Text(
            //     '[Post Title]',
            //     style: TextStyle(fontSize: 5.sp(context), fontWeight: FontWeight.w700),
            //   ),
            //   content: '[Content]',
            //   user: '[User]',
            //   timestamp: 'timestamp',
            //   category: '[Category]',
            //   gradient1: red,
            //   gradient2: pink,
            //   neonGlow: tran,
            //   shadowColor: white,
            // ),
          ],
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
