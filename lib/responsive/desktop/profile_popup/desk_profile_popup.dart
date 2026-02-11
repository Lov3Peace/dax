import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/bottom_sections/crests_section.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/bottom_sections/projects_section.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/bottom_sections/titles_section.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/carousel_contents_temp.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/pc1.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/pc2_sections/pc2_section1.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/pc2_sections/pc2_section2.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/pc2_sections/pc2_section3.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/pc_carousel_template.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ProfileNotifier class for state management
class ProfileNotifier extends ChangeNotifier {
  // int currentIndex = 0;
}

// ProfilePopup UI
class ProfilePopup extends StatefulWidget {
  ProfilePopup({super.key});

  @override
  State<ProfilePopup> createState() => _ProfilePopupState();
}

class _ProfilePopupState extends State<ProfilePopup> {
  int currentSlide = 0;

  ptSwitch() {
    switch (currentSlide) {
      case 0:
        return PCProjects();
      case 1:
        return PCTeams();
      // case 2:
      //   return PCProjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.h(context), top: 3.h(context)),
        child: PageStorage(
          bucket: PageStorageBucket(),
          child: Container(
            height: 80.h(context),
            width: 60.w(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
            ),
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
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
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(182, 31, 31, 31),
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  // Carousel slider
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(1.h(context)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              container(),
                              Center(
                                child: AnimatedSmoothIndicator(
                                  activeIndex: currentSlide,
                                  count: 2,
                                  effect: ExpandingDotsEffect(
                                    activeDotColor: Colors.white,
                                    dotColor: Colors.white.withOpacity(0.3),
                                    dotHeight: 10,
                                    dotWidth: 10,
                                    expansionFactor: 3,
                                    spacing: 8,
                                  ),
                                ),
                              ),
                              container(),
                            ],
                          ),
                          SizedBox(
                            height: 2.h(context),
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 46.h(context),
                              viewportFraction: .97,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentSlide = index;
                                });
                              },
                            ),
                            items: [
                              PcCarouselTemplate(
                                child: PC1(),
                              ),
                              PcCarouselTemplate(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CarouselContentsTemp(
                                        child: Pc2Section1(),
                                      ),
                                      SizedBox(
                                        width: 0.75.w(context),
                                      ),
                                      CarouselContentsTemp(
                                        child: Pc2Section2(),
                                      ),
                                      SizedBox(
                                        width: 0.75.w(context),
                                      ),
                                      CarouselContentsTemp(
                                        child: Pc2Section3(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // PcCarouselTemplate(
                              //   child: SingleChildScrollView(
                              //     child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         CarouselContentsTemp(
                              //           child: Pc3Section1(),
                              //         ),
                              //         CarouselContentsTemp(
                              //           child: Pc3Section2(),
                              //         ),
                              //         // CarouselContentsTemp(
                              //         //   child: Pc3Section3(),
                              //         // ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          Divider(
                            endIndent: 2.w(context),
                            indent: 2.w(context),
                          ),
                          Row(
                            children: [
                              Expanded(child: PCTitles()),
                              Expanded(child: PCCrests()),
                              Expanded(child: ptSwitch()),
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
        ),
      ),
    );
  }

  container() {
    return Container(
      height: 4.h(context),
      width: 10.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(0, 34, 38, 42),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white70),
      ),
    );
  }
}
