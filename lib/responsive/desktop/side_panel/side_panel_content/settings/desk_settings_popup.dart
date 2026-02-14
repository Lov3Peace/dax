import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/desk_dock_button_templates/sp_card_template.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/settings/settings_content_panel.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/settings/settings_side_panel.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../../desk_decks.dart';
import 'settings_templates/settings_header.dart';

class SettingsPopUp extends StatefulWidget {
  const SettingsPopUp({super.key});

  @override
  State<SettingsPopUp> createState() => _SettingsPopUpState();
}

class _SettingsPopUpState extends State<SettingsPopUp> {
  String settingsTab = "account";
  @override
  Widget build(BuildContext context) {
    return SPCardTemplate(
      height: 100.h(context),
      width: 71.w(context),
      borderColor: deckBorderColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top spacing / title row
          Padding(
            padding: EdgeInsets.only(
              left: 1.5.w(context),
              right: 1.5.w(context),
              top: 1.5.h(context),
              bottom: 1.h(context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SettingsHeader(
                  tab: settingsTab,
                  // If later you track a sub-section (e.g. "Preferences"),
                  // pass it here: subSection: "Preferences"
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 5.h(context), left: 2.w(context)),
                  child: SettingsNavRail(
                    selected: settingsTab,
                    onSelect: (v) => setState(() => settingsTab = v),
                  ),
                ),
                SizedBox(width: 2.w(context)),
                SettingsContentPanel(tab: settingsTab),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
