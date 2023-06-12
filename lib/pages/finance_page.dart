import '../util/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/big_dock.dart';
import 'keyboards_deck.dart';
import 'main.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_application_1/responsive/constants.dart';

class FinancePage extends StatefulWidget {
  final Animation<double> transitionAnimation;
  const FinancePage({super.key, required this.transitionAnimation});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  deckName: 'Finances',
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
          BigDock(newGrad1: green, newGrad2: blue, newGlow: greenGlow),
        ],
      ),
    );
  }
}
