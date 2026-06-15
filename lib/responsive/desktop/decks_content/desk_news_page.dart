import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/util/stagger_load.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../../util/test_list.dart';
import '../util/web_ui_template.dart';

class DesktopNewsPage extends StatelessWidget {
  const DesktopNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebUiTemplate(
      title: "News",
      button1: ProjectsButton(),
      button2: CommunitiesButton(),
      button3: SocialsButton(),
      child: StaggerLoad(
        widgets: test_big_list,
        listPadding: EdgeInsets.only(top: 10.h(context)),
        childPadding: EdgeInsets.all(0.5.w(context)),
        physics: const BouncingScrollPhysics(),
        duration: 300,
        scrollDirection: Axis.vertical,
        delay: 35,
        scale: 1.02,
        layer: 1,
      ),
    );
  }
}
