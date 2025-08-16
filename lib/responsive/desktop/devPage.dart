import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectCategoryCard.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import '../../util/imports.dart';
import 'dashboard/title_bubble.dart';
import 'desk_dock_bubbles.dart';
import 'util/bubble_dock.dart';

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
          Row(
            children: [
              Expanded(
                // Uniform 0.5.w padding on Row and LargeStagger items (wanted it on the parent but couldnt because of
                // the padding on the LargeStagger list items)
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0.5.w(context), 0, 0.5.w(context), 2.sp(context)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //
                      // Title of Screen
                      TitleBubble(
                        deckName: 'Communities',
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
          ProjectCategory(
              category: "Construction",
              description:
                  "Find projects for planning, design, and building of structures or infrastructure, from residential homes to large-scale commercial developments.",
              width: 35.w(context),
              content: Text("Content"),
              gradient1: red,
              gradient2: pink,
              neonGlow: pink,
              shadowColor: white),
        ]));
  }
}
