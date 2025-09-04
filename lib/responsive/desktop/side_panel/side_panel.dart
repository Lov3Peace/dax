// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

import 'package:flutter_application_1/util/logout_dock_button.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:simple_animations/simple_animations.dart';

import '../desk_decks.dart';
import 'side_panel_content/connections/desk_connections_popup.dart';
import 'side_panel_content/desk_home_button.dart';
import 'side_panel_content/help/desk_help_popup.dart';
import 'side_panel_content/info/desk_info_popup.dart';
import 'side_panel_content/settings/desk_settings_popup.dart';
import 'side_panel_content/desk_dock_button_templates/sp_button_template.dart';
import 'side_panel_content/wallet/desk_wallet_popup.dart';

class DesktopSidePanel extends StatefulWidget {
  DesktopSidePanel({
    super.key,
  });

  @override
  State<DesktopSidePanel> createState() => _DesktopSidePanelState();
}

class _DesktopSidePanelState extends State<DesktopSidePanel>
    with AnimationMixin {
  late Animation<double> scale;
  late Animation<double> opacity;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 12.5.w(context),
          height: 100.h(context),
          constraints: BoxConstraints(minHeight: 950),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: const Color.fromARGB(185, 21, 19, 22),
              border: Border.all(color: deckBorderColor),
              boxShadow: [
                // BoxShadow(
                //   blurRadius: 10,
                //   color: Color.fromARGB(255, 37, 37, 37),
                //   offset: Offset(0, 0),
                // )
              ]),
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.only(left: 1.w(context)),
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        //Logo
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(1.5.w(context))),
                              clipBehavior: Clip.hardEdge,
                              child: Image.asset("images/omni-temp-logo.png",
                                  height: 15.sp(context))),
                        ),
                        SidePanelButtons(),
                        Spacer(),
                        //Logout
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: TactileButton(
                            child: LogoutWindowButton(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class SidePanelButtons extends StatelessWidget {
  const SidePanelButtons({super.key});

  @override
  Widget build(BuildContext context) {
    //final buttonState = Provider.of<ButtonState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        DeskHomeButton(),
        SpButtonTemplate(
          icon: Icons.wallet,
          deskButtonText: 'Wallet',
          child: WalletPopUp(),
        ),
        SpButtonTemplate(
          icon: Icons.person,
          deskButtonText: 'Connections',
          child: ConnectionsPopUp(),
        ),
        SpButtonTemplate(
          icon: Icons.settings,
          deskButtonText: 'Settings',
          child: SettingsPopUp(),
        ),
        SpButtonTemplate(
          icon: Icons.help,
          deskButtonText: 'Help',
          child: HelpPopUp(),
        ),
        SpButtonTemplate(
          icon: Icons.info,
          deskButtonText: 'Info',
          child: InfoPopUp(),
        ),
      ],
    );
  }
}

//
// Contains all buttonsin the dock
