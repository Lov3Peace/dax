import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../util/home_button.dart';
import 'dock buttons/tab_friends_dock_button.dart';
import 'dock buttons/tab_help_dock_button.dart';
import 'dock buttons/tab_info_dock_button.dart';
import 'dock buttons/tab_logout_dock_button.dart';
import 'dock buttons/tab_messages_dock_button.dart';
import 'dock buttons/tab_settings_dock_button.dart';
import 'dock buttons/tab_wallet_dock_button.dart';
import 'tablet_constants.dart';

class TabDock extends StatefulWidget {
  TabDock({
    super.key,
    required this.newGrad1,
    required this.newGrad2,
    required this.newGlow,
  });
  Color newGrad1;
  Color newGrad2;
  Color newGlow;

  @override
  State<TabDock> createState() => _TabDockState();
}

class _TabDockState extends State<TabDock> with AnimationMixin {
  late Animation<double> scale;
  late Animation<double> opacity;
  void initState() {
    // TODO: implement initState

    scale = Tween<double>(begin: 1.0, end: 0.7).animate(controller);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color.fromARGB(134, 10, 10, 10),
                Color.fromARGB(230, 24, 24, 24),
              ], transform: GradientRotation(180)),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: const Color.fromARGB(148, 37, 37, 37)),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5,
                  color: Color.fromARGB(255, 8, 8, 8),
                  offset: Offset(0, 0),
                ),
                // BoxShadow(
                //   blurRadius: 10,
                //   color: Color.fromARGB(255, 37, 37, 37),
                //   offset: Offset(0, 0),
                // )
              ]),
          width: 90.w,
          height: 12.h,
          child: PageView(
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.antiAlias,
            children: [
              /*PAGE 1
                */
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                runAlignment: WrapAlignment.center,
                children: [
                  //
                  //Profile
                  DockButton(icon: Ionicons.person_circle_outline),

                  //Home
                  HomeButton(
                      gradient1: widget.newGrad1,
                      gradient2: widget.newGrad2,
                      glow: widget.newGlow),

                  //Messages
                  const TabMessagesWindowButton(),
                ],
              ),

              //PAGE 2
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                runAlignment: WrapAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  //
                  //Settings
                  TabSettingsWindowButton(
                    dockIcon: const Icon(
                      Ionicons.settings_sharp,
                      size: 50,
                    ),
                  ),

                  //Wallet
                  TabWalletWindowButton(
                    dockIcon: const Icon(
                      Ionicons.wallet,
                      size: 50,
                    ),
                  ),

                  //Friends
                  const TabFriendsWindowButton(),
                ],
              ),

              //PAGE 3
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                runAlignment: WrapAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  //
                  //Help
                  const TabHelpWindowButton(),

                  //About Us/Info
                  const TabInfoWindowButton(),

                  //Logout
                  const TabLogoutWindowButton(),
                ],
              ),
            ],
          )),
    );
  }
//Settings button
}
