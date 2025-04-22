import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:provider/provider.dart';
import '../../../util/button_state.dart';
import '../../../util/test_list.dart';
import '../bubble_deck_pages/desk_community_page.dart';
import '../dashboard/title_bubble.dart';
import '../large_stagger_load.dart';
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
              height: 80.h(context),
              width: 71.w(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //
                      // Title of Screen
                      TitleBubble(
                        deckHeight: 6.5.h(context),
                        deckName: 'Communities',
                        deckWidth: 17.25.w(context),
                        textSize: 3.sp(context),
                        leftPad: 30,
                      ),

                      //
                      //Houses Deck Buttons
                      Container(
                        color: tran,
                        child: const Column(
                          children: [CommunityBubbleDock()],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h(context),
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
