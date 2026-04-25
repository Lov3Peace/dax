import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/util/dottedLine.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:rive/rive.dart' as r;

import '../../../util/imports.dart';

class EventsDeck extends StatelessWidget {
  const EventsDeck(
      {super.key, this.height = 0, this.width = 0, required this.constraints});
  final double height;
  final double width;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
        height: height,
        width: width,
        constraints: constraints,
        padding:
            EdgeInsets.all(max(desktopContainerPadLowerLimit, 1.5.w(context))),
        borderRadius: 1.5.w(context),
        color: deckBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Events",
              style: TextStyle(
                  fontSize: max(headerlowerlimit, 5.sp(context)),
                  fontWeight: FontWeight.bold),
            ),
            Divider(endIndent: 12.5.w(context)),
            Padding(
              padding: EdgeInsets.only(top: 0.5.w(context)),
              child: Column(
                spacing: max(10, 0.25.w(context)),
                children: [
                  TactileButton(
                      child: GradientContainer(
                    height: max(25, 2.w(context)),
                    width: max(100, 7.w(context)),
                    text: 'Add Event',
                    textSize: max(12, 2.sp(context)),
                    gradient1: tran,
                    gradient2: tran,
                    neonGlow: tran,
                    borderColor: deckBorderColor,
                    borderRadius: 50.w(context),
                  )),
                ],
              ),
            ),
          ],
        ));
  }
}
