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
        title: "Communities",
        button1: ProjectsButton(),
        button2: SocialsButton(),
        button3: NewsButton(),
        child: LargeStaggerLoad(
          widgets: comm_post_list,
          scale: 1.02,
          constraints: BoxConstraints(minHeight: 350),
          listPadding: EdgeInsets.only(top: 10.h(context)),
          childHeight: 25.h(context),
          childPadding: EdgeInsets.all(0.5.w(context)),
          // physics: const NeverScrollableScrollPhysics(),
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
