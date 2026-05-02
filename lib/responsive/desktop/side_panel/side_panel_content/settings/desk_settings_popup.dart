import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/desk_dock_button_templates/sp_card_template.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/settings/settings_content_panel.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/settings/settings_side_panel.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../../desk_decks.dart';
import 'settings_templates/settings_header.dart';

/// Settings popup layout controller (header + nav + content)
/// Manages currently selected tab
class SettingsPopUp extends StatefulWidget {
  const SettingsPopUp({super.key});

  @override
  State<SettingsPopUp> createState() => _SettingsPopUpState();
}

class _SettingsPopUpState extends State<SettingsPopUp> {
  /// Current active settings tab
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
          // Header (updates based on selected tab)
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
                SettingsHeader(tab: settingsTab),
              ],
            ),
          ),

          // Main layout: nav rail + content
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 5.h(context), left: 2.w(context)),
                  child: SettingsNavRail(
                    selected: settingsTab,
                    // Updates tab + rebuilds UI
                    onSelect: (v) => setState(() => settingsTab = v),
                  ),
                ),
                SizedBox(width: 2.w(context)),

                // Displays content based on selected tab
                SettingsContentPanel(tab: settingsTab),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
