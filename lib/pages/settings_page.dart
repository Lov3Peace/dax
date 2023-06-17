import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

const int listCount = 20;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required IoniconsData icon});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * .07,
          backgroundColor: const Color.fromARGB(190, 0, 0, 0),
          title: const Text("Settings"),
          titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 24,
          )),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: listCount,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Items ${(index + 1)}'),
            selectedColor: Colors.amber,
          );
        },
      ),
    );
  }
}
