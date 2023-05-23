import 'package:flutter/material.dart';

import 'profile_page.dart';

class LearnFlutterPage extends StatefulWidget {
  const LearnFlutterPage({super.key});

  @override
  State<LearnFlutterPage> createState() => _LearnFlutterPageState();
}

bool isSwitch = false;
bool? isCheckbox = false;

class _LearnFlutterPageState extends State<LearnFlutterPage> {
  @override
  Widget build(BuildContext context) {
    Color shadowColor = Colors.purple.shade300;
    Color buttonColor = const Color.fromARGB(255, 29, 29, 29);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (buildContext) {
                return const ProfilePage();
              }));

              debugPrint('Actions');
            },
            icon: const Icon(Icons.account_circle),
          ),
          IconButton(
            onPressed: () {
              debugPrint('Actions');
            },
            icon: const Icon(Icons.settings),
          )
        ],
        backgroundColor: const Color.fromARGB(131, 43, 43, 43),
        shadowColor: Colors.transparent,
        title: const Text('Learn Flutter'),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
        child: Column(
          children: [
            Image.asset('images/jacket.jpg'),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.white,
              thickness: 5,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Center(
                child: Text(
                  'Centered Container with SizedBox Above and Neon Text',
                  style: TextStyle(color: Colors.white, shadows: [
                    Shadow(
                      color: shadowColor,
                      blurRadius: 5,
                    ),
                    Shadow(
                      color: shadowColor,
                      blurRadius: 10,
                    ),
                    Shadow(
                      color: shadowColor,
                      blurRadius: 15,
                    ),
                    Shadow(
                      color: shadowColor,
                      blurRadius: 20,
                    ),
                  ]),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: isSwitch
                      ? const Color.fromARGB(255, 255, 59, 59)
                      : Colors.blueGrey),
              onPressed: () {
                debugPrint('Elevated Button');
              },
              child: Text(
                'Elevated Button',
                style: TextStyle(color: Colors.white, shadows: [
                  Shadow(
                    color: shadowColor,
                    blurRadius: 5,
                  ),
                  Shadow(
                    color: shadowColor,
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: shadowColor,
                    blurRadius: 15,
                  ),
                  Shadow(
                    color: shadowColor,
                    blurRadius: 20,
                  ),
                ]),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                debugPrint('Outlined Button');
              },
              child: const Text('Outlined Button'),
            ),
            TextButton(
              onPressed: () {
                debugPrint('Text Button');
              },
              child: const Text('Text Button'),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                debugPrint('This is the row');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.local_fire_department,
                      color: Color.fromARGB(255, 255, 58, 32)),
                  Text('Row Widget with Fire Icons in Red'),
                  Icon(
                    Icons.local_fire_department,
                    color: Color.fromARGB(255, 255, 58, 32),
                  ),
                ],
              ),
            ),
            Switch(
                value: isSwitch,
                onChanged: (bool newBool) {
                  setState(() {
                    isSwitch = newBool;
                  });
                }),
            Checkbox(
                value: isCheckbox,
                onChanged: (bool? newBool) {
                  setState(() {
                    isCheckbox = newBool;
                  });
                }),
            Image.network(
              'https://firebase.google.com/static/images/products/auth/auth-2.png',
              width: 300,
            )
          ],
        ),
      ),
    );
  }
}
