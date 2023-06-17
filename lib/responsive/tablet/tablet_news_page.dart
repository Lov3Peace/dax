import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/test_page.dart';
import 'package:flutter_application_1/util/big_dock.dart';
import 'package:flutter_application_1/util/dock.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_application_1/responsive/constants.dart';

import '../../pages/main.dart';
import '../../util/background.dart';

class TabNewsPage extends StatefulWidget {
  const TabNewsPage(
      {super.key, required Animation<double> transitionAnimation});

  @override
  State<TabNewsPage> createState() => _TabNewsPageState();
}

class _TabNewsPageState extends State<TabNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: tabAppBar(),
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
                    itemCount: NewsStacks().tabNewsStacks.length,
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
                                    child: NewsStacks().tabNewsStacks[index]),
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
            const Dock()
          ],
        ),
      ),
    );
  }
}
