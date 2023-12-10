import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/mobile/mobile_constants.dart';

import 'package:ionicons/ionicons.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../util/home_button.dart';
import '../../util/logout_dock_button.dart';
import 'mobile_dock_buttons/mob_friends_dock_button.dart';
import 'mobile_dock_buttons/mob_help_dock_button.dart';
import 'mobile_dock_buttons/mob_info_dock_button.dart';
import 'mobile_dock_buttons/mob_messages_dock_button.dart';
import 'mobile_dock_buttons/mob_settings_dock_button.dart';
import 'mobile_dock_buttons/mob_wallet_dock_button.dart';

class MobDock extends StatefulWidget {
  MobDock({
    super.key,
    required this.newGrad1,
    required this.newGrad2,
    required this.newGlow,
  });
  Color newGrad1;
  Color newGrad2;
  Color newGlow;

  @override
  State<MobDock> createState() => _MobDockState();
}

class _MobDockState extends State<MobDock> with AnimationMixin {
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
                  const MobMessagesWindowButton(),
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
                  MobSettingsWindowButton(
                    dockIcon: const Icon(
                      Ionicons.settings_sharp,
                      size: 50,
                    ),
                  ),

                  //Wallet
                  MobWalletWindowButton(
                    dockIcon: const Icon(
                      Ionicons.wallet,
                      size: 50,
                    ),
                  ),

                  //Friends
                  const MobFriendsWindowButton(),
                ],
              ),

              //PAGE 3
              const Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                runAlignment: WrapAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  //
                  //Help
                  MobHelpWindowButton(),

                  //About Us/Info
                  MobInfoWindowButton(),

                  //Logout
                  LogoutWindowButton(),
                ],
              ),
            ],
          )),
    );
  }
//Settings button
}
