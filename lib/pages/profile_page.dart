import 'package:flutter/material.dart';
import '../util/decks.dart';
import 'main.dart';
import 'test_page.dart';
import 'test_page2.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
        children: [
          Hero(
            tag: 'projects',
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TestPage();
                }));
              },
              child: Deck(
                deckHeight: MediaQuery.of(context).size.height * 0.21,
                deckWidth: MediaQuery.of(context).size.width * 0.85,
                deckName: 'Test',
                gradient1: red,
                gradient2: purp,
                neonGlow: red,
              ),
            ),
          ),
          Hero(
            tag: 'socials',
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const TestPage2();
                }));
              },
              child: Deck(
                deckHeight: MediaQuery.of(context).size.height * 0.21,
                deckWidth: MediaQuery.of(context).size.width * 0.85,
                deckName: 'Test2',
                gradient1: red,
                gradient2: purp,
                neonGlow: red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
