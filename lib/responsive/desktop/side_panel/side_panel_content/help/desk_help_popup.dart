import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/desk_dock_button_templates/sp_card_template.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/help/help_side_panel.dart';
import 'package:flutter_application_1/util/button_state.dart';
import 'package:provider/provider.dart';
import '../../../desk_decks.dart';
import '../desk_dock_button_templates/sp_content_template.dart';

// Popup widget for the FAQs section accessed from the dashboard side panel
class HelpPopUp extends StatefulWidget {
  const HelpPopUp({super.key});

  @override
  State<HelpPopUp> createState() => HelpPopUpState();
}

class HelpPopUpState extends State<HelpPopUp> {
  // Controller used to programmatically control the carousel slider
  final CarouselSliderController controller = CarouselSliderController();

  // Tracks the currently selected slide index
  int currentSlide = 0;

  // List of all FAQ category panels (each slide represents a category)
  final List<Widget> slides = [
    /*
      FAQ Category: Questions
    */
    SpContentPanel(
      headerTitle: 'Questions',
      sections: [
        InfoSection(
          title: 'Q: How can I go hawda?',
          content: 'Tools utilized to go hawda...',
        ),
        InfoSection(
          title: 'Q:Is going hawda mandatory?',
          content: 'Explain why going hawda is necessary...',
        ),
        InfoSection(
          title: 'Q: Will Lex ever go hawda?',
          content: 'The world may never know...',
        ),
      ],
    ),

    /*
      FAQ Category: Projects
    */
    SpContentPanel(
      headerTitle: 'Projects',
      sections: [
        InfoSection(
          title: 'Q: How can I go hawda?',
          content: 'Tools utilized to go hawda...',
        ),
        InfoSection(
          title: 'Q:Is going hawda mandatory?',
          content: 'Explain why going hawda is necessary...',
        ),
        InfoSection(
          title: 'Q: Will Lex ever go hawda?',
          content: 'The world may never know...',
        ),
      ],
    ),

    /*
      FAQ Category: Communities
    */
    SpContentPanel(
      headerTitle: 'Communities',
      sections: [
        InfoSection(
          title: 'Q: How can I go hawda?',
          content: 'Tools utilized to go hawda...',
        ),
        InfoSection(
          title: 'Q:Is going hawda mandatory?',
          content: 'Explain why going hawda is necessary...',
        ),
        InfoSection(
          title: 'Q: Will Lex ever go hawda?',
          content: 'The world may never know...',
        ),
      ],
    ),

    /*
      FAQ Category: Socials
    */
    SpContentPanel(
      headerTitle: 'Socials',
      sections: [
        InfoSection(
          title: 'Q: How can I go hawda?',
          content: 'Tools utilized to go hawda...',
        ),
        InfoSection(
          title: 'Q:Is going hawda mandatory?',
          content: 'Explain why going hawda is necessary...',
        ),
        InfoSection(
          title: 'Q: Will Lex ever go hawda?',
          content: 'The world may never know...',
        ),
      ],
    ),

    /*
      FAQ Category: News
    */
    SpContentPanel(
      headerTitle: 'News',
      sections: [
        InfoSection(
          title: 'Q: How can I go hawda?',
          content: 'Tools utilized to go hawda...',
        ),
        InfoSection(
          title: 'Q:Is going hawda mandatory?',
          content: 'Explain why going hawda is necessary...',
        ),
        InfoSection(
          title: 'Q: Will Lex ever go hawda?',
          content: 'The world may never know...',
        ),
      ],
    ),

    /*
      FAQ Category: Wallet
    */
    SpContentPanel(
      headerTitle: 'Wallet',
      sections: [
        InfoSection(
          title: 'Q: How can I go hawda?',
          content: 'Tools utilized to go hawda...',
        ),
        InfoSection(
          title: 'Q:Is going hawda mandatory?',
          content: 'Explain why going hawda is necessary...',
        ),
        InfoSection(
          title: 'Q: Will Lex ever go hawda?',
          content: 'The world may never know...',
        ),
      ],
    ),

    /*
      FAQ Category: Tips & Tricks
    */
    SpContentPanel(
      headerTitle: 'Tips & Tricks',
      sections: [
        InfoSection(
          title: 'Q: How can I go hawda?',
          content: 'Tools utilized to go hawda...',
        ),
        InfoSection(
          title: 'Q:Is going hawda mandatory?',
          content: 'Explain why going hawda is necessary...',
        ),
        InfoSection(
          title: 'Q: Will Lex ever go hawda?',
          content: 'The world may never know...',
        ),
      ],
    ),
  ];

  // Handles side panel button taps:
  // - Updates the current index
  // - Syncs the carousel to the selected page
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
        return SPCardTemplate(
          height: 100.h(context),
          width: 71.w(context),
          borderColor: deckBorderColor,

          // Outer padding for the popup content
          child: Padding(
            padding: EdgeInsets.all(1.h(context)),

            // Allows vertical scrolling if content overflows
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /*
                        LEFT SIDE:
                        - Title ("FAQs")
                        - Navigation panel (categories)
                      */
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

                          // Side panel container for category navigation
                          Container(
                            height: 70.h(context),
                            width: 14.w(context),
                            constraints: const BoxConstraints(
                                maxWidth: 500, minHeight: 250),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(70, 32, 32, 40),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border: Border.all(
                                color: const Color.fromARGB(18, 255, 255, 255),
                                width: 1.5,
                              ),
                            ),

                            // Category buttons (FAQsSidePanel)
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

                      /*
                        RIGHT SIDE:
                        - Displays content for selected FAQ category
                        - Controlled via CarouselSlider
                      */
                      Container(
                        height: 74.h(context),
                        width: 47.w(context),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(70, 32, 32, 40),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),

                            // Carousel for switching between FAQ categories
                            child: CarouselSlider(
                              carouselController: controller,
                              options: CarouselOptions(
                                height: 69.h(context),
                                viewportFraction: .97,
                                enlargeCenterPage: true,

                                // Disable swipe; navigation controlled via side panel
                                scrollPhysics:
                                    const NeverScrollableScrollPhysics(),

                                // Syncs carousel changes back to side panel state
                                onPageChanged: (index, _) {
                                  setState(() => currentSlide = index);
                                },
                              ),

                              // Each slide corresponds to a FAQ category
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
      },
    );
  }
}
