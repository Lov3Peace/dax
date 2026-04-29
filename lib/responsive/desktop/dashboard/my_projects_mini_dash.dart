import 'dart:math' as math;

import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/util/dottedLine.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rive/rive.dart' as r;

import '../../../util/imports.dart';

class MyProjectsMiniDashDeck extends StatelessWidget {
  const MyProjectsMiniDashDeck({super.key, this.height = 0, this.width = 0});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      height: height,
      width: width,
      constraints: BoxConstraints(minWidth: 1000, minHeight: 450),
      padding: EdgeInsets.all(max(20, 0.5.w(context))),
      borderRadius: 1.5.w(context),
      color: deckBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          // My Project Heading, Open Button, More Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Projects",
                style: TextStyle(
                    fontSize: max(headerlowerlimit, 4.sp(context)),
                    fontWeight: FontWeight.bold),
              ),
              Row(
                spacing: max(10, 1.w(context)),
                children: [
                  TactileButton(
                      scale: 1.04,
                      child: GradientContainer(
                        height: max(25, 2.w(context)),
                        width: max(100, 7.w(context)),
                        text: 'Open',
                        textSize: max(12, 2.5.sp(context)),
                        gradient1: pink,
                        gradient2: red,
                        neonGlow: tran,
                        borderColor: tran,
                        borderRadius: 50.w(context),
                      )),
                  const TactileButton(
                    scale: 1.05,
                    child: Icon(Ionicons.ellipsis_horizontal),
                  )
                ],
              ),
            ],
          ),
          Divider(
            endIndent: math.max(550, 50.w(context)),
            color: const Color.fromRGBO(150, 150, 150, 0.50),
            height: 20,
          ),
          //
          // Project Title, Progress Bar, Spacer
          Padding(
            padding: EdgeInsets.only(bottom: max(10, 1.5.w(context))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GradientText(
                      text: "Carbon",
                      gradients: [pink, red],
                      fontSize: max(headerlowerlimit, 6.sp(context)),
                      fontWeight: FontWeight.bold,
                      lineHeight: 1,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        TactileButton(
                          scale: 1.05,
                          child: Text(
                            "17%",
                            style: TextStyle(
                                fontSize: 5.sp(context),
                                fontWeight: FontWeight.bold,
                                height: 1.5),
                          ),
                        ),
                        Container(
                          width: max(250, 20.w(context)),
                          child: FAProgressBar(
                            maxValue: 100,
                            currentValue: 17,
                            size: 17,
                            borderRadius: BorderRadius.circular(10.w(context)),
                            backgroundColor: deckBorderColor,
                            animatedDuration: const Duration(milliseconds: 300),
                            // border: BoxBorder.all(color: deckBorderColor),
                            progressGradient: const LinearGradient(
                                colors: [orangeGlow, orange, orangeGlow]),
                            direction: Axis.horizontal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          //
          // Feed, Team, Current Workload
          Expanded(
            child: Row(
              children: [
                //
                // Feed
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: max(5, 0.25.w(context))),
                    child: BlurryContainer(
                      constraints:
                          const BoxConstraints(minWidth: 250, minHeight: 150),
                      color: tran,
                      padding: EdgeInsets.all(max(20, 1.w(context))),
                      borderRadius: 1.5.w(context),
                      child: Column(
                        children: [
                          Text("Feed",
                              style: TextStyle(
                                fontSize: max(20, 3.5.sp(context)),
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                //
                // Team
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(max(5, 0.25.w(context)),
                              0, 0, max(5, 0.25.w(context))),
                          child: BlurryContainer(
                            color: tran,
                            padding: EdgeInsets.all(1.w(context)),
                            constraints: const BoxConstraints(
                                minWidth: 250, minHeight: 150),
                            borderRadius: max(20, 1.5.w(context)),
                            child: Column(
                              children: [
                                Text("Team",
                                    style: TextStyle(
                                      fontSize: max(20, 3.5.sp(context)),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      //
                      // Current Workload
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            max(5, 0.25.w(context)),
                            max(5, 0.25.w(context)),
                            0,
                            0,
                          ),
                          child: BlurryContainer(
                            color: tran,
                            padding: EdgeInsets.all(1.w(context)),
                            constraints: const BoxConstraints(
                                minWidth: 250, minHeight: 150),
                            borderRadius: max(20, 1.5.w(context)),
                            child: Column(
                              children: [
                                Text("Current Workload",
                                    style: TextStyle(
                                        fontSize: max(20, 3.5.sp(context)),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
