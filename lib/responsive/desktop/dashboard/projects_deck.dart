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

class ProjectsDeck extends StatelessWidget {
  const ProjectsDeck(
      {Key? key, this.height = 0, this.width = 0, required this.constraints})
      : super(key: key);
  final double height;
  final double width;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return TactileButton(
        onTap: () {
          router.go("/projects");
        },
        child: BlurryContainer(
          height: height,
          width: width,
          constraints: constraints,
          borderRadius: 50.w(context),
          padding: EdgeInsets.symmetric(
              horizontal: max(desktopContainerPadLowerLimit, 1.w(context))),
          color: deckBackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //
              // Project Rive Animation
              Container(
                width: max(50, 3.w(context)),
                child: const r.RiveAnimation.asset(
                  'rive/building_apartments.riv',
                ),
              ),
              //
              // Project Heading and Description
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          max(desktopContainerPadLowerLimit, 0.5.w(context))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradientText(
                        text: "Projects",
                        gradients: const [pink, red],
                        fontSize: max(24, 5.sp(context)),
                        fontWeight: FontWeight.bold,
                      ),
                      Text(
                        'Post, join, or support independent projects anywhere in the world.',
                        style: TextStyle(
                            fontSize: max(10, 2.5.sp(context)),
                            fontWeight: FontWeight.normal),
                        // overflow: TextOverflow.ellipsis,
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
