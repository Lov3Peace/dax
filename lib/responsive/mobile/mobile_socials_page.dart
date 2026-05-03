import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter/rendering.dart';
import '../../main.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_application_1/responsive/mobile/mob_constants.dart';
import 'mob_artboard_page.dart';
import 'mobile_dock.dart';

class MobSocialsPage extends StatefulWidget {
  const MobSocialsPage(
      {super.key, required Animation<double> transitionAnimation});

  @override
  State<MobSocialsPage> createState() => _MobSocialsPageState();
}

class _MobSocialsPageState extends State<MobSocialsPage> {
  late ScrollController _scrollController;

  double _showAppBar = 1.0;

  @override
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
                      neonGlow: const Color.fromARGB(78, 4, 4, 4),
                      rightPad: 0,
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
                      neonGlow: const Color.fromARGB(78, 4, 4, 4),
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
            const ArtBoardScreen(),
            AnimationLimiter(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                itemCount: SocialsStacks().mobSocialsStacks.length,
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
                                    return const SizedBox();
                                  }));
                                },
                                child: SocialsStacks().mobSocialsStacks[index]),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            MobDock(
              newGlow: orangeGlow,
              newGrad1: orange,
              newGrad2: purp,
            )
          ],
        ),
      ),
    );
  }
}
