import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_constants.dart';
import 'package:flutter_application_1/responsive/mobile/mobile_finance_page.dart';
import 'package:flutter_application_1/util/GlobalProvider.dart';
import 'package:flutter_application_1/util/gradient_container.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../mobile/mobile_news_page.dart';
import '../mobile/mobile_projects_page.dart';
import '../mobile/mobile_socials_page.dart';
import '../tablet/tablet_finance_page.dart';
import '../tablet/tablet_news_page.dart';
import '../tablet/tablet_projects_page.dart';
import '../tablet/tablet_socials_page.dart';
import 'bubble_deck_pages/desk_finance_page.dart';
import 'bubble_deck_pages/desk_news_page.dart';
import 'bubble_deck_pages/desk_project_page.dart';
import 'bubble_deck_pages/desk_socials_page.dart';

//
//Project Button
class ProjectsButton extends StatelessWidget {
  const ProjectsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, value, child) => Hero(
        tag: value.projectsHeroTag,
        flightShuttleBuilder: flightShuttleBuilder,
        child: TactileButton(
          scale: 0.9,
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100)).then((_) {
              final heroOff = context.read<GlobalProvider>();
              heroOff.heroOff();
              print(value.socialsHeroTag);
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.linear);
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    if (screenWidth < 550) {
                      return MobProjectsPage(
                        transitionAnimation: animation,
                      );
                    } else if (screenWidth < 1100) {
                      return TabProjectsPage(
                        transitionAnimation: animation,
                      );
                    } else {
                      // ignore: prefer_const_constructors
                      return DeskProjectsPage(
                          //transitionAnimation: animation,
                          );
                    }
                  },
                  transitionDuration: const Duration(milliseconds: 200),
                ),
              );
            });
          },
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
        ),
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
    return Consumer<GlobalProvider>(
      builder: (context, value, child) => Hero(
        tag: value.newsHeroTag,
        flightShuttleBuilder: flightShuttleBuilder,
        child: TactileButton(
          scale: 0.9,
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100)).then((_) {
              final heroOff = context.read<GlobalProvider>();
              heroOff.heroOff();
              print(value.socialsHeroTag);
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.linear);
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    if (screenWidth < 550) {
                      return MobNewsPage(
                        transitionAnimation: animation,
                      );
                    } else if (screenWidth < 1100) {
                      return TabNewsPage(
                        transitionAnimation: animation,
                      );
                    } else {
                      // ignore: prefer_const_constructors
                      return DeskNewsPage(
                          //transitionAnimation: animation,
                          );
                    }
                  },
                  transitionDuration: const Duration(milliseconds: 200),
                ),
              );
            });
          },
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
        ),
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
    return Consumer<GlobalProvider>(
      builder: (context, value, child) => Hero(
        tag: value.financesHeroTag,
        flightShuttleBuilder: flightShuttleBuilder,
        child: TactileButton(
          scale: 0.9,
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100)).then((_) {
              final heroOff = context.read<GlobalProvider>();
              heroOff.heroOff();
              print(value.socialsHeroTag);
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.linear);
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    if (screenWidth < 550) {
                      return MobFinancePage(
                        transitionAnimation: animation,
                      );
                    } else if (screenWidth < 1100) {
                      return TabFinancePage(
                        transitionAnimation: animation,
                      );
                    } else {
                      // ignore: prefer_const_constructors
                      return DeskFinancesPage(
                          //transitionAnimation: animation,
                          );
                    }
                  },
                  transitionDuration: const Duration(milliseconds: 200),
                ),
              );
            });
          },
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
        ),
      ),
    );
  }
}

//
//Socials Button
class SocialsButton extends StatelessWidget {
  const SocialsButton({super.key});
  get socsTag => GlobalProvider().socialsHeroTag;
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, value, child) => Hero(
        tag: value.socialsHeroTag,
        flightShuttleBuilder: flightShuttleBuilder,
        child: TactileButton(
          scale: 0.9,
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100)).then((_) {
              final heroOff = context.read<GlobalProvider>();
              heroOff.heroOff();
              print(value.socialsHeroTag);
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.linear);
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
                  transitionDuration: const Duration(milliseconds: 200),
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
        ),
      ),
    );
  }
}
