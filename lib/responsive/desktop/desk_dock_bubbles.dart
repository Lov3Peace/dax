import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/button_state.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:flutter_application_1/util/tactile_button.dart';

import '../../../main.dart';

//
//Project Button
class ProjectsButton extends StatelessWidget {
  const ProjectsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w(context)),
      child: TactileButton(
        scale: 1.05,
        onTap: () {
          router.go("/projects");
        },
        child: GradientContainer(
          gradient1: red,
          gradient2: purp,
          height: 3.5.h(context),
          width: 7.w(context),
          neonGlow: red,
          text: 'Projects',
          textSize: 2.sp(context),
          borderColor: const Color.fromARGB(0, 255, 255, 255),
          borderRadius: 500,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w(context)),
      child: TactileButton(
        scale: 1.05,
        onTap: () {
          router.go("/news");
        },
        child: GradientContainer(
          gradient1: blue,
          gradient2: purp,
          height: 3.5.h(context),
          width: 7.w(context),
          neonGlow: blue,
          text: 'News',
          textSize: 2.sp(context),
          borderColor: const Color.fromARGB(0, 255, 255, 255),
          borderRadius: 500,
        ),
      ),
    );
  }
}

//
//Finances Button
class CommunitiesButton extends StatelessWidget {
  const CommunitiesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w(context)),
      child: TactileButton(
        scale: 1.05,
        onTap: () {
          router.go("/communities");
        },
        child: GradientContainer(
          gradient1: red,
          gradient2: orange,
          height: 3.5.h(context),
          width: 7.w(context),
          neonGlow: orangeGlow,
          text: 'Communities',
          textSize: 2.sp(context),
          borderColor: const Color.fromARGB(0, 255, 255, 255),
          borderRadius: 500,
        ),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w(context)),
      child: TactileButton(
        scale: 1.05,
        onTap: () {
          router.go("/socials");
        },
        child: GradientContainer(
          gradient1: orange,
          gradient2: purp,
          height: 3.5.h(context),
          width: 7.w(context),
          neonGlow: orangeGlow,
          text: 'Socials',
          textSize: 2.sp(context),
          borderColor: const Color.fromARGB(0, 255, 255, 255),
          borderRadius: 500,
        ),
      ),
    );
  }
}
