// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

import 'package:flutter_application_1/util/logout_dock_button.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:simple_animations/simple_animations.dart';

import '../desk_decks.dart';
import 'desk_dock_buttons/connections/desk_connections_popup.dart';
import 'desk_dock_buttons/desk_home_button.dart';
import 'desk_dock_buttons/help/desk_help_popup.dart';
import 'desk_dock_buttons/info/desk_info_popup.dart';
import 'desk_dock_buttons/settings/desk_settings_popup.dart.dart';
import 'desk_dock_buttons/sp_button_template.dart';
import 'desk_dock_buttons/wallet/desk_wallet_popup.dart';

class DesktopSidePanel extends StatefulWidget {
  DesktopSidePanel({
    super.key,
  });

  @override
  State<DesktopSidePanel> createState() => _DesktopSidePanelState();
}

class _DesktopSidePanelState extends State<DesktopSidePanel> with AnimationMixin {
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
          constraints: BoxConstraints(minHeight: 750),
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
          width: 12.5.w(context),
          child: Padding(
            padding: EdgeInsets.only(left: 1.w(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                //Logo
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(1.5.w(context))),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset("images/omni-temp-logo.png", height: 5.w(context))),
                ),
                // Divider(
                //   color: Colors.grey,
                //   thickness: 0.5,
                //   indent: 1.w(context),
                //   endIndent: 2.w(context),
                // ),
                SizedBox(
                  height: 5.sp(context),
                ),
                SidePanelButtons(),
                Spacer(),
                //Logout
                Padding(
                  padding: EdgeInsets.only(bottom: 2.sp(context)),
                  child: TactileButton(child: LogoutWindowButton()),
                ),
              ],
            ),
          ),
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
      children: [
        DeskHomeButton(),
        SizedBox(height: 20),
        SpButtonTemplate(
          icon: Icons.wallet,
          deskButtonText: 'Wallet',
          child: WalletPopUp(),
        ),
        SizedBox(height: 20), // Adjusted the height to 20
        SpButtonTemplate(
          icon: Icons.person,
          deskButtonText: 'Connections',
          child: FriendsPopUp(),
        ),
        SizedBox(height: 20), // Adjusted the height to 20
        SpButtonTemplate(
          icon: Icons.settings,
          deskButtonText: 'Settings',
          child: SettingsPopUp(),
        ),
        SizedBox(height: 20), // Adjusted the height to 20
        SpButtonTemplate(
          icon: Icons.help,
          deskButtonText: 'Help',
          child: HelpPopUp(),
        ),
        SizedBox(height: 20), // Adjusted the height to 20
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
