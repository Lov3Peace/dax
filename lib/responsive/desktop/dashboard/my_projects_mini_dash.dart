import 'dart:math' as math;

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
        padding:
            EdgeInsets.all(max(desktopContainerPadLowerLimit, 1.5.w(context))),
        borderRadius: 1.5.w(context),
        color: deckBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Projects",
                  style: TextStyle(
                      fontSize: max(headerlowerlimit, 5.sp(context)),
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
            Divider(endIndent: math.max(500, 50.w(context))),
            Row(
              children: [
                GradientText(
                  text: "Carbon",
                  gradients: [pink, red],
                  fontSize: max(headerlowerlimit, 5.sp(context)),
                  fontWeight: FontWeight.bold,
                )
              ],
            )
          ],
        ));
  }
}
