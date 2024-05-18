import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:indexed/indexed.dart';

import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../../../../main.dart';
import '../../../../../util/GlobalProvider.dart';
import '../../../../../util/tactile_button.dart';
import 'help side panel/help_communies_button.dart';
import 'help side panel/help_faqs_button.dart';
import 'help side panel/help_news_button.dart';
import 'help side panel/help_projects_button.dart';
import 'help side panel/help_socials_button.dart';
import 'help side panel/help_tips_tricks_button.dart';
import 'help side panel/help_wallet_button.dart';

//
// Allows for the FAQs button to have hover and active characteristics
//
class DeskHelpButtonHover extends StatefulWidget {
  const DeskHelpButtonHover({super.key});

  @override
  State<DeskHelpButtonHover> createState() => _DeskHelpButtonHoverState();
}

class _DeskHelpButtonHoverState extends State<DeskHelpButtonHover> {
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
              startSlide.helpActivateSlide();
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
            Icons.help_outline,
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
              'FAQs',
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
            padding: EdgeInsets.only(left: 5.w),
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
                      startSlide.helpReverseSlide();
                      //
                      //gives the active color to be flase
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

//
// Popup to the settings button of the dashboard side panel
//
class HelpPopUp extends StatefulWidget {
  const HelpPopUp({super.key});

  @override
  State<HelpPopUp> createState() => _HelpPopUpState();
}

class _HelpPopUpState extends State<HelpPopUp> with AnimationMixin {
  //control = Control.play;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, value, child) => CustomAnimationBuilder<double>(
        control: value.helpSlideControl,
        startPosition: 0,
        tween: Tween(begin: 0, end: 83.5.w),
        duration: const Duration(milliseconds: 1250),
        curve: Curves.easeInOutBack,
        onCompleted: () {
          final resetSlide = context.read<GlobalProvider>();
          resetSlide.helpResetSlide();
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
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
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
                                                    left: 1.w, bottom: 2.h),
                                                child: const Text(
                                                  'Help',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 36),
                                                ),
                                              ),
                                              //
                                              //
                                              //Container housing Info Side Panel
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
                                                      HelpSidePanelButtons(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          //
                                          //
                                          //Container housing business info
                                          Container(
                                            height: 75.h,
                                            width: 47.w,
                                            decoration: const BoxDecoration(
                                              color:
                                                  Color.fromRGBO(17, 17, 17, 1),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 72.5.h,
                                                  width: 45.w,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        25, 25, 29, 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(20),
                                                    ),
                                                  ),
                                                  child: const Column(
                                                    //crossAxisAlignment: ,
                                                    children: [
                                                      FAQsInformation(),
                                                    ],
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
// This holds all buttons within the side panel
//
class HelpSidePanelButtons extends StatefulWidget {
  const HelpSidePanelButtons({super.key});

  @override
  State<HelpSidePanelButtons> createState() => _HelpSidePanelButtonsState();
}

class _HelpSidePanelButtonsState extends State<HelpSidePanelButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: tran,
      width: 13.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Table of Contents :',
            style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
          //
          //FAQs
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const FAQs(),
          ),

          //
          //Projects
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const Projects(),
          ),
          //
          //Communities
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const Communities(),
          ),
          //
          //Socials
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const Socials(),
          ),
          //
          //News
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const News(),
          ),
          //
          //Wallet
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const Wallet(),
          ),
          //
          //Tips & Tricks
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const TipsTricks(),
          ),
        ],
      ),
    );
  }
}
