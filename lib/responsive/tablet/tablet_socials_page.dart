import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/big_dock.dart';
import '../../pages/main.dart';
import '../../util/background.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_application_1/responsive/constants.dart';

class TabSocialsPage extends StatefulWidget {
  const TabSocialsPage(
      {super.key, required Animation<double> transitionAnimation});

  @override
  State<TabSocialsPage> createState() => _TabSocialsPageState();
}

class _TabSocialsPageState extends State<TabSocialsPage> {
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
              physics: const BouncingScrollPhysics(),
              children: [
                AnimationLimiter(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: SocialsStacks().tabSocialsStacks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        delay: const Duration(milliseconds: 200),
                        position: index,
                        duration: const Duration(milliseconds: 700),
                        child: SlideAnimation(
                          horizontalOffset: 100.0,
                          curve: Curves.easeOutBack,
                          child: FadeInAnimation(
                            child: Column(
                              children: [
                                SocialsStacks().tabSocialsStacks[index],
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
            BigDock(newGrad1: orange, newGrad2: purp, newGlow: orangeGlow),
          ],
        ),
      ),
    );
  }
}
