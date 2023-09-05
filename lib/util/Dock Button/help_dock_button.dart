import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/util/Window%20Route/help_window_route.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class HelpWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const HelpWindowButton({super.key, required});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HelpWindowRoute(builder: (context) {
            return const _HelpWindowPopupCard();
          }));
        },
        child: const Hero(
          tag: _heroHelpWindow,
          /*createRectTween: (begin, end) {
            return Tween(begin: begin, end: end);
          },*/
          child: Material(
            color: tran,
            child: Icon(
              Ionicons.help_circle_sharp,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroHelpWindow = 'Help-window-hero';

class _HelpWindowPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const _HelpWindowPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h, top: 4.h),
            child: Center(
              child: Container(
                height: 85.h,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(32)),
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Hero(
                  tag: _heroHelpWindow,
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: Material(
                    shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
                    color:
                        const Color.fromARGB(42, 55, 52, 52).withOpacity(0.7),
                    elevation: 2,
                    borderRadius: BorderRadius.circular(32),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                              height: 85.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(182, 31, 31, 31)),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
