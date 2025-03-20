import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../util/decks.dart';
import '../util/title_bubble.dart';
import '../main.dart';

class KeyboardsDeck extends StatefulWidget {
  const KeyboardsDeck({super.key});

  @override
  State<KeyboardsDeck> createState() => _KeyboardsDeckState();
}

class _KeyboardsDeckState extends State<KeyboardsDeck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: tran,
        shadowColor: tran,
        automaticallyImplyLeading: false,
        leadingWidth: 5.h(context),
        flexibleSpace: Padding(
          padding: const EdgeInsets.fromLTRB(15, 25, 200, 0),
          child: Hero(
            tag: 'keyboards',
            flightShuttleBuilder: flightShuttleBuilder,
            child: TitleBubble(
              deckHeight: 5.h(context),
              deckWidth: 4.w(context),
              deckName: 'Keyboards',
              gradient1: tran,
              gradient2: tran,
              neonGlow: const Color.fromARGB(78, 4, 4, 4),
              leftPad: 0,
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
        children: [
          GestureDetector(
            // onTap: () {
            //   Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (context) {
            //     return const KeyboardsDeck();
            //   }));
            // },
            child: Deck(
              deckHeight: 80.h(context),
              deckWidth: 85.w(context),
              deckName: 'Notare',
              gradient1: red,
              gradient2: purp,
              neonGlow: red,
            ),
          ),
          Deck(
            deckHeight: 80.h(context),
            deckWidth: 85.w(context),
            deckName: 'Lily',
            gradient1: red,
            gradient2: purp,
            neonGlow: red,
          ),
          Deck(
            deckHeight: 80.h(context),
            deckWidth: 85.w(context),
            deckName: 'Moment',
            gradient1: red,
            gradient2: purp,
            neonGlow: red,
          ),
        ],
      ),
    );
  }
}
