import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/big_dock.dart';
import 'package:flutter_application_1/util/dock.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_application_1/responsive/constants.dart';

import '../../pages/main.dart';
import '../../pages/test_page.dart';
import '../../util/background.dart';

class MobNewsPage extends StatefulWidget {
  const MobNewsPage(
      {super.key, required Animation<double> transitionAnimation});

  @override
  State<MobNewsPage> createState() => _MobNewsPageState();
}

class _MobNewsPageState extends State<MobNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: mobAppBar(),
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
            const Dock()
          ],
        ),
      ),
    );
  }
}
