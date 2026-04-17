import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/blurryContainer.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/gradient_text.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../main.dart';
import '../../../util/tactile_button.dart';
import '../desk_decks.dart';
import 'package:rive/rive.dart' as r;

import '../decks_content/projects/desktop_projects_page.dart';

class ProjectsDeck extends StatefulWidget {
  const ProjectsDeck({Key? key}) : super(key: key);

  @override
  State<ProjectsDeck> createState() => _ProjectsDeckState();
}

class _ProjectsDeckState extends State<ProjectsDeck> {
  @override
  Widget build(BuildContext context) {
    return TactileButton(
        onTap: () {
          router.go("/projects");
        },
        child: BlurryContainer(
          height: 7.w(context),
          width: 30.w(context),
          constraints: BoxConstraints(minHeight: 200),
          borderRadius: 50.w(context),
          padding: 0.5.w(context),
          color: deckBackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 5.w(context),
                  child: const r.RiveAnimation.asset(
                    'rive/building_apartments.riv',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradientText(
                        text: "Projects",
                        gradients: const [pink, red],
                        fontSize: 3.sp(context),
                        fontWeight: FontWeight.bold,
                      ),
                      Text(
                        'Post, join, or support independent projects anywhere in the world.',
                        style: TextStyle(
                            fontSize: 2.5.sp(context),
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )

        // riveAnim:
        );
  }
}
