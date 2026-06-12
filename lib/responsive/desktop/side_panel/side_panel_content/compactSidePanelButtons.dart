import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/connections/desk_connections_popup.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/desk_dock_button_templates/sp_button_template.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/desk_home_button.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/help/desk_help_popup.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/info/desk_info_popup.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/settings/desk_settings_popup.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/wallet/desk_wallet_popup.dart';
import 'package:flutter_application_1/util/imports.dart';

class CompactSidePanelButtons extends StatelessWidget {
  const CompactSidePanelButtons({super.key});

  @override
  Widget build(BuildContext context) {
    //final buttonState = Provider.of<ButtonState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        DeskHomeButton(
          hoverWidth: 4.w(context),
          text: '',
        ),
        SpButtonTemplate(
          icon: Icons.wallet,
          deskButtonText: '',
          hoverWidth: 4.25.w(context),
          slideOverWidth: 5,
          child: WalletPopUp(),
        ),
        SpButtonTemplate(
          icon: Icons.person,
          deskButtonText: '',
          hoverWidth: 4.25.w(context),
          slideOverWidth: 5,
          child: ConnectionsPopUp(),
        ),
        SpButtonTemplate(
          icon: Icons.settings,
          deskButtonText: '',
          hoverWidth: 4.25.w(context),
          slideOverWidth: 5,
          child: SettingsPopUp(),
        ),
        SpButtonTemplate(
          icon: Icons.help,
          deskButtonText: '',
          hoverWidth: 4.25.w(context),
          slideOverWidth: 5,
          child: HelpPopUp(),
        ),
        SpButtonTemplate(
          icon: Icons.info,
          deskButtonText: '',
          hoverWidth: 4.25.w(context),
          slideOverWidth: 5,
          child: InfoPopUp(),
        ),
      ],
    );
  }
}
