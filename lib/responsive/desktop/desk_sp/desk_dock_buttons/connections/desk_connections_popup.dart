import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/connections/desk_all_messages.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/connections/desk_chat_messages.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/connections/desk_group_messages.dart';
import 'package:flutter_application_1/util/ButtonState.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';

//const String _heroFriendsWindow = 'Friends-window-hero';
final friendsBucket = PageStorageBucket();

class FriendsPopUp extends StatefulWidget {
  const FriendsPopUp({super.key});

  @override
  State<FriendsPopUp> createState() => _FriendsPopUpState();
}

class _FriendsPopUpState extends State<FriendsPopUp> with AnimationMixin {
  //control = Control.play;
  final TextEditingController _searchController = TextEditingController();
  final List people = [
    "Tiffany",
    "Mitch",
    "Cassandra",
    "Bluecheese",
    "Johnny",
  ];

  int _currentIndex = 0;

  final List<Widget> _carouselContainers = [
    AllMessages(),
    GroupMessages(),
    ChatMessages(),
    // Add more containers as needed
  ];

  final CarouselController _carouselController = CarouselController();

  bool isSelected = false;
  Color activeColor = tran;
  Color inactiveColor = tran;
  Color currentColor = tran;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ButtonState>(
        builder: (context, value, child) => CustomAnimationBuilder<double>(
              control: value.friendSlideControl,
              startPosition: 0,
              tween: Tween(begin: 0, end: 83.5.w),
              duration: const Duration(milliseconds: 1250),
              curve: Curves.easeInOutBack,
              onCompleted: () {
                final resetSlide = context.read<ButtonState>();
                resetSlide.resetSlide(SlideType.friend);
              },
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(value, 0),
                  child: child,
                );
              },
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h, top: 4.h),
                      child: Center(
                        child: Container(
                          height: 85.h,
                          width: 70.w,
                          padding: const EdgeInsets.symmetric(vertical: 32),
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
                                SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      //Stories
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 37.w, top: 1.h),
                                        child: const Text(
                                          "Connections",
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 1.h,
                                          right: 2.w,
                                          left: 2.w,
                                          bottom: 1.h,
                                        ),
                                        child: TextFormField(
                                          controller: _searchController,
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(24),
                                              ),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            hintText: 'Search...',
                                            suffixIcon: Icon(Icons.search),
                                          ),
                                          onChanged: (value) {
                                            // Implement your search logic here
                                            // You can use the 'value' variable to perform search operations
                                          },
                                        ),
                                      ),

                                      //Container housing the tab buttons
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 6.5.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                    42, 41, 41, 0.631)
                                                .withOpacity(0.98),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(40),
                                            ),
                                          ),
                                          child: Wrap(
                                            alignment:
                                                WrapAlignment.spaceEvenly,
                                            runAlignment: WrapAlignment.center,
                                            children: [
                                              //
                                              //All Button
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (selectedIndex != 1) {
                                                      selectedIndex = 1;
                                                      isSelected = true;
                                                      currentColor =
                                                          activeColor;
                                                    }
                                                  });

                                                  int pageIndex =
                                                      0; // Change this to the page index
                                                  _carouselController
                                                      .animateToPage(pageIndex);

                                                  // isSelected = false;
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7.w,
                                                      vertical: 1.h),
                                                  decoration:
                                                      const BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                purp,
                                                                red
                                                              ]),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: red,
                                                                blurRadius: 10,
                                                                blurStyle:
                                                                    BlurStyle
                                                                        .solid)
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20))),
                                                  child: const Text("All",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                              //Favorites Button
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (selectedIndex != 1) {
                                                      selectedIndex = 1;
                                                      isSelected = true;
                                                      currentColor =
                                                          activeColor;
                                                    }
                                                  });

                                                  int pageIndex =
                                                      1; // Change this to the page index
                                                  _carouselController
                                                      .animateToPage(pageIndex);

                                                  // isSelected = false;
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4.5.w,
                                                      vertical: 1.h),
                                                  decoration:
                                                      const BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                Colors.black54,
                                                                Colors.black54
                                                              ]),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: tran,
                                                                blurRadius: 3,
                                                                blurStyle:
                                                                    BlurStyle
                                                                        .solid)
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20))),
                                                  child: const Text("Favorites",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                              //Partners Button
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (selectedIndex != 1) {
                                                      selectedIndex = 1;
                                                      isSelected = true;
                                                      currentColor =
                                                          activeColor;
                                                    }
                                                  });

                                                  int pageIndex =
                                                      2; // Change this to the page index
                                                  _carouselController
                                                      .animateToPage(pageIndex);

                                                  // isSelected = false;
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4.5.w,
                                                      vertical: 1.h),
                                                  decoration:
                                                      const BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                Colors.black54,
                                                                Colors.black54
                                                              ]),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: tran,
                                                                blurRadius: 3,
                                                                blurStyle:
                                                                    BlurStyle
                                                                        .solid)
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20))),
                                                  child: const Text("Partners",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 1.h),

                                      //Container Housing Carousel slider
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          height: 51.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                    27, 27, 27, 0.937)
                                                .withOpacity(0.98),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                          ),
                                          //Carousel Slider
                                          child: PageStorage(
                                            bucket: friendsBucket,
                                            child: CarouselSlider(
                                              carouselController:
                                                  _carouselController,
                                              options: CarouselOptions(
                                                height: 53.h,
                                                viewportFraction: 1,
                                                enlargeCenterPage: true,
                                                initialPage: _currentIndex,
                                                onPageChanged: (index, _) {
                                                  setState(() {
                                                    _currentIndex = index;
                                                  });
                                                },
                                              ),
                                              items: _carouselContainers
                                                  .map((container) {
                                                return Builder(
                                                  builder:
                                                      (BuildContext context) {
                                                    return container;
                                                  },
                                                );
                                              }).toList(),
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
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  void allbtn() {}

  void groupbtn() {}

  void chatbtn() {}

  void buttonPressed() {
    // toggle between control instructions
    setState(() {
      isSelected = true;
      currentColor = (isSelected == false) ? inactiveColor : activeColor;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class Indicators extends StatelessWidget {
  const Indicators({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          const Text('Bri'),
          const Text('Tom'),
          const Text('Skylar'),
          Container(
            child: Row(
              children: [
                SizedBox(
                  height: 2.h,
                  width: 3.w,
                ),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
