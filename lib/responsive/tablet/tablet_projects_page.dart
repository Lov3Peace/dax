import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/big_dock.dart';
import 'package:flutter_application_1/util/projects_stacks_list2.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_application_1/responsive/constants.dart';
import '../../pages/keyboards_deck.dart';
import '../../pages/main.dart';
import '../../util/background.dart';

class TabProjectsPage extends StatelessWidget {
  final Animation<double> transitionAnimation;
  const TabProjectsPage({super.key, required this.transitionAnimation});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: tabAppBar(),
          body: Stack(
            alignment: const AlignmentDirectional(0.9, 1),
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
                      itemCount: ProjectStacks().tabProjectStacks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          delay: const Duration(milliseconds: 100),
                          position: index,
                          duration: const Duration(milliseconds: 700),
                          child: ScaleAnimation(
                            scale: 0.8,
                            curve: Curves.easeOutBack,
                            child: FadeInAnimation(
                              child: Column(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const KeyboardsDeck();
                                        }));
                                      },
                                      child: ProjectStacks()
                                          .tabProjectStacks[index]),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Column(
                  //     children: ProjectStacks().projectStacks,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Column(
                  //     children: ProjectStacks2().projectStacks2,
                  //   ),
                  // ),
                ],
              ),
              BigDock(newGrad1: red, newGrad2: purp, newGlow: red)
            ],
          )),
    );
  }
}
