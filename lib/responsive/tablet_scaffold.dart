import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import '../util/dock.dart';
import '../util/profile_bubble.dart';
import '../util/title_bubble.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({super.key});

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tran,
      extendBodyBehindAppBar: true,
       appBar: AppBar(
        backgroundColor: tran,
        shadowColor: tran,
        automaticallyImplyLeading: false,
        leadingWidth: MediaQuery.of(context).size.width * .9,
        flexibleSpace: Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.035,
              25,
              MediaQuery.of(context).size.width * 0.035,
              0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'title',
                flightShuttleBuilder: flightShuttleBuilder,
                child: TitleBubble(
                  deckHeight: MediaQuery.of(context).size.height * 0.1,
                  deckWidth: MediaQuery.of(context).size.width * 0.4,
                  deckName: 'Dashboard',
                  gradient1: tran,
                  gradient2: tran,
                  neonGlow: tran,
                ),
              ),
              Hero(
                tag: 'profile',
                flightShuttleBuilder: flightShuttleBuilder,
                child: ProfileBubble(
                  deckHeight: MediaQuery.of(context).size.height * 0.1,
                  deckWidth: MediaQuery.of(context).size.width * 0.30,
                  deckName: 's3rv',
                  gradient1: tran,
                  gradient2: tran,
                  neonGlow: tran,
                ),
              ),
            ],
          ),
        ),
      ),,
      const Dock()
    );
  }
}
