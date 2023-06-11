import 'package:flutter/material.dart';
import '../util/decks.dart';
import '../util/title_bubble.dart';
import 'main.dart';

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
        leadingWidth: MediaQuery.of(context).size.width * .5,
        flexibleSpace: Padding(
          padding: const EdgeInsets.fromLTRB(15, 25, 200, 0),
          child: Hero(
            tag: 'keyboards',
            flightShuttleBuilder: flightShuttleBuilder,
            child: TitleBubble(
              deckHeight: MediaQuery.of(context).size.height * 0.1,
              deckWidth: MediaQuery.of(context).size.width * 0.4,
              deckName: 'Keyboards',
              gradient1: tran,
              gradient2: tran,
              neonGlow: tran,
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
              deckHeight: MediaQuery.of(context).size.height * 0.80,
              deckWidth: MediaQuery.of(context).size.width * 0.85,
              deckName: 'Notare',
              gradient1: red,
              gradient2: purp,
              neonGlow: red,
            ),
          ),
          Deck(
            deckHeight: MediaQuery.of(context).size.height * 0.80,
            deckWidth: MediaQuery.of(context).size.width * 0.85,
            deckName: 'Lily',
            gradient1: red,
            gradient2: purp,
            neonGlow: red,
          ),
          Deck(
            deckHeight: MediaQuery.of(context).size.height * 0.80,
            deckWidth: MediaQuery.of(context).size.width * 0.85,
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
