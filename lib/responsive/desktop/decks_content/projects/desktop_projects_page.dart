// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectCategoryCard.dart';
// import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectsList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/large_stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import '../../../../util/imports.dart';
import 'package:http/browser_client.dart' as httpClient;

class DesktopProjectsPage extends StatefulWidget {
  const DesktopProjectsPage({super.key});

  @override
  State<DesktopProjectsPage> createState() => _DesktopProjectsPageState();
}

List<DropdownMenuEntry> projectCategoryDropdownEntries = [];

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
      projectCategoryDropdownEntries.clear();
      for (final project in body) {
        setState(() {
          projects.add(
            ProjectCategory(
                category: project["category"],
                description: project["description"],
                imageDir: cdnBaseUrl + project["image"],
                route: project["route"]),
          );
          Future.delayed(Duration(milliseconds: 50));
        });
        projectCategoryDropdownEntries.add(DropdownMenuEntry(
          label: project["category"],
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
    return WebUiTemplate(
      title: "Projects",
      button1: CommunitiesButton(),
      button2: SocialsButton(),
      button3: NewsButton(),
      child: LargeStaggerLoad(
        widgets: projects,
        scale: 1.02,
        constraints: const BoxConstraints(minHeight: 450),
        listPadding: EdgeInsets.fromLTRB(0.5.w(context),
            100.h(context) < 875 ? 100 : 10.h(context), 0.5.w(context), 0),
        childPadding: 100.w(context) > 2200
            ? EdgeInsets.all(10)
            : EdgeInsets.all(0.25.w(context)),
        childHeight: 30.w(context),
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
