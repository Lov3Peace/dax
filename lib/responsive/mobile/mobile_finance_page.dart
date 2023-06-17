import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/big_dock.dart';
import 'package:flutter_application_1/util/dock.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_application_1/responsive/constants.dart';
import '../../pages/keyboards_deck.dart';
import '../../pages/main.dart';
import '../../util/background.dart';

class MobFinancePage extends StatefulWidget {
  final Animation<double> transitionAnimation;
  const MobFinancePage({super.key, required this.transitionAnimation});

  @override
  State<MobFinancePage> createState() => _MobFinancePageState();
}

class _MobFinancePageState extends State<MobFinancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: mobAppBar(),
      body: Stack(
        alignment: const AlignmentDirectional(0, 1),
        fit: StackFit.loose,
        children: [
          Background(),
          AnimationLimiter(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: FinancesStacks().mobFinancesStacks.length,
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
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const KeyboardsDeck();
                                }));
                              },
                              child: FinancesStacks().mobFinancesStacks[index]),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Dock()
        ],
      ),
    );
  }
}
