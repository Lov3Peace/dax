import 'package:flutter/material.dart';
import '../util/background.dart';
import '../util/big_dock.dart';
import '../util/profile_bubble.dart';
import '../util/socials_stacks_list.dart';
import '../util/title_bubble.dart';
import 'main.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SocialsPage extends StatefulWidget {
  const SocialsPage(
      {super.key, required Animation<double> transitionAnimation});

  @override
  State<SocialsPage> createState() => _SocialsPageState();
}

class _SocialsPageState extends State<SocialsPage> {
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
                    deckName: 'Socials',
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
                    itemCount: SocialsStacks().socialsStacks.length,
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
                                SocialsStacks().socialsStacks[index],
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
            BigDock(newGrad1: orange, newGrad2: purp, newGlow: orangeGlow),
          ],
        ),
      ),
    );
  }
}
