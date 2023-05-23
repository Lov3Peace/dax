import 'package:flutter/material.dart';

import 'learn_flutter_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final Color red = const Color.fromARGB(255, 255, 85, 85);
  @override
  Widget build(BuildContext context) {
    bool hover = true;
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * .07,
            backgroundColor: Colors.transparent,
            title: const Text("Home"),
            titleTextStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 24,
            )),
        body: Center(
            child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(red)),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (buildContext) {
              return const LearnFlutterPage();
            }));
          },
          child: const Text(
            'Learn Flutter',
            style: TextStyle(color: Colors.white),
          ),
          onHover: (hover) {
            const Color.fromARGB(122, 255, 0, 0);
          },
        )));
  }
}
