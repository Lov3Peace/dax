import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../../util/Window Route/friends_window_route.dart';

class MobFriendsWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const MobFriendsWindowButton({super.key, required});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(FriendsWindowRoute(builder: (context) {
            return _MobFriendsWindowPopupCard();
          }));
        },
        child: const Hero(
          tag: _heroFriendsWindow,
          child: Material(
            color: tran,
            child: Icon(
              Ionicons.people,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroFriendsWindow = 'Friends-window-hero';
final friendsBucket = PageStorageBucket();

class _MobFriendsWindowPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  _MobFriendsWindowPopupCard({Key? key}) : super(key: key);

  @override
  State<_MobFriendsWindowPopupCard> createState() =>
      _MobFriendsWindowPopupCardState();
}

class _MobFriendsWindowPopupCardState
    extends State<_MobFriendsWindowPopupCard> {
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
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h, top: 4.h),
            child: Center(
              child: Container(
                height: 85.h,
                width: 91.w,
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Hero(
                  tag: _heroFriendsWindow,
                  flightShuttleBuilder: flightShuttleBuilder,
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
                                height: 85.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          182, 31, 31, 31)),
                                  borderRadius: BorderRadius.circular(24),
                                )),
                          ),
                        ),
                        SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              //Stories
                              Padding(
                                padding: EdgeInsets.only(right: 37.w, top: 1.h),
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
                                      borderSide:
                                          BorderSide(color: Colors.white),
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
                                    color:
                                        const Color.fromRGBO(42, 41, 41, 0.631)
                                            .withOpacity(0.98),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                  ),
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

                                          int pageIndex =
                                              0; // Change this to the page index
                                          _carouselController
                                              .animateToPage(pageIndex);

                                          // isSelected = false;
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7.w, vertical: 1.h),
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [purp, red]),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: red,
                                                    blurRadius: 10,
                                                    blurStyle: BlurStyle.solid)
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
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
                                              currentColor = activeColor;
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
                                              horizontal: 4.5.w, vertical: 1.h),
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Colors.black54,
                                                Colors.black54
                                              ]),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: tran,
                                                    blurRadius: 3,
                                                    blurStyle: BlurStyle.solid)
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
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
                                              currentColor = activeColor;
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
                                              horizontal: 4.5.w, vertical: 1.h),
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Colors.black54,
                                                Colors.black54
                                              ]),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: tran,
                                                    blurRadius: 3,
                                                    blurStyle: BlurStyle.solid)
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
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
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: 51.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(27, 27, 27, 0.937)
                                            .withOpacity(0.98),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  //Carousel Slider
                                  child: PageStorage(
                                    bucket: friendsBucket,
                                    child: CarouselSlider(
                                      carouselController: _carouselController,
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
                                      items:
                                          _carouselContainers.map((container) {
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
