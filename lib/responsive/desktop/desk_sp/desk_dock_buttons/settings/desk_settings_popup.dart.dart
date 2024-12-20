import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/general_settings.dart';
import 'package:flutter_application_1/util/button_state.dart';
import 'package:flutter_application_1/util/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import 'package:supercharged/supercharged.dart';
import '../../../desk_constants.dart';
import '../../desk_button_functions.dart';
import 'settings_side_panel.dart';

class SettingsPopUp extends StatefulWidget {
  const SettingsPopUp({super.key});

  @override
  State<SettingsPopUp> createState() => _SettingsPopUpState();
}

class _SettingsPopUpState extends State<SettingsPopUp> with AnimationMixin {
  //control = Control.play;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ButtonState>(
      builder: (context, value, child) => CustomAnimationBuilder<double>(
        control: value.settingSlideControl,
        startPosition: 0,
        tween: Tween(begin: 0, end: 83.w),
        duration: const Duration(milliseconds: 1250),
        curve: Curves.easeInOutBack,
        onCompleted: () {
          final resetSlide = context.read<ButtonState>();
          resetSlide.resetSlide(SlideType.settings);
        },
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(value, 0),
            child: child,
          );
        },
        child: Container(
          height: 100.h,
          width: 71.w,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 77.h,
                width: 71.w,
                // padding: const EdgeInsets.symmetric(vertical: 32),
                child: Material(
                  shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
                  color: const Color.fromARGB(140, 20, 20, 30),
                  elevation: 2,
                  borderRadius: BorderRadius.circular(32),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                              // height: 85.h,
                              decoration: BoxDecoration(
                            border: Border.all(color: deckBorderColor),
                            borderRadius: BorderRadius.circular(24),
                          )),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 1.h,
                              bottom: 1.h,
                            ),
                            child: Wrap(
                              spacing: 1.w,
                              children: [
                                // The reverse slide button allows for the slide and button to be reset at anytime
                                // note: may need to work on spacing and padding to get the exact look we are
                                // looking for.
                                const ReverseSlideButton(deskButtonId: 'settings', icon: Icons.arrow_left_rounded),
                                // This column houses both the title of the widget and also the settings side panel
                                // settings side panel is in its own file in the settings folder
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 1.w,
                                        bottom: 2.h,
                                      ),
                                      child: const Text(
                                        'Settings',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36),
                                      ),
                                    ),
                                    //
                                    //
                                    //This container houses the settings panel buttons
                                    Container(
                                      height: 66.h,
                                      width: 14.w,
                                      constraints: const BoxConstraints(maxWidth: 500, minHeight: 250),
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(17, 17, 17, 1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: const Column(
                                          children: [
                                            SettingsSidePanel(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // This container houses the profile attributes and settings containers
                                Container(
                                  height: 74.5.h,
                                  width: 47.w,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(0, 207, 33, 33),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // This container for profile attributes showing how long you have been a member
                                      // profile name, and online status
                                      Container(
                                        height: 15.h,
                                        width: 47.w,
                                        decoration: const BoxDecoration(
                                          color: Color.fromRGBO(17, 17, 17, 1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 1.h, right: 1.5.w, bottom: 1.h),
                                          child: Wrap(
                                            alignment: WrapAlignment.spaceEvenly,
                                            children: [
                                              //Container housing profile picture and basic information
                                              Container(
                                                height: 13.h,
                                                width: 20.w,
                                                decoration: const BoxDecoration(
                                                  color: Color.fromARGB(0, 184, 40, 40),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    // This Text shows the profile ID
                                                    Text(
                                                      auth.currentUser!.email.toString().allBefore('@'),
                                                      style: GoogleFonts.montserrat(
                                                          textStyle: TextStyle(fontSize: headerTextSize, height: 1.0), fontWeight: FontWeight.w600),
                                                    ),
                                                    const Text('Member since 07.17.2023'),
                                                    // This is the row containing online status
                                                    // there will be 3 statuses all together being online, away, and offline.
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 2.h,
                                                          width: 1.w,
                                                          decoration: const BoxDecoration(
                                                            color: Color.fromARGB(255, 9, 223, 41),
                                                            borderRadius: BorderRadius.all(
                                                              Radius.circular(20),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 0.5.w),
                                                          child: const Text('Online'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //Container housing badges achieved on profile so far
                                              Container(
                                                height: 13.h,
                                                width: 16.w,
                                                decoration: const BoxDecoration(
                                                  color: Color.fromRGBO(25, 25, 29, 1),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 1.h, left: 1.w),
                                                      child: const Text(
                                                        'Badges Earned:',
                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      //
                                      //
                                      // This is the container that will be housing all general notes and information
                                      // for each given button in the settings side panel.
                                      // note: we are still designing the Ui for th ebuttons so the code for this will come much later.
                                      GeneralSettingsInfo(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
