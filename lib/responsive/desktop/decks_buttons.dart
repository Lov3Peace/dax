import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desktop_constants.dart';
import 'package:flutter_application_1/util/gradient_container.dart';
import 'package:flutter_application_1/util/tactile_button.dart';

import '../../../main.dart';
import '../mobile/mobile_socials_page.dart';
import '../tablet/tablet_socials_page.dart';
import 'desk_socials_page.dart';

//
//Project Button
class ProjectsButton extends StatelessWidget {
  const ProjectsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      onTap: () {},
      child: GradientContainer(
        gradient1: red,
        gradient2: purp,
        height: 10,
        width: 30,
        neonGlow: red,
        text: 'Projects',
        textSize: 12,
        borderColor: const Color.fromARGB(0, 255, 255, 255),
        borderRadius: 500,
      ),
    );
  }
}

//
//News Button
class NewsButton extends StatelessWidget {
  const NewsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      onTap: () {},
      child: GradientContainer(
        gradient1: blue,
        gradient2: purp,
        height: 10,
        width: 30,
        neonGlow: blue,
        text: 'News',
        textSize: 12,
        borderColor: const Color.fromARGB(0, 255, 255, 255),
        borderRadius: 500,
      ),
    );
  }
}

//
//Finances Button
class FinancesButton extends StatelessWidget {
  const FinancesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      onTap: () {},
      child: GradientContainer(
        gradient1: green,
        gradient2: blue,
        height: 10,
        width: 30,
        neonGlow: greenGlow,
        text: 'Finances',
        textSize: 12,
        borderColor: const Color.fromARGB(0, 255, 255, 255),
        borderRadius: 500,
      ),
    );
  }
}

//
//Socials Button
class SocialsButton extends StatelessWidget {
  const SocialsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      onTap: () {
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
                if (screenWidth < 550) {
                  return MobSocialsPage(
                    transitionAnimation: animation,
                  );
                } else if (screenWidth < 1100) {
                  return TabSocialsPage(
                    transitionAnimation: animation,
                  );
                } else {
                  // ignore: prefer_const_constructors
                  return DeskSocialsPage(
                      //transitionAnimation: animation,
                      );
                }
              },
              transitionDuration: const Duration(milliseconds: 800),
            ),
          );
        });
      },
      child: GradientContainer(
        gradient1: orange,
        gradient2: purp,
        height: 10,
        width: 30,
        neonGlow: orangeGlow,
        text: 'Socials',
        textSize: 12,
        borderColor: const Color.fromARGB(0, 255, 255, 255),
        borderRadius: 500,
      ),
    );
  }
}
