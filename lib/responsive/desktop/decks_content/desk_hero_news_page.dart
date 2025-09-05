import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../util/button_state.dart';
import '../../../util/test_list.dart';
import '../bubble_deck_pages/desk_news_page.dart';
import '../dashboard/title_bubble.dart';
import '../util/web_ui_template.dart';

class DeskHeroNewsPage extends StatefulWidget {
  const DeskHeroNewsPage({Key? key}) : super(key: key);

  @override
  State<DeskHeroNewsPage> createState() => _DeskHeroNewsPageState();
}

class _DeskHeroNewsPageState extends State<DeskHeroNewsPage>
    with AnimationMixin {
  //globals
  late Animation<double> scale;
  late Animation<double> opacity;
  late AnimationController widthController;
  late AnimationController heightController;
  late AnimationController colorController;

  //final dashboardDecksList = dashboardDecks(0, 1, 2, 4);

  @override
  void initState() {
    // TODO: implement initState
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
          title: "News",
          button1: ProjectsButton(),
          button2: CommunitiesButton(),
          button3: SocialsButton(),
          //Column for Title, Dock Buttons, and Content
          child: Expanded(
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
