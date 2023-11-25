import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_buttons/GlobalProvider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:indexed/indexed.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';

import '../../../util/tactile_button.dart';

class DeskHelpWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  DeskHelpWindowButton({super.key, required this.dockIcon});
  Widget dockIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Material(
        color: tran,
        child: dockIcon,
      ),
    );
  }
}

class DeskHelpWindowPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  const DeskHelpWindowPopupCard({Key? key}) : super(key: key);

  @override
  State<DeskHelpWindowPopupCard> createState() =>
      _DeskHelpWindowPopupCardState();
}

class _DeskHelpWindowPopupCardState extends State<DeskHelpWindowPopupCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: tran,
      child: TextButton.icon(
        icon: const Icon(
          Ionicons.help_circle_outline,
          size: 30,
          color: Colors.white54,
        ),
        onPressed: () {
          final startSlide = context.read<GlobalProvider>();
          startSlide.helpActivateSlide();
        },
        label: Padding(
          padding: EdgeInsets.only(left: 0.5.w),
          child: Text(
            'FAQs',
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 2.sp),
                fontWeight: FontWeight.w400,
                color: Colors.white54),
          ),
        ),
      ),
    );
  }
}

class HelpPopUp extends StatefulWidget {
  HelpPopUp({super.key});

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
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        )),
                                  ),
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
