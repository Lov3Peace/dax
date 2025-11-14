// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter_application_1/responsive/desktop/decks_content/projects/newProjectForm.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectPostCard.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
// import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectsList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/large_stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:flutter_application_1/util/test_container.dart';
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
    getPosts();
    super.initState();
  }

  Future getPosts() async {
    // Header Format = projectCategory : category-with-dashes-delimiter
    final res = await client
        .get(getPostsEndpoint, headers: {"projectCategory": widget.parameter});
    // print(res.body);
    final body = jsonDecode(res.body);

    // print(cdnBaseUrl + body[0]["image"]);
    for (final post in body) {
      setState(() {
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
        Future.delayed(Duration(milliseconds: 50));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttonContainerWidth = 10.w(context);
    double buttonContainerHeight = 5.w(context);
    double buttonContainerPadding = 1.w(context);
    double buttonTextSize = 2.sp(context);

    // if (100.w(context) < 1500) {
    //   buttonContainerHeight = 50;
    //   buttonContainerPadding = 15;
    // }

    print(100.w(context));
    print(100.h(context));
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
          //
          // New Project Button
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0.5.w(context), 1.w(context)),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Hero(
                  tag: "newProjectForm",
                  // transitionOnUserGestures: true,
                  child: Container(
                    padding: EdgeInsets.all(buttonContainerPadding),
                    height: buttonContainerHeight,
                    width: buttonContainerWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.w(context)),
                      color: const Color.fromARGB(185, 21, 19, 22),
                      border: Border.all(color: deckBorderColor),
                    ),
                    child: TactileButton(
                      scale: 1.05,
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                opaque: false,
                                barrierDismissible: true,
                                transitionDuration: Duration(milliseconds: 200),
                                // reverseTransitionDuration:
                                //     Duration(milliseconds: 300),
                                pageBuilder: (context, _, __) {
                                  return Center(
                                    child: Hero(
                                      transitionOnUserGestures: true,
                                      tag: "newProjectForm",
                                      flightShuttleBuilder:
                                          flightShuttleBuilder,
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: NewProjectForm(),
                                      ),
                                    ),
                                  );
                                }));
                      },
                      child: GradientContainer(
                          height: 5.h(
                              context), // not used; padding of parent  container sets the height and width
                          width: 100, // not used
                          text: "New Project",
                          textSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                          gradient1: red,
                          gradient2: pink,
                          neonGlow: pink,
                          borderColor: tran,
                          borderRadius: 25.w(context)),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
