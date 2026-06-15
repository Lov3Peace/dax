// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/newProjectButton.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectCategoryCard.dart';
// import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectsList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/util/large_stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import '../../../../util/imports.dart';
import 'package:http/browser_client.dart' as httpClient;

class DesktopProjectsPage extends StatefulWidget {
  const DesktopProjectsPage({super.key});

  @override
  State<DesktopProjectsPage> createState() => _DesktopProjectsPageState();
}

List<DropdownMenuItem> projectCategoryDropdownItems = [];

class _DesktopProjectsPageState extends State<DesktopProjectsPage> {
  final client = httpClient.BrowserClient()..withCredentials = true;
  final assetsEndpoint = Uri.parse("$hostname/api/projectsCategoryAssets");

  final cdnBaseUrl = "https://assets.crbn.cx/carbon-assets/";
  // final cdnBaseUrl = "http://10.7.77.10:8010/carbon-assets/";
  var projects = [];

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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: LargeStaggerLoad(
              widgets: projects,
              rowWidth: 75.w(context),
              itemsPerRow: 2,
              scale: 1.010,
              duration: 300,
              delay: 1000,
              listPadding: EdgeInsets.symmetric(vertical: 7.w(context)),
              childPadding: EdgeInsets.all(0.5.w(context)),
              childHeight: 30.w(context),
              // childWidth: 37.5.w(context),
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
          NewProjectButton()
        ],
      ),
    );
  }
}
