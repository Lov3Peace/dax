import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/util/Window%20Route/messages_window_route.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';

import '../../responsive/mobile/mob_constants.dart';

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
final pageBucket = PageStorageBucket();

class _MessagesWindowPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  _MessagesWindowPopupCard({Key? key}) : super(key: key);

  @override
  State<_MessagesWindowPopupCard> createState() =>
      _MessagesWindowPopupCardState();
}

class _MessagesWindowPopupCardState extends State<_MessagesWindowPopupCard> {
  List people = [
    "Tiffany",
    "Mitch",
    "Cassandra",
    "Bluecheese",
    "Johnny",
  ];

  int _currentIndex = 0;
  final List<Widget> _containers = [
    AllMessages(),
    GroupMessages(),
    ChatMessages(),
    // Add more containers as needed
  ];
  final CarouselController _carouselController = CarouselController();

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
                  tag: _heroMessagesWindow,
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
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            //Stories
                            const Text(
                              "Messages",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                            Container(
                              height: 6.5.h,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(42, 41, 41, 0.631)
                                    .withOpacity(0.98),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                              child: Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //All Button
                                    ElevatedButton(
                                      onPressed: () {
                                        int desiredIndex =
                                            3; // Change this to the desired index
                                        _carouselController
                                            .animateToPage(desiredIndex);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                                42, 41, 41, 0.631)
                                            .withOpacity(0.98),
                                        side: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                      ),
                                      child: const Text("All",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                    //Group Button
                                    ElevatedButton(
                                      onPressed: () {
                                        int desiredIndex =
                                            1; // Change this to the desired index
                                        _carouselController
                                            .animateToPage(desiredIndex);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                                42, 41, 41, 0.631)
                                            .withOpacity(0.98),
                                        side: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                      ),
                                      child: const Text(
                                        "Group",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    //Chat Button
                                    ElevatedButton(
                                      onPressed: () {
                                        int desiredIndex =
                                            2; // Change this to the desired index
                                        _carouselController
                                            .animateToPage(desiredIndex);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                                42, 41, 41, 0.631)
                                            .withOpacity(0.98),
                                        side: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                      ),
                                      child: const Text("Chat",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 1.h),
                            Container(
                              height: 53.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(27, 27, 27, 0.937)
                                    .withOpacity(0.98),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(45),
                                ),
                              ),
                              //const Color.fromRGBO(42, 41, 41, 0.631)

                              //Carousel Slider
                              child: PageStorage(
                                bucket: pageBucket,
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
                                  items: _containers.map((container) {
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
}

class ChatMessages extends StatelessWidget {
  ChatMessages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: const Color.fromARGB(159, 220, 6, 195).withOpacity(0.98),
        borderRadius: const BorderRadius.all(
          Radius.circular(45),
        ),
      ),
      child: Column(
        children: [],
      ),
    );
  }
}

class GroupMessages extends StatelessWidget {
  GroupMessages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(42, 41, 41, 0.631).withOpacity(0.98),
        borderRadius: const BorderRadius.all(
          Radius.circular(45),
        ),
      ),
      child: Column(children: []),
    );
  }
}

class AllMessages extends StatelessWidget {
  AllMessages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: const Color.fromARGB(159, 68, 230, 230).withOpacity(0.98),
        borderRadius: const BorderRadius.all(
          Radius.circular(45),
        ),
      ),
      child: Column(children: []),
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
          Container(
            width: 55,
            height: 55,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          ),
          Text(
            text,
          ),
        ],
      ),
    );
  }
}
