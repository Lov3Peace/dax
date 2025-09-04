import 'package:flutter_application_1/responsive/desktop/dashboard/title_bubble.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectCategoryCard.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectsList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/large_stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/bubble_dock.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import '../../../../util/imports.dart';

class Devpage extends StatelessWidget {
  const Devpage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebUiTemplate(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
          ShaderMask(
            shaderCallback: (Rect rect) {
              return LinearGradient(
                      transform: GradientRotation(20),
                      colors: [Colors.grey, Colors.black54],
                      begin: Alignment(0, 0),
                      end: Alignment(0, 50))
                  .createShader(rect);
            },
            child: Row(
              children: [
                Expanded(
                  // Uniform 0.5.w padding on Row and LargeStagger items (wanted it on the parent but couldnt because of
                  // the padding on the LargeStagger list items)
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0.5.w(context), 0, 0.5.w(context), 0.5.w(context)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //
                        // Title of Screen
                        TitleBubble(
                          deckName: 'Projects',
                        ),

                        //
                        //Houses Deck Buttons
                        BubbleDock(
                            child1: ProjectsButton(),
                            child2: SocialsButton(),
                            child3: NewsButton()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LargeStaggerLoad(
              widgets: projects,
              scale: 1.02,
              constraints: const BoxConstraints(minHeight: 450),
              padding: EdgeInsets.all(0.25.w(context)),
              childHeight: 54.h(context),
              physics: NeverScrollableScrollPhysics(),
            ),
          )
        ]));
  }
}
