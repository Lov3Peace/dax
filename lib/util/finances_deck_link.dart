import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/projects_deck_template.dart';
import 'package:simple_animations/animation_controller_extension/animation_controller_extension.dart';
import 'package:simple_animations/simple_animations.dart';

import '../pages/finance_page.dart';
import '../pages/projects_page.dart';
import 'finances_deck_template.dart';

class FinancesDeckLink extends StatefulWidget {
  const FinancesDeckLink({super.key});

  @override
  State<FinancesDeckLink> createState() => _FinancesDeckLinkState();
}

class _FinancesDeckLinkState extends State<FinancesDeckLink>
    with AnimationMixin {
  @override
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> opacity;
  @override
  void initState() {
    // TODO: implement initState

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    scale = Tween<double>(begin: 1.0, end: 0.9).animate(controller);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    controller.stop();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          controller.play();
          Future.delayed(const Duration(milliseconds: 100)).then((_) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  animation =
                      CurvedAnimation(parent: animation, curve: Curves.linear);
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FinancePage(
                    transitionAnimation: animation,
                  );
                },
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          });
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            controller.reset();
          });
        });
      },
      child: ScaleTransition(
        scale: scale,
        child: AnimatedOpacity(
          opacity: opacity.value,
          duration: const Duration(milliseconds: 300),
          child: FinancesDeck(),
        ),
      ),
    );
  }
}
