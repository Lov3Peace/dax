import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import 'news_deck.dart';

class StaggerAnim extends State<StatefulWidget> with AnimationMixin {
  @override
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> opacity;
  late AnimationController widthController;
  late AnimationController heightController;
  late AnimationController colorController;
  Widget newsDeckVar = NewsDeck();
  void staggerThatBih() {
    @override
    void initState() {
      // TODO: implement initState

      controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      );
      scale = Tween<double>(begin: 1.0, end: 0.9).animate(controller);
      opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
      controller.play();

      super.initState();
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
