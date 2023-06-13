import 'package:flutter/material.dart';

import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/util/home_button.dart';
import 'package:ionicons/ionicons.dart';
import 'package:scale_button/scale_button.dart';

import 'dock_buttons.dart';

class BigDock extends StatefulWidget {
  BigDock(
      {super.key,
      required this.newGrad1,
      required this.newGrad2,
      required this.newGlow});
  Color newGrad1;
  Color newGrad2;
  Color newGlow;
  @override
  State<BigDock> createState() => _BigDockState();
}

class _BigDockState extends State<BigDock> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'dock',
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(134, 10, 10, 10),
                    Color.fromARGB(230, 24, 24, 24),
                  ], transform: GradientRotation(180)),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Color.fromARGB(148, 29, 29, 29)),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color.fromARGB(255, 8, 8, 8),
                      offset: Offset(0, 0),
                    ),
                    // BoxShadow(
                    //   blurRadius: 10,
                    //   color: Color.fromARGB(255, 37, 37, 37),
                    //   offset: Offset(0, 0),
                    // )
                  ]),
              width: MediaQuery.of(context).size.width * 0.50,
              height: MediaQuery.of(context).size.height * 0.12,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                clipBehavior: Clip.antiAlias,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceEvenly,
                    runAlignment: WrapAlignment.center,
                    children: [
                      DockButton(
                        icon: Ionicons.caret_back,
                        onPressed: () {
                          Future.delayed(const Duration(milliseconds: 100))
                              .then((_) {
                            Navigator.of(context).pop();
                          });
                        },
                      ),
                      HomeButton(
                          gradient1: widget.newGrad1,
                          gradient2: widget.newGrad2,
                          glow: widget.newGlow)
                    ],
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     IconButton(
                  //       icon: const Icon(Icons.settings),
                  //       color: Colors.white30,
                  //       iconSize: 50,
                  //       onPressed: () => print('hello'),
                  //     ),
                  //     IconButton(
                  //       icon: const Icon(Icons.wallet),
                  //       color: Colors.white30,
                  //       iconSize: 50,
                  //       onPressed: () => print('hello'),
                  //     ),
                  //     IconButton(
                  //       icon: const Icon(Icons.supervisor_account),
                  //       color: Colors.white30,
                  //       iconSize: 50,
                  //       onPressed: () => print('hello'),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     IconButton(
                  //       icon: const Icon(Icons.help_outline),
                  //       color: Colors.white30,
                  //       iconSize: 50,
                  //       onPressed: () => print('hello'),
                  //     ),
                  //     IconButton(
                  //       icon: const Icon(Icons.info_rounded),
                  //       color: Colors.white30,
                  //       iconSize: 50,
                  //       onPressed: () => print('hello'),
                  //     ),
                  //     IconButton(
                  //       icon: const Icon(Icons.logout_rounded),
                  //       color: Colors.white30,
                  //       iconSize: 50,
                  //       onPressed: () => print('hello'),
                  //     ),
                  //   ],
                  // ),
                ],
              ))),
    );
  }
}
