import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings%20side%20panel/settings_side_panel_buttons.dart';
import 'package:flutter_application_1/util/GlobalProvider.dart';
import 'package:flutter_application_1/util/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:sizer/sizer.dart';
import 'package:supercharged/supercharged.dart';

import '../../../../../util/tactile_button.dart';
import '../../../desk_constants.dart';

class SettingsPopUp extends StatefulWidget {
  const SettingsPopUp({super.key});

  @override
  State<SettingsPopUp> createState() => _SettingsPopUpState();
}

class _SettingsPopUpState extends State<SettingsPopUp> with AnimationMixin {
  //control = Control.play;

  final TextEditingController _textController = TextEditingController();
  bool _isEditingEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, value, child) => CustomAnimationBuilder<double>(
        control: value.settingSlideControl,
        startPosition: 0,
        tween: Tween(begin: 0, end: 83.5.w),
        duration: const Duration(milliseconds: 1250),
        curve: Curves.easeInOutBack,
        onCompleted: () {
          final resetSlide = context.read<GlobalProvider>();
          resetSlide.settingsResetSlide();
        },
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(value, 0),
            child: child,
          );
        },
        child: Center(
          child: Indexer(
            children: [
              Indexed(
                index: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h, top: 4.h),
                      child: Center(
                        child: Container(
                          height: 85.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 24),
                          child: Material(
                            shadowColor:
                                const Color.fromRGBO(42, 41, 41, 0.631),
                            color: const Color.fromARGB(42, 55, 52, 52),
                            elevation: 2,
                            borderRadius: BorderRadius.circular(32),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                        height: 85.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  182, 31, 31, 31)),
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        )),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 1.5.w, top: 1.h),
                                      child: Wrap(
                                        spacing: 1.5.w,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 1.w,
                                                  bottom: 2.h,
                                                ),
                                                child: const Text(
                                                  'Settings',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 36),
                                                ),
                                              ),
                                              //
                                              //
                                              //Container housing the settings panel buttons
                                              Container(
                                                height: 67.5.h,
                                                width: 15.w,
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 500,
                                                        minHeight: 250),
                                                decoration: const BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      17, 17, 17, 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 2.h),
                                                  child: const Column(
                                                    children: [
                                                      SettingsSidePanelButtons(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          //
                                          //
                                          //Container housing the profile attributes and settings containers
                                          Container(
                                            height: 75.h,
                                            width: 47.w,
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  0, 207, 33, 33),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                //
                                                //
                                                //container for profile attributes
                                                Container(
                                                  height: 15.h,
                                                  width: 47.w,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        17, 17, 17, 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(20),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.5.h,
                                                        right: 1.5.w),
                                                    child: Wrap(
                                                      alignment: WrapAlignment
                                                          .spaceEvenly,
                                                      children: [
                                                        //
                                                        //
                                                        //Container housing profile picture and basic information
                                                        Container(
                                                          height: 10.h,
                                                          width: 20.w,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    0,
                                                                    184,
                                                                    40,
                                                                    40),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  20),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 0.25.h,
                                                                    left: 1.w),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                //
                                                                //
                                                                //Text showing profile id
                                                                Text(
                                                                  auth.currentUser!
                                                                      .email
                                                                      .toString()
                                                                      .allBefore(
                                                                          '@'),
                                                                  style: GoogleFonts.montserrat(
                                                                      textStyle: TextStyle(
                                                                          fontSize:
                                                                              headerTextSize,
                                                                          height:
                                                                              1.0),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                const Text(
                                                                    'Member since 07.17.2023'),
                                                                //
                                                                //
                                                                //Row containing online status
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          2.h,
                                                                      width:
                                                                          1.w,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            9,
                                                                            223,
                                                                            41),
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              20),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              0.5.w),
                                                                      child: const Text(
                                                                          'Online'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                        //
                                                        //
                                                        //Container housing badges achieved on profile so far
                                                        Container(
                                                          height: 10.h,
                                                          width: 16.w,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color:
                                                                Color.fromRGBO(
                                                                    25,
                                                                    25,
                                                                    29,
                                                                    1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  20),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            1.h,
                                                                        left: 1
                                                                            .w),
                                                                child:
                                                                    const Text(
                                                                  'Badges Earned:',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20),
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
                                                //container for settings
                                                Container(
                                                  height: 58.h,
                                                  width: 47.w,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        17, 17, 17, 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(20),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.h, left: 2.w),
                                                    child:
                                                        SingleChildScrollView(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        1.5.h),
                                                            child: const Text(
                                                              'General Settings',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 36),
                                                            ),
                                                          ),
                                                          //
                                                          //
                                                          //Container #1 which holds the Username access
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        2.h),
                                                            child: Container(
                                                              height: 16.h,
                                                              width: 43.w,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        25,
                                                                        25,
                                                                        29,
                                                                        1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          20),
                                                                ),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: 2.w,
                                                                    ),
                                                                    //
                                                                    //
                                                                    //This wrap contains the textfield and button that enables the editing of your username on the account
                                                                    child: Wrap(
                                                                      crossAxisAlignment:
                                                                          WrapCrossAlignment
                                                                              .center,
                                                                      spacing:
                                                                          2.w,
                                                                      children: [
                                                                        const Text(
                                                                          'Username:',
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                          width:
                                                                              25.w,
                                                                          child:
                                                                              TextField(
                                                                            controller:
                                                                                _textController,
                                                                            enabled:
                                                                                _isEditingEnabled,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              border: InputBorder.none, //removes bottom line
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            setState(
                                                                              () {
                                                                                _isEditingEnabled = !_isEditingEnabled;
                                                                              },
                                                                            );
                                                                          },
                                                                          child: Text(_isEditingEnabled
                                                                              ? 'Save'
                                                                              : 'Edit'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                    indent: 20,
                                                                    endIndent:
                                                                        20,
                                                                    thickness:
                                                                        2,
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: 2.w,
                                                                    ),
                                                                    child:
                                                                        const Text(
                                                                      'Placeholder',
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          //
                                                          //
                                                          //Container #2
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        2.h),
                                                            child: Container(
                                                              height: 16.h,
                                                              width: 43.w,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        25,
                                                                        25,
                                                                        29,
                                                                        1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          20),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          //
                                                          //
                                                          //Container #3
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        2.h),
                                                            child: Container(
                                                              height: 40.h,
                                                              width: 43.w,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        25,
                                                                        25,
                                                                        29,
                                                                        1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          20),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
                      ),
                    ),
                  ],
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
// Hover aspect of setting button
class DeskSettingsButtonHover extends StatefulWidget {
  const DeskSettingsButtonHover({super.key});

  @override
  State<DeskSettingsButtonHover> createState() =>
      _DeskSettingsButtonHoverState();
}

class _DeskSettingsButtonHoverState extends State<DeskSettingsButtonHover> {
//
// start hover is false
  bool isHover = false;
  bool isHover2 = false;

//start active is false
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            //
            //activates the settings popup
            if (!isActive) {
              final startSlide = context.read<GlobalProvider>();
              startSlide.settingsActivateSlide();
              //
              //gives the active color to be true
              isActive = true;
            }
          });
        },
        child: TactileButton(
          child: AnimatedContainer(
            padding: isActive
                ? const EdgeInsets.only(left: 10)
                : isHover
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: isActive
                      ? Colors.black87
                      : isHover
                          ? Colors.black87
                          : tran),
              boxShadow: [
                BoxShadow(
                  color: isActive
                      ? Colors.white
                      : (isHover ? Colors.grey.shade700 : tran),
                ),
              ],
              color: tran,
              borderRadius: const BorderRadius.all(Radius.circular(60)),
            ),
            duration: const Duration(milliseconds: 200),
            width: 13.w,
            height: 5.h,
            alignment: Alignment.centerLeft,
            child: addElement(),
          ),
        ),
      ),
    );
  }

  addElement() {
    return Padding(
      padding: EdgeInsets.only(left: 0.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.settings_outlined,
            color: isActive
                ? Colors.black87
                : (isHover
                    ? const Color.fromARGB(241, 255, 255, 255)
                    : Colors.white70),
            size: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: .5.w),
            child: Text(
              'Settings',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 2.sp),
                fontWeight: FontWeight.w400,
                color: isActive
                    ? const Color.fromARGB(221, 28, 24, 24)
                    : (isHover ? Colors.white : Colors.white54),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Stack(
              children: [
                Icon(
                  Icons.arrow_right_sharp,
                  color: isActive
                      ? Colors.white70
                      : isHover
                          ? const Color.fromARGB(241, 255, 255, 255)
                          : tran,
                  size: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      //
                      //Reverses the popup card

                      final startSlide = context.read<GlobalProvider>();
                      startSlide.settingsReverseSlide();
                      //
                      //gives the active color to be false
                      isActive = false;
                    });
                  },
                  child: MouseRegion(
                    onEnter: (e) {
                      setState(() {
                        isHover2 = true;
                      });
                    },
                    onExit: (e) {
                      setState(() {
                        isHover2 = false;
                      });
                    },
                    child: Icon(
                      Icons.cancel_rounded,
                      color: (isActive && isHover2)
                          ? red
                          : (!isHover2 && isActive)
                              ? Colors.black87
                              : tran,
                      size: 30.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
