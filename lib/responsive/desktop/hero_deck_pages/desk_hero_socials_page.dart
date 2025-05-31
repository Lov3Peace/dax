import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/button_state.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../util/test_list.dart';
import '../bubble_deck_pages/desk_socials_page.dart';
import '../dashboard/title_bubble.dart';
import '../util/web_ui_template.dart';

class DeskHeroSocialsPage extends StatefulWidget {
  const DeskHeroSocialsPage({Key? key}) : super(key: key);

  @override
  State<DeskHeroSocialsPage> createState() => _DeskHeroSocialsPageState();
}

class _DeskHeroSocialsPageState extends State<DeskHeroSocialsPage> with AnimationMixin {
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
                        deckName: 'Socials',
                      ),

                      //
                      //Houses Deck Buttons
                      Container(
                        color: tran,
                        child: const Column(
                          children: [SocialsBubbleDock()],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h(context),
                  ),
                  Expanded(
                    child: StaggerLoad(
                      widgets: test_big_list,
                      padding: EdgeInsets.all(0.5.w(context)),
                      physics: const BouncingScrollPhysics(),
                      duration: 300,
                      scrollDirection: Axis.vertical,
                      delay: 5,
                      scale: 1.02,
                      layer: 1,
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
