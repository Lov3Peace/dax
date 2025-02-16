// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/wallet/desk_wallet_popup/desk_wallet_popup.dart.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/sp_button_template.dart';
import 'package:flutter_application_1/util/gradient_container.dart';
import 'package:flutter_application_1/util/logout_dock_button.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../desk_constants.dart';
import '../desk_decks.dart';
import 'desk_dock_buttons/connections/desk_connections_popup.dart';
import 'desk_dock_buttons/desk_home_dock_button.dart';
import 'desk_dock_buttons/help/desk_help_popup.dart';
import 'desk_dock_buttons/info/desk_info_popup.dart';
import 'desk_dock_buttons/settings/desk_settings_popup.dart.dart';

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

    scale = Tween<double>(begin: 1.0, end: 0.7).animate(controller);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);

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
          decoration: BoxDecoration(color: const Color.fromARGB(185, 21, 19, 22), border: Border.all(color: deckBorderColor), boxShadow: [
            // BoxShadow(
            //   blurRadius: 10,
            //   color: Color.fromARGB(255, 37, 37, 37),
            //   offset: Offset(0, 0),
            // )
          ]),
          width: 12.5.w,
          child: Padding(
            padding: EdgeInsets.only(left: 1.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                //Logo
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5.h, 0, 1.h),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(1.5.w)),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset("images/omni-temp-logo.png", height: 5.w)),
                ),
                // Divider(
                //   color: Colors.grey,
                //   thickness: 0.5,
                //   indent: 1.w,
                //   endIndent: 2.w,
                // ),
                SizedBox(
                  height: 5.h,
                ),
                //Home

                SidePanelButtons(),
                //
                //Logout
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
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
        SizedBox(height: 2.h),
        SpButtonTemplate(
          icon: Icons.wallet,
          deskButtonText: 'Wallet',
          child: WalletPopUp(),
        ),
        SizedBox(height: 2.h), // Adjusted the height to 2.h
        SpButtonTemplate(
          icon: Icons.person,
          deskButtonText: 'Connections',
          child: FriendsPopUp(),
        ),
        SizedBox(height: 2.h), // Adjusted the height to 2.h
        SpButtonTemplate(
          icon: Icons.settings,
          deskButtonText: 'Settings',
          child: SettingsPopUp(),
        ),
        SizedBox(height: 2.h), // Adjusted the height to 2.h
        SpButtonTemplate(
          icon: Icons.help,
          deskButtonText: 'Help',
          child: HelpPopUp(),
        ),
        SizedBox(height: 2.h), // Adjusted the height to 2.h
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
