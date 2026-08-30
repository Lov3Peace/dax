import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectsList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/util/large_stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/test_web_ui_template.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/util/ui/pillButton.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../util/imports.dart';

class DevPage extends StatelessWidget {
  const DevPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebUiTemplate(
      title: "Dev",
      button1: CommunitiesButton(),
      button2: SocialsButton(),
      button3: NewsButton(),
      child: Center(
        child: PillButton(
          width: 10.w(context),
          height: 2.5.w(context),
          color1: deckBackgroundColor,
          color2: deckBackgroundColor,
          onTap: () {},
          borderRadius: 50.w(context),
          borderColor: deckBorderColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: max(5, 0.5.w(context)),
            children: [
              Icon(
                Ionicons.person_add,
                size: max(10, 1.25.w(context)),
              ),
              Text("Add Connection"),
            ],
          ),
        ),
      ),
    );
  }
}
