// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/newProjectButton.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/newProjectForm.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectPostCard.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
// import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectsList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/util/stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/util/ui/blurryContainer.dart';
import 'package:flutter_application_1/util/ui/gradient_label.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:flutter_application_1/util/test/test_container.dart';
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
  final cdnBaseUrl = "https://assets.crbn.cx/carbon-assets/images/";
  // final cdnBaseUrl = "http://10.7.77.10:8010/carbon-assets/";
  var posts = [];
  late var _getPosts;

  @override
  void initState() {
    // Call getPosts once in the build by doing x = getPosts()
    _getPosts = getPosts().timeout(Duration(seconds: 7));
    super.initState();
  }

  Future getPosts() async {
    // Header Format = projectCategory : category-with-dashes-delimiter

    try {
      final parameter = widget.parameter;
      final getProjectPostsEndpoint =
          Uri.parse("$hostname/api/projectPosts/$parameter");
      print("GetProjectPostsEndpoint: $getProjectPostsEndpoint");
      final res = await client.get(getProjectPostsEndpoint,
          headers: {"projectCategory": widget.parameter});
      // print(res.body);
      final body = jsonDecode(res.body);

      // print(cdnBaseUrl + body[0]["image"]);
      for (final post in body) {
        print(post);
        posts.add(ProjectPostCard(
            category: post["category"],
            postTitle: post["title"],
            user: post["username"],
            description: post["description"],
            teammates: post["teammates"].toString(),
            rolesNeeded: post["roles_needed"].toString() == "[]" ||
                    post["roles_needed"].toString() == "null"
                ? "None"
                : post["roles_needed"].toString(),
            timestamp: post["display_timestamp"],
            image: post["images"][0].replaceAll("[", "").replaceAll("]", ""),
            gradient1: red,
            gradient2: pink,
            neonGlow: pink,
            shadowColor: tran));
      }
      setState(() {
        print(posts);
        posts = posts;
        // Future.delayed(Duration(milliseconds: 100));
      });
      return body;
    } catch (e) {
      print("Couldn't eeen do it: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (100.w(context) < 1500) {
    //   buttonContainerHeight = 50;
    //   buttonContainerPadding = 15;
    // }
    // return Future

    return FutureBuilder(
        // Always REFERENCE the future (set it to a local variable like _getPosts). Dont call it, like _getPosts().
        // Calling a function in build will call it over and over
        future: _getPosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                posts.isEmpty
                    ? Center(
                        child: BlurryContainer(
                          width: 20.w(context),
                          height: 7.w(context),
                          borderRadius: 20.w(context),
                          child: Center(
                            child: Text("No Projects Found"),
                          ),
                        ),
                      )
                    : StaggerLoad(
                        duration: 300,
                        layer: 1,
                        delay: 100,
                        scrollDirection: Axis.vertical,
                        widgets: posts,
                        scale: 1.01,
                        listPadding: EdgeInsets.fromLTRB(0.5.w(context),
                            7.w(context), 0.5.w(context), 7.w(context)),
                        childPadding: EdgeInsets.all(0.5.w(context)),
                        physics: const AlwaysScrollableScrollPhysics(),
                      ),
                //
                // New Project Button
                NewProjectButton()
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _getPosts;
  }
}
