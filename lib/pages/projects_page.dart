import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/big_dock.dart';
import 'package:flutter_application_1/util/projects_stacks_list.dart';
import 'package:flutter_application_1/util/projects_stacks_list2.dart';
import 'package:flutter_application_1/util/title_bubble.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../util/background.dart';
import '../util/profile_bubble.dart';
import 'keyboards_deck.dart';
import 'main.dart';

final List<Widget> projStacks = ProjectStacks().projectStacks;
final List<Widget> projStacks2 = ProjectStacks2().projectStacks2;

class ProjectsPage extends StatelessWidget {
  final Animation<double> transitionAnimation;
  const ProjectsPage({super.key, required this.transitionAnimation});

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
                      deckName: 'Projects',
                      gradient1: tran,
                      gradient2: tran,
                      neonGlow: tran,
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
                      itemCount: ProjectStacks().projectStacks.length,
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
                                      child:
                                          ProjectStacks().projectStacks[index]),
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
