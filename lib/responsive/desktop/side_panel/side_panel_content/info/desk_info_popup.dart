import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/desk_dock_button_templates/sp_card_template.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../../desk_decks.dart';
import 'info_side_panel.dart';
import '../desk_dock_button_templates/sp_content_template.dart';

/// Info popup with side navigation + carousel-based content switching
class InfoPopUp extends StatefulWidget {
  const InfoPopUp({super.key});

  @override
  State<InfoPopUp> createState() => _InfoPopUpState();
}

class _InfoPopUpState extends State<InfoPopUp> {
  /// Controls carousel navigation programmatically
  final CarouselSliderController controller = CarouselSliderController();

  /// Tracks current active slide/index
  int currentSlide = 0;

  /// All content pages displayed in the carousel
  final List<Widget> slides = [
    // About Us
    SpContentPanel(
      headerTitle: 'About Us',
      sections: [
        InfoSection(
            title: 'Mission', content: 'Your custom mission content here...'),
        InfoSection(title: 'Origin', content: 'Details about the origin...'),
        InfoSection(title: 'Founders', content: 'Who started it and why...'),
      ],
    ),

    // Contact Us
    SpContentPanel(
      headerTitle: 'Contact Us',
      sections: [
        InfoSection(
            title: 'Mission', content: 'Your custom mission content here...'),
        InfoSection(title: 'Origin', content: 'Details about the origin...'),
        InfoSection(title: 'Founders', content: 'Who started it and why...'),
      ],
    ),

    // Goals
    SpContentPanel(
      headerTitle: 'Goals',
      sections: [
        InfoSection(
            title: 'Mission', content: 'Your custom mission content here...'),
        InfoSection(title: 'Origin', content: 'Details about the origin...'),
        InfoSection(title: 'Founders', content: 'Who started it and why...'),
      ],
    ),

    // Terms & Conditions
    SpContentPanel(
      headerTitle: 'Terms & Conditions',
      sections: [
        InfoSection(
            title: 'Mission', content: 'Your custom mission content here...'),
        InfoSection(title: 'Origin', content: 'Details about the origin...'),
        InfoSection(title: 'Founders', content: 'Who started it and why...'),
      ],
    ),
  ];

  /// Handles side panel button taps
  /// Updates state + jumps carousel to selected page
  void handleButtonTap(int index) {
    setState(() => currentSlide = index);
    controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return SPCardTemplate(
      height: 100.h(context),
      width: 71.w(context),
      borderColor: deckBorderColor,
      child: Padding(
        padding: EdgeInsets.all(1.h(context)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// LEFT SIDE: Title + navigation panel
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: .5.h(context)),
                        child: Text(
                          'Info',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 6.sp(context),
                          ),
                        ),
                      ),

                      // Side navigation container
                      Container(
                        height: 70.h(context),
                        width: 14.w(context),
                        constraints:
                            const BoxConstraints(maxWidth: 500, minHeight: 250),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(70, 32, 32, 40),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: const Color.fromARGB(18, 255, 255, 255),
                            width: 1.5,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 2.h(context)),
                          child: Column(
                            children: [
                              InfoSidePanel(
                                currentIndex: currentSlide,
                                onTap: handleButtonTap,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// RIGHT SIDE: Content display (carousel)
                  Container(
                    height: 75.h(context),
                    width: 47.w(context),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(70, 32, 32, 40),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: const Color.fromARGB(18, 255, 255, 255),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        height: 71.h(context),
                        width: 45.w(context),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(15, 15, 17, 1),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: CarouselSlider(
                          carouselController: controller,
                          options: CarouselOptions(
                            height: 69.h(context),
                            viewportFraction: .97,
                            enlargeCenterPage: true,

                            /// Prevents swipe — navigation controlled via side panel
                            scrollPhysics: const NeverScrollableScrollPhysics(),

                            /// Syncs UI when slide changes
                            onPageChanged: (index, _) {
                              setState(() => currentSlide = index);
                            },
                          ),

                          /// Render each content panel
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
    );
  }
}
