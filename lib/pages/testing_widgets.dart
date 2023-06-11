import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/util/deck_height_value.dart';
import 'package:flutter_application_1/util/decks.dart';
import 'package:flutter_application_1/util/projects_stacks_list.dart';
import 'package:flutter_application_1/util/socials_stacks_list.dart';
import '../util/dashboard_decks.dart';

//List x = DashboardDecks().dashboardDecks;
List currentList = [];
List deckNamesList = ['Projects', 'Socials', 'Finances', 'News'];
List projectStackNamesList = [
  'Keyboards',
  'Guitars',
  'Photography',
  'Audio',
  'knives',
];
int currentView = 0;
double localDeckHeight = 200;

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Testing'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: deckNamesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        print('index: $index, currentView: $currentView');
                        if (currentView == 0 && index == 0) {
                          setState(() {
                            deckNamesList = projectStackNamesList;
                            currentView = 1;
                            localDeckHeight = 250;
                          });
                        }
                        if (currentView == 0 && index == 1) {
                          setState(() {
                            //x = SocialsStacks().socialsStacks;
                            currentView = 2;
                          });
                        }
                        if (currentView == 0 && index == 2) {
                          setState(() {
                            // x = DashboardDecks().dashboardDecks;
                            currentView = 0;
                          });
                        }
                      },
                      child: Deck(
                        deckHeight: localDeckHeight,
                        deckWidth: MediaQuery.of(context).size.width * 0.9,
                        deckName: deckNamesList[index],
                        gradient1: red,
                        gradient2: purp,
                        neonGlow: red,
                      ),
                    );
                  }),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  currentView = 0;
                  deckNamesList = ['Projects', 'Socials', 'Finances', 'News'];
                  localDeckHeight = MediaQuery.of(context).size.height * 0.21;
                });
              },
              child: Icon(Icons.arrow_back),
            )
          ]),
        ),

        // body: AnimationLimiter(
        //   child: ListView.builder(
        //     physics: const BouncingScrollPhysics(),
        //     itemCount: DashboardDecks().dashboardDecks.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return AnimationConfiguration.staggeredList(
        //         delay: const Duration(milliseconds: 200),
        //         position: index,
        //         duration: const Duration(milliseconds: 500),
        //         child: SlideAnimation(
        //           verticalOffset: 100.0,
        //           child: FadeInAnimation(
        //             child: Column(
        //               children: [DashboardDecks().dashboardDecks[index]],
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ),
    );
  }
}
