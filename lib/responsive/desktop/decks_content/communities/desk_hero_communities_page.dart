import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/communities/test_communities_post_list.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/desktop_projects_page.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/newProjectButton.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectCategoryCard.dart';
import 'package:flutter_application_1/responsive/desktop/newStagger.dart';
import 'package:flutter_application_1/responsive/desktop/util/large_stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/stagger_load.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/util/test_list.dart';
import '../../util/web_ui_template.dart';
import 'package:http/browser_client.dart' as httpClient;

class DesktopCommunitiesPage extends StatefulWidget {
  DesktopCommunitiesPage({Key? key}) : super(key: key);

  @override
  State<DesktopCommunitiesPage> createState() => _DesktopCommunitiesPageState();
}

class _DesktopCommunitiesPageState extends State<DesktopCommunitiesPage> {
  final CarouselController controller = CarouselController(initialItem: 1);
  final client = httpClient.BrowserClient()..withCredentials = true;
  final assetsEndpoint = Uri.parse("$hostname/api/projectsCategoryAssets");

  final cdnBaseUrl = "https://assets.crbn.cx/carbon-assets/";
  // final cdnBaseUrl = "http://10.7.77.10:8010/carbon-assets/";
  List<Widget> projects = [];

  @override
  void initState() {
    getAssets();
    super.initState();
  }

  Future getAssets() async {
    try {
      final res = await client.get(assetsEndpoint);
      // print(res.body);
      final body = jsonDecode(res.body);
      // print(cdnBaseUrl + body[0]["image"]);
      projectCategoryDropdownItems.clear();
      for (final project in body) {
        setState(() {
          projects.add(
            ProjectCategory(
                category: project["category"],
                description: project["description"],
                imageDir: cdnBaseUrl + project["image"],
                route: project["route"]),
          );
          // 50ms delay between each setState to avoid building every
          // widget at once
          Future.delayed(Duration(milliseconds: 50));
        });
        projectCategoryDropdownItems.add(DropdownMenuItem(
          child: Text(project["category"]),
          value: project["category"],
        ));
      }
    } catch (e) {
      print("Error retrieving JSON data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print(100.w(context));

    if (projects.isEmpty) {
      return WebUiTemplate(
        title: "Projects",
        button1: CommunitiesButton(),
        button2: SocialsButton(),
        button3: NewsButton(),
        child: Center(
          child: CircularProgressIndicator(
            color: red,
            backgroundColor: Colors.black87,
          ).animate().fadeIn(delay: Duration(milliseconds: 100)),
        ),
      );
    }
    return WebUiTemplate(
      title: "Projects",
      button1: CommunitiesButton(),
      button2: SocialsButton(),
      button3: NewsButton(),
      child: Stack(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: 75.h(context), maxWidth: 80.w(context)),
              child: CarouselView.weighted(
                controller: controller,
                itemSnapping: true,
                flexWeights: const <int>[1, 7, 1],
                children: projects,
              ),
            ),
          ),
          NewProjectButton()
        ],
      ),
    );
  }
}
