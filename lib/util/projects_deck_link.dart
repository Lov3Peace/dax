import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/projects_deck.dart';
import 'package:simple_animations/animation_controller_extension/animation_controller_extension.dart';
import 'package:simple_animations/simple_animations.dart';

import '../pages/projects_page.dart';

class ProjectsDeckLink extends StatefulWidget {
  const ProjectsDeckLink({super.key});

  @override
  State<ProjectsDeckLink> createState() => _ProjectsDeckLinkState();
}

class _ProjectsDeckLinkState extends State<ProjectsDeckLink>
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
                  return ProjectsPage(
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
          child: ProjectsDeck(),
        ),
      ),
    );
  }
}
