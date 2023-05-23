import 'package:flutter/material.dart';
import '../util/decks.dart';
import 'main.dart';

class TestPage2 extends StatefulWidget {
  const TestPage2({super.key});

  @override
  State<TestPage2> createState() => _TestPage2State();
}

class _TestPage2State extends State<TestPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page2'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
        children: [
          Hero(
            tag: 'projects',
            flightShuttleBuilder: flightShuttleBuilder,
            child: Deck(
              deckHeight: MediaQuery.of(context).size.height * 0.45,
              deckWidth: MediaQuery.of(context).size.width * 0.85,
              deckName: 'Keyboards',
              gradient1: red,
              gradient2: purp,
              neonGlow: red,
            ),
          ),
          Hero(
            tag: 'socials',
            flightShuttleBuilder: flightShuttleBuilder,
            child: Deck(
              deckHeight: MediaQuery.of(context).size.height * 0.45,
              deckWidth: MediaQuery.of(context).size.width * 0.85,
              deckName: 'IG',
              gradient1: red,
              gradient2: purp,
              neonGlow: red,
            ),
          ),
        ],
      ),
    );
  }
}
