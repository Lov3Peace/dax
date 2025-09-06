import 'dart:math';

import 'package:flutter_application_1/responsive/desktop/dashboard/title_bubble.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectCategoryCard.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectsList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/large_stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/bubble_dock.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import '../../../../util/imports.dart';

class DesktopProjectsPage extends StatelessWidget {
  const DesktopProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebUiTemplate(
      title: "Projects",
      button1: CommunitiesButton(),
      button2: SocialsButton(),
      button3: NewsButton(),
      child: LargeStaggerLoad(
        widgets: projects,
        scale: 1.02,
        constraints: const BoxConstraints(minHeight: 450),
        listPadding: EdgeInsets.only(top: 10.h(context)),
        childPadding: EdgeInsets.all(0.25.w(context)),
        childHeight: 52.h(context),
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
