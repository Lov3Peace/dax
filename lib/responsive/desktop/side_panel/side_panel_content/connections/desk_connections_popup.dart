import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/desk_dock_button_templates/sp_card_template.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../desk_decks.dart';
import '../desk_dock_button_templates/messages_template.dart';
import 'actions_buttons.dart';
import 'desk_connection_tactile.dart';

class ConnectionsPopUp extends StatefulWidget {
  const ConnectionsPopUp({super.key});

  @override
  State<ConnectionsPopUp> createState() => ConnectionsPopUpState();
}

class ConnectionsPopUpState extends State<ConnectionsPopUp>
    with AnimationMixin {
  final TextEditingController searchController = TextEditingController();
  final CarouselSliderController carouselController =
      CarouselSliderController();
  int currentIndex = 0;

  void handleButtonTap(int index) {
    setState(() => currentIndex = index);

    carouselController.animateToPage(index);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> carouselItems = [
      /*
        this slide is controlled by the all button
      */
      CustomDataTable(
        headers: ['Username', 'Status', 'Last Seen', 'Actions'],
        rows: [
          [
            Text('[Username]', style: TextStyle(fontSize: 2.5.sp(context))),
            Text('[Online/Offline]',
                style: TextStyle(fontSize: 2.5.sp(context))),
            Text('[Time]', style: TextStyle(fontSize: 2.5.sp(context))),
            const ActionsButtons(),
          ],
          // Add more rows as needed
        ],
        fontSize: 2.5.sp(context),
        columnSpacing: 7.w(context),
        horizontalMargin: 7.w(context),
        topPadding: 1.h(context),
        decoration: BoxDecoration(
          color: const Color.fromARGB(70, 32, 32, 40),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: deckBorderColor),
        ),
      ),
      /*
        this slide is controlled by the favorites button
      */
      CustomDataTable(
        headers: ['Username', 'Status', 'Last Seen', 'Actions'],
        rows: [
          [
            Text('[Username]', style: TextStyle(fontSize: 2.5.sp(context))),
            Text('[Online/Offline]',
                style: TextStyle(fontSize: 2.5.sp(context))),
            Text('[Time]', style: TextStyle(fontSize: 2.5.sp(context))),
            const ActionsButtons(),
          ],
          // Add more rows as needed
        ],
        fontSize: 2.5.sp(context),
        columnSpacing: 7.w(context),
        horizontalMargin: 7.w(context),
        topPadding: 1.h(context),
        decoration: BoxDecoration(
          color: const Color.fromARGB(70, 32, 32, 40),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: deckBorderColor),
        ),
      ),
      /*
        this slide is controlled by the partners button
      */
      CustomDataTable(
        headers: ['Username', 'Status', 'Last Seen', 'Actions'],
        rows: [
          [
            Text('[Username]', style: TextStyle(fontSize: 2.5.sp(context))),
            Text('[Online/Offline]',
                style: TextStyle(fontSize: 2.5.sp(context))),
            Text('[Time]', style: TextStyle(fontSize: 2.5.sp(context))),
            const ActionsButtons(),
          ],
          // Add more rows as needed
        ],
        fontSize: 2.5.sp(context),
        columnSpacing: 7.w(context),
        horizontalMargin: 7.w(context),
        topPadding: 1.h(context),
        decoration: BoxDecoration(
          color: const Color.fromARGB(70, 32, 32, 40),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: deckBorderColor),
        ),
      ),
    ];
    return SPCardTemplate(
      height: 100.h(context),
      width: 71.w(context),
      borderColor: deckBorderColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h(context)),
        child: Column(
          children: [
            //Stories
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 1.5.w(context)),
                child: Text(
                  "Connections",
                  style: TextStyle(
                    fontSize: 7.sp(context),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                1.5.w(context),
                10,
                1.5.w(context),
                10,
              ),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(70, 32, 32, 40),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.w(context)),
                    ),
                    borderSide: BorderSide(color: deckBorderColor),
                  ),
                  hintText: 'Search...',
                  contentPadding: const EdgeInsets.only(left: 20),
                  suffixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {
                  // Implement your search logic here
                  // You can use the 'value' variable to perform search operations
                },
              ),
            ),

            //Container housing the tab buttons
            Padding(
              padding: EdgeInsets.only(
                  left: 1.5.w(context), right: 1.5.w(context), bottom: 10),
              child: Container(
                height: 6.h(context),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(70, 32, 32, 40),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                  border: Border.all(color: deckBorderColor),
                ),
                child: ConnectionTactile(onButtonTap: handleButtonTap),
              ),
            ),

            // Container Housing Carousel slider
            Expanded(
              child: CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: .95,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, _) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                items: carouselItems,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
