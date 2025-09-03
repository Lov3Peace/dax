import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/communities/test_communities_post_list.dart';
import 'package:flutter_application_1/responsive/desktop/util/bubble_dock.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import '../../dashboard/title_bubble.dart';
import '../../large_stagger_load.dart';
import '../../util/web_ui_template.dart';

class DeskHeroCommunitiesPage extends StatefulWidget {
  const DeskHeroCommunitiesPage({Key? key}) : super(key: key);

  @override
  State<DeskHeroCommunitiesPage> createState() =>
      _DeskHeroCommunitiesPageState();
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
        // mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                // Uniform 0.5.w padding on Row and LargeStagger items (wanted it on the parent but couldnt because of
                // the padding on the LargeStagger list items)
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0.5.w(context), 0, 0.5.w(context), 2.sp(context)),
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
                      BubbleDock(
                          child1: ProjectsButton(),
                          child2: SocialsButton(),
                          child3: NewsButton()),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: LargeStaggerLoad(
              widgets: comm_post_list,
              scale: 1.02,
              constraints: BoxConstraints(minHeight: 350),
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
