import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/util/Window%20Route/messages_window_route.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class MessagesWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const MessagesWindowButton({super.key, required});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MessagesWindowRoute(builder: (context) {
            return _MessagesWindowPopupCard();
          }));
        },
        child: const Hero(
          tag: _heroMessagesWindow,
          child: Material(
            color: tran,
            child: Icon(
              Ionicons.chatbox,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroMessagesWindow = 'Message-window-hero';
final messageBucket = PageStorageBucket();

class _MessagesWindowPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  _MessagesWindowPopupCard({Key? key}) : super(key: key);

  @override
  State<_MessagesWindowPopupCard> createState() =>
      _MessagesWindowPopupCardState();
}

class _MessagesWindowPopupCardState extends State<_MessagesWindowPopupCard> {
  //List for People stories
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
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(32)),
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Hero(
                  tag: _heroMessagesWindow,
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: Material(
                    shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
                    color:
                        const Color.fromARGB(42, 55, 52, 52).withOpacity(0.7),
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
                                padding: EdgeInsets.only(right: 42.w, top: 1.h),
                                child: const Text(
                                  "Messages",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.5.h,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const ScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                    itemCount: people.length,
                                    itemBuilder: (context, index) {
                                      return BubbleStories(text: people[index]);
                                    }),
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

                                    //crossAxisAlignment: CrossAxisAlignment.center,
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
                                                    blurRadius: 3,
                                                    blurStyle: BlurStyle.solid)
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: const Text("All",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      //Group Button
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
                                              horizontal: 6.w, vertical: 1.h),
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
                                          child: const Text("Group",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      //Chat Button
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
                                              horizontal: 6.w, vertical: 1.h),
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
                                          child: const Text("Chat",
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
                                  height: 50.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(162, 27, 27, 27)
                                        .withOpacity(0.85),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  //Carousel Slider
                                  child: PageStorage(
                                    bucket: messageBucket,
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
}

// Chat Messages
class ChatMessages extends StatelessWidget {
  ChatMessages({
    super.key,
  });
  final List chats = [
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
        itemCount: chats.length,
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

//Group Messages
class GroupMessages extends StatelessWidget {
  GroupMessages({
    super.key,
  });
  final List groups = [
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
        itemCount: groups.length,
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

// All Messages
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
        color: const Color.fromRGBO(42, 41, 41, 0.631).withOpacity(0.98),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: allmessages.length,
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

class BubbleStories extends StatelessWidget {
  const BubbleStories({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [purp, red]),
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              Container(
                width: 53,
                height: 53,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Text(
            text,
          ),
        ],
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
