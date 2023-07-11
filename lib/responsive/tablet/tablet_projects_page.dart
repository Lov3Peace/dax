import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/responsive/tablet/tab_constants.dart';
import 'package:flutter_application_1/util/big_dock.dart';
import 'package:flutter_application_1/util/dock.dart';
import 'package:flutter_application_1/util/projects_stacks_list2.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../pages/keyboards_deck.dart';
import '../../pages/main.dart';
import '../../util/background.dart';

class TabProjectsPage extends StatefulWidget {
  final Animation<double> transitionAnimation;
  const TabProjectsPage({super.key, required this.transitionAnimation});

  State<TabProjectsPage> createState() => _TabProjectsPageState();
}

class _TabProjectsPageState extends State<TabProjectsPage> {
  late ScrollController _scrollController;

  double _showAppBar = 1.0;

  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        // Calculate the new opacity based on the scroll offset
        _showAppBar = 1.0 - (_scrollController.offset / 100.0);
        // Limit the opacity value between 0.0 and 1.0
        _showAppBar = _showAppBar.clamp(0.0, 1.0);
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _showAppBar = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: tran,
            shadowColor: tran,
            automaticallyImplyLeading: false,
            leadingWidth: screenWidth * 0.9,
            toolbarHeight: lerpDouble(0, 10, 8),
            flexibleSpace: Padding(
              padding: EdgeInsets.fromLTRB(
                  screenWidth * .05, 30, screenWidth * .05, 0),
              child: Opacity(
                opacity: _showAppBar,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: 'title',
                      flightShuttleBuilder: flightShuttleBuilder,
                      child: TitleBubble(
                        deckHeight: screenHeight * 0.05,
                        deckWidth: screenWidth * 0.4,
                        deckName: 'Dashboard',
                        gradient1: tran,
                        gradient2: tran,
                        neonGlow: tran,
                        leftPad: 0,
                      ),
                    ),
                    Hero(
                      tag: 'profile',
                      flightShuttleBuilder: flightShuttleBuilder,
                      child: ProfileBubble(
                        deckHeight: screenHeight * 0.05,
                        deckWidth: screenWidth * 0.3,
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
          ),
          body: Stack(
            alignment: const AlignmentDirectional(0, 1),
            fit: StackFit.loose,
            children: [
              Background(),
              AnimationLimiter(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  itemCount: ProjectStacks().tabProjectStacks.length,
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
                                      return const KeyboardsDeck();
                                    }));
                                  },
                                  child:
                                      ProjectStacks().tabProjectStacks[index]),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Dock(
                newGlow: red,
                newGrad1: red,
                newGrad2: purp,
              )
            ],
          )),
    );
  }
}
