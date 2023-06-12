import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/test_page.dart';
import 'package:flutter_application_1/util/big_dock.dart';
import '../util/background.dart';
import 'main.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_application_1/responsive/constants.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key, required Animation<double> transitionAnimation});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: tran,
          shadowColor: tran,
          automaticallyImplyLeading: false,
          leadingWidth: MediaQuery.of(context).size.width * .5,
          flexibleSpace: Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.035,
                25,
                MediaQuery.of(context).size.width * 0.035,
                0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Hero(
                  tag: 'title',
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: TitleBubble(
                    deckHeight: MediaQuery.of(context).size.height * 0.1,
                    deckWidth: MediaQuery.of(context).size.width * 0.4,
                    deckName: 'News',
                    gradient1: tran,
                    gradient2: tran,
                    neonGlow: tran,
                    leftPad: 0,
                  ),
                ),
                Hero(
                  tag: 'profile',
                  child: ProfileBubble(
                    deckHeight: MediaQuery.of(context).size.height * 0.1,
                    deckWidth: MediaQuery.of(context).size.width * 0.30,
                    deckName: 's3rv',
                    gradient1: tran,
                    gradient2: tran,
                    neonGlow: tran,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          alignment: const AlignmentDirectional(0, 1),
          fit: StackFit.loose,
          children: [
            Background(),
            PageView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              children: [
                AnimationLimiter(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: NewsStacks().mobNewsStacks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        delay: const Duration(milliseconds: 200),
                        position: index,
                        duration: const Duration(milliseconds: 700),
                        child: SlideAnimation(
                          horizontalOffset: 100,
                          curve: Curves.easeOutBack,
                          child: FadeInAnimation(
                            child: Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return TestPage();
                                      }));
                                    },
                                    child: NewsStacks().mobNewsStacks[index]),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            BigDock(newGrad1: blue, newGrad2: purp, newGlow: blue),
          ],
        ),
      ),
    );
  }
}
