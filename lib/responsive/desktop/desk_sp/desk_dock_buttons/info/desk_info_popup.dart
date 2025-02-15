import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/info/info_side_panel_info/info_about_us.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/info/info_side_panel_info/info_contact_us.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/info/info_side_panel_info/info_goals.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/info/info_side_panel_info/info_terms_conditions.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../../../../util/button_state.dart';
import '../../../desk_constants.dart';
import 'info_side_panel.dart';

class InfoPopUp extends StatelessWidget {
  InfoPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonState = Provider.of<ButtonState>(context);
    return Container(
      height: 100.h,
      width: 71.w,
      alignment: Alignment.center,
      child: Stack(alignment: Alignment.center, children: [
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
                      padding: EdgeInsets.only(top: .7.h, bottom: .7.h),
                      child: Wrap(
                        spacing: 1.w,
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
                            width: 50.w,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(17, 17, 17, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              // The container that holds the information
                              child: CarouselSlider(
                                carouselController: buttonState.carouselController,
                                items: [
                                  AboutUsInformation(),
                                  ContactUsInformation(),
                                  GoalsInformation(),
                                  TermsConditionsInformation(),
                                ],
                                options: CarouselOptions(
                                  height: 100.h,
                                  viewportFraction: 0.9,
                                  enlargeCenterPage: true,
                                  onPageChanged: (index, reason) {
                                    buttonState.setSlide(index);
                                  },
                                ),
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
      ]),
    );
  }
}
