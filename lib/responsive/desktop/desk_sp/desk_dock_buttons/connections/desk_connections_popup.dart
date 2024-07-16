import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_constants.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/connections/desk_all_messages.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/connections/desk_chat_messages.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/connections/desk_group_messages.dart';
import 'package:flutter_application_1/util/ButtonState.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';

//const String _heroFriendsWindow = 'Friends-window-hero';
final friendsBucket = PageStorageBucket();

class DeskFriendsWindowPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  const DeskFriendsWindowPopupCard({Key? key}) : super(key: key);

  @override
  State<DeskFriendsWindowPopupCard> createState() => _DeskFriendsWindowPopupCardState();
}

class _DeskFriendsWindowPopupCardState extends State<DeskFriendsWindowPopupCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: tran,
      child: TextButton.icon(
        icon: const Icon(
          Ionicons.people_outline,
          size: 30,
          color: Colors.white54,
        ),
        onPressed: () {
          final startSlide = context.read<ButtonState>();
          startSlide.activateSlide(SlideType.friend);
        },
        label: Padding(
          padding: EdgeInsets.only(left: 0.5.w),
          child: Text(
            'Connections',
            style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 2.sp), fontWeight: FontWeight.w400, color: Colors.white54),
          ),
        ),
      ),
    );
  }
}

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
            tween: Tween(begin: 0, end: 83.w),
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
            child: Container(
              height: 100.h,
              width: 71.w,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
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
                              //Stories
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 1.5.w, top: 1.h),
                                  child: const Text(
                                    "Connections",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  1.5.w,
                                  10,
                                  1.5.w,
                                  10,
                                ),
                                child: TextFormField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(70, 32, 32, 40),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.w),
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
                                padding: EdgeInsets.only(left: 1.5.w, right: 1.5.w, bottom: 10),
                                child: Container(
                                  height: 6.5.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(70, 32, 32, 40),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                      border: Border.all(color: deckBorderColor)),
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
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
                                              currentColor = activeColor;
                                            }
                                          });

                                          int pageIndex = 0; // Change this to the page index
                                          _carouselController.animateToPage(pageIndex);

                                          // isSelected = false;
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(colors: [purp, red]),
                                              boxShadow: [BoxShadow(color: red, blurRadius: 10, blurStyle: BlurStyle.solid)],
                                              borderRadius: BorderRadius.all(Radius.circular(20))),
                                          child: const Text("All", style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                      //Favorites Button
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (selectedIndex != 1) {
                                              selectedIndex = 1;
                                              isSelected = true;
                                              currentColor = activeColor;
                                            }
                                          });

                                          int pageIndex = 1; // Change this to the page index
                                          _carouselController.animateToPage(pageIndex);

                                          // isSelected = false;
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 1.h),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [Colors.grey.shade900, Colors.grey.shade800]),
                                              boxShadow: [BoxShadow(color: tran, blurRadius: 3, blurStyle: BlurStyle.solid)],
                                              borderRadius: BorderRadius.all(Radius.circular(20))),
                                          child: const Text("Favorites", style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                      //Partners Button
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (selectedIndex != 1) {
                                              selectedIndex = 1;
                                              isSelected = true;
                                              currentColor = activeColor;
                                            }
                                          });

                                          int pageIndex = 2; // Change this to the page index
                                          _carouselController.animateToPage(pageIndex);

                                          // isSelected = false;
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 1.h),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [Colors.grey.shade900, Colors.grey.shade800]),
                                              boxShadow: [BoxShadow(color: tran, blurRadius: 3, blurStyle: BlurStyle.solid)],
                                              borderRadius: BorderRadius.all(Radius.circular(20))),
                                          child: const Text("Partners", style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              //Container Housing Carousel slider
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(left: 1.5.w, right: 1.5.w, bottom: 3.h),
                                  child: PageStorage(
                                    bucket: friendsBucket,
                                    child: CarouselSlider(
                                      carouselController: _carouselController,
                                      options: CarouselOptions(
                                        scrollPhysics: NeverScrollableScrollPhysics(),
                                        viewportFraction: 1,
                                        enlargeCenterPage: true,
                                        initialPage: _currentIndex,
                                        onPageChanged: (index, _) {
                                          setState(() {
                                            _currentIndex = index;
                                          });
                                        },
                                      ),
                                      items: _carouselContainers.map((container) {
                                        return Builder(
                                          builder: (BuildContext context) {
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
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
