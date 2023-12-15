import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';

import '../../../util/Window Route/friends_window_route.dart';
import 'GlobalProvider.dart';

//const String _heroFriendsWindow = 'Friends-window-hero';
final friendsBucket = PageStorageBucket();

class DeskFriendsWindowPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  DeskFriendsWindowPopupCard({Key? key}) : super(key: key);

  @override
  State<DeskFriendsWindowPopupCard> createState() =>
      _DeskFriendsWindowPopupCardState();
}

class _DeskFriendsWindowPopupCardState
    extends State<DeskFriendsWindowPopupCard> {
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
          final startSlide = context.read<GlobalProvider>();
          startSlide.friendActivateSlide();
        },
        label: Padding(
          padding: EdgeInsets.only(left: 0.5.w),
          child: Text(
            'Connections',
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 2.sp),
                fontWeight: FontWeight.w400,
                color: Colors.white54),
          ),
        ),
      ),
    );
  }
}

class FriendsPopUp extends StatefulWidget {
  FriendsPopUp({super.key});

  State<FriendsPopUp> createState() => _FriendsPopUpState();
}

// final friendsIDController = TextEditingController();
// final reasonController = TextEditingController();

class _FriendsPopUpState extends State<FriendsPopUp> with AnimationMixin {
  //control = Control.play;
  TextEditingController _searchController = TextEditingController();
  @override
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
    return Consumer<GlobalProvider>(
        builder: (context, value, child) => CustomAnimationBuilder<double>(
              control: value.friendSlideControl,
              startPosition: 0,
              tween: Tween(begin: 0, end: 83.5.w),
              duration: const Duration(milliseconds: 1250),
              curve: Curves.easeInOutBack,
              onCompleted: () {
                final resetSlide = context.read<GlobalProvider>();
                resetSlide.friendResetSlide();
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

// Partner Connections
class ChatMessages extends StatelessWidget {
  ChatMessages({
    super.key,
  });
  final List partners = [
    "Tiffany",
    "Mitch",
    "Cassandra",
    "Bluecheese",
    "Johnny",
    "susy",
    "himothy",
    "mario",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(42, 41, 41, 0.631).withOpacity(0.98),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: partners.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
            thickness: 2,
          );
        },
        itemBuilder: (context, index) {
          return MyContainer();
        },
      ),
    );
  }
}

// Favorite Connections
class GroupMessages extends StatelessWidget {
  GroupMessages({
    super.key,
  });
  final List favorites = [
    "Tiffany",
    "Mitch",
    "Cassandra",
    "Bluecheese",
    "Johnny",
    "susy",
    "himothy",
    "mario",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(42, 41, 41, 0.631).withOpacity(0.98),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: favorites.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
            thickness: 2,
          );
        },
        itemBuilder: (context, index) {
          return MyContainer();
        },
      ),
    );
  }
}

//All Connections
class AllMessages extends StatelessWidget {
  AllMessages({
    super.key,
  });
  final List allconnections = [
    "Tiffany",
    "Mitch",
    "Cassandra",
    "Bluecheese",
    "Johnny",
    "susy",
    "himothy",
    "mario",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(42, 41, 41, 0.631).withOpacity(0.98),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: allconnections.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
            thickness: 2,
          );
        },
        itemBuilder: (context, index) {
          return MyContainer();
        },
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  MyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: .5.h,
        vertical: .3.h,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 8.h,
          width: 100.h,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(42, 41, 41, 0.631).withOpacity(0.1),
            // border: Border.all(
            //   color: Colors.white,
            //   width: 1,
            // ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h),
            child: Stack(
              children: [
                Container(
                  width: 13.w,
                  height: 13.h,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [purp, red]),
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: 12.5.w,
                  height: 12.5.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.h, left: 4.5.h),
                  child: Container(
                    width: 4.5.w,
                    height: 4.5.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 118, 123, 118),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    "Tiffany",
    "Mitch",
    "Cassandra",
    "Bluecheese",
    "Johnny",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var friends in searchTerms) {
      if (friends.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(friends);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var friends in searchTerms) {
      if (friends.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(friends);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

//
// Hover aspect of setting button
class DeskFriendsButtonHover extends StatefulWidget {
  const DeskFriendsButtonHover({super.key});

  @override
  State<DeskFriendsButtonHover> createState() => _DeskFriendsButtonHoverState();
}

class _DeskFriendsButtonHoverState extends State<DeskFriendsButtonHover> {
//
// start hover is false
  bool isHover = false;
//
//start active is false
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            //
            //activates the settings popup
            final startSlide = context.read<GlobalProvider>();
            startSlide.friendActivateSlide();
            //
            //gives the active color to be true
            isActive = true;
          });
        },
        child: TactileButton(
          child: AnimatedContainer(
            padding: isActive
                ? EdgeInsets.only(left: 10)
                : isHover
                    ? EdgeInsets.only(left: 10)
                    : EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: isActive
                      ? Colors.black87
                      : isHover
                          ? Colors.black87
                          : tran),
              boxShadow: [
                BoxShadow(
                  color: isActive
                      ? Colors.white
                      : (isHover ? Colors.grey.shade700 : tran),
                ),
              ],
              color: tran,
              borderRadius: const BorderRadius.all(Radius.circular(60)),
            ),
            duration: const Duration(milliseconds: 200),
            width: 13.w,
            height: 5.h,
            alignment: Alignment.centerLeft,
            child: addElement(),
          ),
        ),
      ),
    );
  }

  addElement() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.people_outlined,
          color: isActive
              ? Colors.black87
              : (isHover ? Colors.black87 : Colors.white54),
          size: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: .5.w),
          child: Text(
            'Connections',
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(fontSize: 2.sp),
              fontWeight: FontWeight.w400,
              color: isActive
                  ? const Color.fromARGB(221, 28, 24, 24)
                  : (isHover ? Colors.black87 : Colors.white54),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 2.5.w),
          child: Stack(
            children: [
              Icon(
                Icons.arrow_right_rounded,
                color: isActive
                    ? Colors.white
                    : isHover
                        ? Colors.black87
                        : tran,
                size: 35.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    //
                    //Reverses the popup card
                    final startSlide = context.read<GlobalProvider>();
                    startSlide.friendReverseSlide();
                    //
                    //gives the active color to be flase
                    isActive = false;
                  });
                },
                child: Icon(
                  Icons.arrow_left_rounded,
                  color: isActive ? Colors.black87 : tran,
                  size: 35.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
