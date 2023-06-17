import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/dock.dart';
import '../../pages/main.dart';
import '../../util/background.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_application_1/responsive/constants.dart';
import '../../util/big_dock.dart';

class MobSocialsPage extends StatefulWidget {
  const MobSocialsPage(
      {super.key, required Animation<double> transitionAnimation});

  @override
  State<MobSocialsPage> createState() => _MobSocialsPageState();
}

class _MobSocialsPageState extends State<MobSocialsPage> {
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
                    itemCount: SocialsStacks().mobSocialsStacks.length,
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
                                SocialsStacks().mobSocialsStacks[index],
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
            const Dock()
          ],
        ),
      ),
    );
  }
}
