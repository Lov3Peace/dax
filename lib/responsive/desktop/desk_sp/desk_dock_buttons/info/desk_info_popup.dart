import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../../../../util/ButtonState.dart';
import 'info_side_panel.dart';
import 'info_side_panel_info/info_about_us.dart';

class InfoPopUp extends StatelessWidget {
  const InfoPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ButtonState>(
      builder: (context, value, child) => CustomAnimationBuilder<double>(
        control: value.infoSlideControl,
        startPosition: 0,
        tween: Tween(begin: 0, end: 83.5.w),
        duration: const Duration(milliseconds: 1250),
        curve: Curves.easeInOutBack,
        onCompleted: () {
          context.read<ButtonState>().resetSlide(SlideType.info);
        },
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(value, 0),
            child: child,
          );
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.h, top: 4.h),
            child: Container(
              height: 85.h,
              width: 70.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Material(
                shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
                color: const Color.fromARGB(42, 55, 52, 52),
                elevation: 2,
                borderRadius: BorderRadius.circular(32),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          height: 85.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color.fromARGB(182, 31, 31, 31)),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 1.w, top: .7.h, bottom: .7.h, right: 1.w),
                          child: Wrap(
                            spacing: 1.5.w,
                            children: [
                              // This column houses the title of the popup along with the container
                              // that houses the class infosidepanel
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: .5.h),
                                    child: const Text(
                                      'Info',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 36,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 68.h,
                                    width: 15.w,
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
                                          InfoSidePanel(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // This container houses the container that holds the information for the specified button selected
                              // in the info side panel.
                              Container(
                                height: 75.h,
                                width: 48.25.w,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(17, 17, 17, 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  // The container that holds the information
                                  child: Container(
                                    height: 71.h,
                                    width: 45.w,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(25, 25, 29, 1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: const AboutUsInformation(),
                                  ),
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
      ),
    );
  }
}
