import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/access_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/billing_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/privacy_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/profile_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/security_settings.dart';
import 'package:flutter_application_1/responsive/desktop/firebase_tools/username_change.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../desk_decks.dart';
import 'settings_side_panel.dart';
import 'settings_side_panel_info/general_settings.dart';

class SettingsPopUp extends StatefulWidget {
  const SettingsPopUp({super.key});

  @override
  State<SettingsPopUp> createState() => _SettingsPopUpState();
}

class _SettingsPopUpState extends State<SettingsPopUp> {
  final CarouselSliderController controller = CarouselSliderController();

  int currentSlide = 0;

  final List<Widget> slides = [
    GeneralSettingsInfo(),
    ProfileSettingsInfo(),
    BillingSettingsInfo(),
    AccessSettingsInfo(),
    SecuritySettingsInfo(),
    PrivacySettingsInfo(),
  ];

  void handleButtonTap(int index) {
    setState(() {
      currentSlide = index;
    });
    controller.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.loadUsername(FirebaseAuth.instance.currentUser);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 1.h(context),
                            bottom: 1.h(context),
                          ),
                          child: Wrap(
                            spacing: 1.w(context),
                            children: [
                              // This column houses both the title of the widget and also the settings side panel
                              // settings side panel is in its own file in the settings folder
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1.w(context)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 1.w(context),
                                        bottom: 2.h(context),
                                      ),
                                      child: Text(
                                        'Settings',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 6.sp(context)),
                                      ),
                                    ),

                                    //
                                    //This container houses the settings panel buttons
                                    Container(
                                      height: 68.h(context),
                                      width: 14.w(context),
                                      constraints: const BoxConstraints(maxWidth: 500, minHeight: 250),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(70, 32, 32, 40),
                                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                                        border: Border.all(
                                          color: const Color.fromARGB(18, 255, 255, 255), // ← change this to any color you want
                                          width: 1.5, // ← adjust thickness
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 2.h(context)),
                                        child: Column(
                                          children: [
                                            SettingsSidePanel(
                                              currentIndex: currentSlide,
                                              onTap: handleButtonTap,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // This container houses the profile attributes and settings containers
                              Container(
                                height: 74.5.h(context),
                                width: 47.w(context),
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
                                      height: 12.h(context),
                                      width: 47.w(context),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(70, 32, 32, 40),
                                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                                        border: Border.all(
                                          color: const Color.fromARGB(18, 255, 255, 255), // ← change this to any color you want
                                          width: 1.5, // ← adjust thickness
                                        ),
                                      ),
                                      child: Row(
                                        // alignment: WrapAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          //Container housing profile picture and basic information

                                          Image.asset(
                                            "images/creator.png",
                                            height: 10.h(context),
                                          ),
                                          Container(
                                            height: 10.h(context),
                                            width: 20.w(context),
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(0, 32, 32, 40),
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(1.h(context)),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                                  children: [
                                                    // This Text shows the profile ID
                                                    Text(
                                                      context.watch<UserProvider>().username,
                                                      style: GoogleFonts.montserrat(
                                                          textStyle: TextStyle(fontSize: 5.sp(context)), fontWeight: FontWeight.w600),
                                                    ),

                                                    Text(
                                                      'Member since 07.17.2023',
                                                      style: TextStyle(fontSize: 3.sp(context)),
                                                    ),

                                                    // This is the row containing online status
                                                    // there will be 3 statuses all together being online, away, and offline.
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 1.5.h(context),
                                                          width: 1.w(context),
                                                          decoration: const BoxDecoration(
                                                            color: Color.fromARGB(255, 9, 223, 41),
                                                            borderRadius: BorderRadius.all(
                                                              Radius.circular(20),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 0.5.w(context)),
                                                          child: Text(
                                                            'Online',
                                                            style: TextStyle(
                                                              fontSize: 3.sp(context),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Container housing badges achieved on profile so far
                                          Container(
                                            height: 10.h(context),
                                            width: 16.w(context),
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(70, 32, 32, 40),
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(top: 1.h(context), left: 1.w(context)),
                                                  child: Text(
                                                    'Badges Earned:',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 4.sp(context),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // This is the container that will be housing all general notes and information
                                    // for each given button in the settings side panel.
                                    // note: we are still designing the Ui for th ebuttons so the code for this will come much later.
                                    Container(
                                      height: 59.h(context),
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
                                        child: Container(
                                          height: 57.h(context),
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
                                              height: 55.h(context),
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
