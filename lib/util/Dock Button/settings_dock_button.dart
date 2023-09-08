import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../Window Route/settings_window_route.dart';

class SettingsWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  SettingsWindowButton({super.key, required, required this.dockIcon});
  Widget dockIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(SettingsWindowRoute(builder: (context) {
            return const SettingsWindowPopupCard();
          }));
        },
        child: Hero(
          tag: heroSettingWindow,
          child: Material(
            color: tran,
            child: dockIcon,
          ),
        ),
      ),
    );
  }
}

const String heroSettingWindow = 'settings-window-hero';

class SettingsWindowPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const SettingsWindowPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h, top: 4.h),
            child: Center(
              child: Container(
                height: 85.h,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(32)),
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Hero(
                  tag: heroSettingWindow,
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: Material(
                    shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
                    color:
                        const Color.fromARGB(42, 55, 52, 52).withOpacity(0.7),
                    elevation: 2,
                    borderRadius: BorderRadius.circular(32),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                              height: 85.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(182, 31, 31, 31)),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
