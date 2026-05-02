import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectsList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/large_stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/test_web_ui_template.dart';
import '../../../../util/imports.dart';

class Devpage extends StatelessWidget {
  const Devpage({super.key});

  @override
  Widget build(BuildContext context) {
    return TestWebUiTemplate(
      title: "Dev",
      button1: CommunitiesButton(),
      button2: SocialsButton(),
      button3: NewsButton(),
      child: LargeStaggerLoad(
        widgets: [],
        rowWidth: 75.w(context),
        itemsPerRow: 2,
        scale: 1.010,
        duration: 300,
        delay: 75,
        listPadding: EdgeInsets.only(top: 10.h(context)),
        childPadding: EdgeInsets.all(0.25.w(context)),
        childHeight: 52.h(context),
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
