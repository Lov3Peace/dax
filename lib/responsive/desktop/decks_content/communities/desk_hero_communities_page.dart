import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/communities/test_communities_post_list.dart';
import 'package:flutter_application_1/responsive/desktop/newStagger.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/util/test_list.dart';
import '../../util/web_ui_template.dart';

class DesktopCommunitiesPage extends StatelessWidget {
  const DesktopCommunitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebUiTemplate(
        title: "Communities",
        button1: ProjectsButton(),
        button2: SocialsButton(),
        button3: NewsButton(),
        child: NewStagger(
            duration: 300,
            widgets: test_big_list,
            delay: 100,
            rowWidth: 75.w(context),
            childHeight: 30.w(context),
            itemsPerRow: 2),
      ),
    );
  }
}
