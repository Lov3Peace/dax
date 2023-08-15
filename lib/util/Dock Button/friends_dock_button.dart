import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';

import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../responsive/mobile/mob_constants.dart';
import '../Window Route/friends_window_route.dart';

class FriendsWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const FriendsWindowButton({super.key, required});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(FriendsWindowRoute(builder: (context) {
            return _FriendsWindowPopupCard();
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

class _FriendsWindowPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  _FriendsWindowPopupCard({Key? key}) : super(key: key);

  @override
  State<_FriendsWindowPopupCard> createState() =>
      _FriendsWindowPopupCardState();
}

class _FriendsWindowPopupCardState extends State<_FriendsWindowPopupCard> {
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
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Hero(
                  tag: _heroFriendsWindow,
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: Material(
                    color: const Color.fromRGBO(27, 27, 27, 0.937),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            //Stories
                            Padding(
                              padding: EdgeInsets.only(right: 30.w),
                              child: const Text(
                                "Connections",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 1.h,
                              ),
                              child: TextFormField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                    borderSide: BorderSide(color: Colors.white),
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
                            Container(
                              clipBehavior: Clip.hardEdge,
                              height: 6.5.h,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(42, 41, 41, 0.631)
                                    .withOpacity(0.98),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                                blurRadius: 20,
                                                blurStyle: BlurStyle.solid)
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: const Text("All",
                                          style:
                                              TextStyle(color: Colors.white)),
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
                                                blurRadius: 20,
                                                blurStyle: BlurStyle.solid)
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: const Text("Favorites",
                                          style:
                                              TextStyle(color: Colors.white)),
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
                                                blurRadius: 20,
                                                blurStyle: BlurStyle.solid)
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: const Text("Partners",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 1.h),
                            //Container Housing Carousel slider
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 53.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(27, 27, 27, 0.937)
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
                          ],
                        ),
                      ),
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

class ChatMessages extends StatelessWidget {
  ChatMessages({
    super.key,
  });
  final List chatmessages = [
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
        color: const Color.fromARGB(159, 220, 6, 195).withOpacity(0.98),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: chatmessages.length,
        itemBuilder: (context, index) {
          return MyContainer();
        },
      ),
    );
  }
}

class GroupMessages extends StatelessWidget {
  GroupMessages({
    super.key,
  });
  final List groupmessages = [
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
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: groupmessages.length,
        itemBuilder: (context, index) {
          return MyContainer();
        },
      ),
    );
  }
}

class AllMessages extends StatelessWidget {
  AllMessages({
    super.key,
  });
  final List allmessages = [
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
        color: Color.fromARGB(159, 56, 56, 56).withOpacity(0.98),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: allmessages.length,
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
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
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
