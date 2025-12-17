// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/newProjectForm.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectPostCard.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
// import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectsList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/large_stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/util/blurryContainer.dart';
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
      final parameter = widget.parameter.toLowerCase();
      final getProjectPostsEndpoint =
          Uri.parse("$hostname/api/projectPosts/$parameter");
      print("GetProjectPostsEndpoint: $getProjectPostsEndpoint");
      final res = await client.get(getProjectPostsEndpoint,
          headers: {"projectCategory": widget.parameter});
      // print(res.body);
      final body = jsonDecode(res.body);

      // print(cdnBaseUrl + body[0]["image"]);
      for (final post in body) {
        setState(() {
          posts.add(ProjectPostCard(
              category: widget.parameter,
              postTitle: post["title"],
              user: post["user"],
              content: post["description"],
              rolesNeeded: post["rolesNeeded"] ?? "None",
              timestamp: post["timestamp"],
              gradient1: red,
              gradient2: pink,
              neonGlow: pink,
              shadowColor: tran));
          Future.delayed(Duration(milliseconds: 50));
        });
      }
      return body;
    } catch (e) {
      print("Couldn't eeen do it: $e");
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
    // return Future

    return FutureBuilder(
        future: _getPosts,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
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
          if (posts.isEmpty) {
            return WebUiTemplate(
              title: "Projects",
              button1: CommunitiesButton(),
              button2: SocialsButton(),
              button3: NewsButton(),
              child: Stack(
                children: [
                  Center(
                    child: BlurryContainer(
                      width: 20.w(context),
                      height: 7.w(context),
                      child: Center(
                        child: Text("No Projects Found"),
                      ),
                    ),
                  ),
                  //
                  // New Project Button
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0.5.w(context), 1.w(context)),
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
                              borderRadius:
                                  BorderRadius.circular(25.w(context)),
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
                                        // maintainState: true,
                                        transitionDuration:
                                            Duration(milliseconds: 500),
                                        // reverseTransitionDuration:
                                        //     Duration(milliseconds: 300),
                                        pageBuilder: (context, _, __) {
                                          return Center(
                                            child: Hero(
                                              transitionOnUserGestures: true,
                                              tag: "newProjectForm",
                                              flightShuttleBuilder:
                                                  textFlightShuttleBuilder2,
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
                  listPadding: EdgeInsets.fromLTRB(
                      0.5.w(context),
                      100.h(context) < 875 ? 100 : 10.h(context),
                      0.5.w(context),
                      0),
                  childPadding: 100.w(context) > 2200
                      ? EdgeInsets.all(10)
                      : EdgeInsets.all(0.25.w(context)),
                  childHeight: 35.w(context),
                  physics: const NeverScrollableScrollPhysics(),
                ),
                //
                // New Project Button
                Padding(
                    padding:
                        EdgeInsets.fromLTRB(0, 0, 0.5.w(context), 1.w(context)),
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
                                      // maintainState: true,
                                      transitionDuration:
                                          Duration(milliseconds: 500),
                                      // reverseTransitionDuration:
                                      //     Duration(milliseconds: 300),
                                      pageBuilder: (context, _, __) {
                                        return Center(
                                          child: Hero(
                                            transitionOnUserGestures: true,
                                            tag: "newProjectForm",
                                            flightShuttleBuilder:
                                                textFlightShuttleBuilder2,
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
        });
  }
}
