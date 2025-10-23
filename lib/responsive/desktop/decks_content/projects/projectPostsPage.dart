// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectPostCard.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
// import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectsList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/large_stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import '../../../../util/imports.dart';
import 'package:http/browser_client.dart' as httpClient;

class DesktopProjectPostsPage extends StatefulWidget {
  DesktopProjectPostsPage({super.key, this.parameter = ""});

  String parameter;
  @override
  State<DesktopProjectPostsPage> createState() =>
      _DesktopProjectPostsPageState();
}

class _DesktopProjectPostsPageState extends State<DesktopProjectPostsPage> {
  final client = httpClient.BrowserClient()..withCredentials = true;
  final getPostsEndpoint = Uri.parse("$hostname/api/projectPosts");
  final cdnBaseUrl = "https://assets.crbn.cx/carbon-assets/images/";
  // final cdnBaseUrl = "http://10.7.77.10:8010/carbon-assets/";
  var posts = [];

  @override
  void initState() {
    getAssets();
    super.initState();
  }

  Future getAssets() async {
    // Header Format = projectCategory : category-with-dashes-delimiter
    final res = await client
        .get(getPostsEndpoint, headers: {"projectCategory": widget.parameter});
    // print(res.body);
    final body = jsonDecode(res.body);
    // print(cdnBaseUrl + body[0]["image"]);
    for (final post in body) {
      posts.add(ProjectPostCard(
          category: widget.parameter,
          postTitle: Text("[postTitle]"),
          user: "[User]",
          content: "[Content]",
          timestamp: "[timestamp]",
          gradient1: red,
          gradient2: pink,
          neonGlow: pink,
          shadowColor: tran));
    }
    setState(() {
      posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(100.w(context));
    return WebUiTemplate(
      title: "Projects",
      button1: CommunitiesButton(),
      button2: SocialsButton(),
      button3: NewsButton(),
      child: Stack(
        children: [
          LargeStaggerLoad(
            widgets: posts,
            scale: 1.02,
            constraints: const BoxConstraints(minHeight: 450),
            // listPadding: EdgeInsets.fromLTRB(0.5.w(context),
            //     100.h(context) < 875 ? 100 : 10.h(context), 0.5.w(context), 0),
            // childPadding: 100.w(context) > 2200
            //     ? EdgeInsets.all(10)
            //     : EdgeInsets.all(0.25.w(context)),
            childHeight: 52.h(context),
            physics: const NeverScrollableScrollPhysics(),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0.5.w(context), 1.w(context)),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  height: 75,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.w(context)),
                    color: const Color.fromARGB(185, 21, 19, 22),
                    border: Border.all(color: deckBorderColor),
                  ),
                  child: TactileButton(
                    scale: 1.05,
                    child: GradientContainer(
                        height: 5.h(
                            context), // not used; padding of parent  container sets the height and width
                        width: 100, // not used
                        text: "New Project",
                        textSize: 16,
                        fontWeight: FontWeight.w500,
                        gradient1: red,
                        gradient2: pink,
                        neonGlow: pink,
                        borderColor: tran,
                        borderRadius: 5.w(context)),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
