import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/large_stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/test_list.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../util/button_state.dart';
import '../bubble_deck_pages/desk_project_page.dart';
import '../dashboard/title_bubble.dart';

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
