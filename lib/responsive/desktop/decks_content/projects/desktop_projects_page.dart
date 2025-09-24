import 'dart:convert';

import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectCategoryCard.dart';
// import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectsList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/large_stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import '../../../../util/imports.dart';
import 'package:http/browser_client.dart' as httpClient;

class DesktopProjectsPage extends StatefulWidget {
  DesktopProjectsPage({super.key});

  @override
  State<DesktopProjectsPage> createState() => _DesktopProjectsPageState();
}

class _DesktopProjectsPageState extends State<DesktopProjectsPage> {
  final client = httpClient.BrowserClient()..withCredentials = true;
  final assetsEndpoint =
      Uri.parse("https://localhost:7777/api/projectsCategoryAssets");

  // final cdnBaseUrl = "https://assets.crbn.cx/carbon-assets/images/";
  final cdnBaseUrl = "http://10.7.77.10:8010/carbon-assets/";
  var projects = [];

  @override
  void initState() {
    getAssets();
    super.initState();
  }

  Future getAssets() async {
    final res = await client.get(assetsEndpoint);
    // print(res.body);
    final body = jsonDecode(res.body);
    // print(cdnBaseUrl + body[0]["image"]);
    for (final project in body) {
      projects.add(
        ProjectCategory(
            category: project["category"],
            description: project["description"],
            imageDir: cdnBaseUrl + project["image"]),
      );
    }
    setState(() {
      projects;
    });
  }

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
        listPadding:
            EdgeInsets.fromLTRB(0.5.w(context), 100, 0.5.w(context), 0),
        childPadding: EdgeInsets.all(0.25.w(context)),
        childHeight: 52.h(context),
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
