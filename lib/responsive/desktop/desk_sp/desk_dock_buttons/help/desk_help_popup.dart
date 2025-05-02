import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel_info/help_communies_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel_info/help_news_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel_info/help_projects_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel_info/help_tips_tricks_button.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel_info/help_wallet_button.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel.dart';
import 'package:flutter_application_1/util/button_state.dart';
import 'package:provider/provider.dart';
import '../../../desk_decks.dart';
import 'help_side_panel_info/help_faqs_button.dart';
import 'help_side_panel_info/help_socials_button.dart';

// Popup to the FAQs button of the dashboard side panel
class HelpPopUp extends StatefulWidget {
  const HelpPopUp({super.key});

  @override
  State<HelpPopUp> createState() => HelpPopUpState();
}

class HelpPopUpState extends State<HelpPopUp> {
  final CarouselSliderController controller = CarouselSliderController();

  int currentSlide = 0;

  final List<Widget> slides = [
    const FAQsInformation(),
    const ProjectsInformation(),
    const CommunitiesInformation(),
    const SocialsInformation(),
    const NewsInformation(),
    const WalletInformation(),
    const TTsInformation(),
  ];

  void handleButtonTap(int index) {
    setState(() {
      currentSlide = index;
    });
    controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ButtonState>(
      builder: (context, value, child) {
        return Container(
          height: 100.h(context),
          width: 71.w(context),
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 77.h(context),
                width: 65.w(context),
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
                              // height: 85.h(context),
                              decoration: BoxDecoration(
                            border: Border.all(color: deckBorderColor),
                            borderRadius: BorderRadius.circular(24),
                          )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.h(context)),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // This column houses the title of the popup along with the container
                                  // that houses the class infosidepanel
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: .5.h(context)),
                                        child: Text(
                                          'FAQs',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 6.sp(context),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 70.h(context),
                                        width: 14.w(context),
                                        constraints: const BoxConstraints(maxWidth: 500, minHeight: 250),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(70, 32, 32, 40),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          border: Border.all(
                                            color: const Color.fromARGB(18, 255, 255, 255), // ← change this to any color you want
                                            width: 1.5, // ← adjust thickness
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 2.h(context)),
                                          child: Column(
                                            children: [
                                              FAQsSidePanel(
                                                currentIndex: currentSlide,
                                                onTap: handleButtonTap,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // This container houses the container that holds the information for the specified button selected
                                  // in the faqs side panel.
                                  Container(
                                    height: 75.h(context),
                                    width: 47.w(context),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(70, 32, 32, 40),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      border: Border.all(
                                        color: const Color.fromARGB(18, 255, 255, 255), // ← change this to any color you want
                                        width: 1.5, // ← adjust thickness
                                      ),
                                    ),
                                    child: Center(
                                      // The container that holds the information
                                      child: Container(
                                        height: 71.h(context),
                                        width: 45.w(context),
                                        decoration: const BoxDecoration(
                                          color: Color.fromRGBO(15, 15, 17, 1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: CarouselSlider(
                                          carouselController: controller,
                                          options: CarouselOptions(
                                            height: 69.h(context),
                                            viewportFraction: .97,
                                            enlargeCenterPage: true,
                                            scrollPhysics: const NeverScrollableScrollPhysics(),
                                            onPageChanged: (index, _) {
                                              setState(() => currentSlide = index);
                                            },
                                          ),
                                          items: slides,
                                        ),
                                      ),
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
            ],
          ),
        );
      },
    );
  }
}
