import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/desk_deck_bubbles.dart';
import '../../../../main.dart';
import '../../dashboard/title_bubble.dart';
import '../../desk_decks.dart';
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
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: WebUiTemplate(
          //Column for Title, Dock Buttons, and Content
          child: Container(
            height: 90.h(context),
            width: 71.w(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.sp(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //
                            // Title of Screen
                            TitleBubble(
                              deckHeight: 6.5.h(context),
                              deckName: 'Communities',
                              deckWidth: 17.25.w(context),
                              textSize: 4.sp(context),
                              leftPad: 20,
                            ),

                            //
                            //Houses Deck Buttons
                            //
                            Container(
                              color: tran,
                              child: const Column(
                                children: [ProjectsBubbleDock()],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Expanded(
                //   child: LargeStaggerLoad(
                //     widgets: test_big_list,
                //     childHeight: 50.h(context),
                //     childWidth: 35.w(context),
                //     padding: EdgeInsets.all(0.5.w(context)),
                //     physics: const NeverScrollableScrollPhysics(),
                //   ),
                // ),
                CommunitiesPost(
                  postTitle: Text(
                    '[Post Title]',
                    style: TextStyle(fontSize: 5.sp(context), fontWeight: FontWeight.w700),
                  ),
                  content: '[Content]',
                  user: '[User]',
                  timestamp: 'timestamp',
                  category: '[Category]',
                  gradient1: red,
                  gradient2: pink,
                  neonGlow: tran,
                  shadowColor: white,
                ),
              ],
            ),
          ),
        ));
  }

  // @override
  // void dispose() {
  //   // controller.dispose();
  //   super.dispose();
  // }
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
