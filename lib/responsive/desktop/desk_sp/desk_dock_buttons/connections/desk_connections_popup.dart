import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/connections/desk_favorite_messages.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/connections/desk_partner_messages.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../desk_decks.dart';
import 'desk_all_messages.dart';
import 'desk_connection_tactile.dart';

class FriendsPopUp extends StatefulWidget {
  const FriendsPopUp({super.key});

  @override
  State<FriendsPopUp> createState() => FriendsPopUpState();
}

class FriendsPopUpState extends State<FriendsPopUp> with AnimationMixin {
  final TextEditingController searchController = TextEditingController();
  final CarouselSliderController carouselController = CarouselSliderController();
  int currentIndex = 0;

  final List<Widget> carouselItems = [
    AllMessages(),
    FavoriteMessages(),
    PartnerMessages(),
  ];

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
                          padding: EdgeInsets.only(left: 1.5.w(context), right: 1.5.w(context), bottom: 10),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
