import 'package:flutter_application_1/responsive/desktop/util/dottedLine.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:rive/rive.dart' as r;

import '../../../util/imports.dart';

class EventsDeck extends StatelessWidget {
  const EventsDeck({super.key});

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
        width: 18.w(context),
        constraints: const BoxConstraints(minWidth: 250),
        padding: 1.5.w(context),
        borderRadius: 2.w(context),
        color: deckBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Events",
              style: TextStyle(
                  fontSize: 5.sp(context), fontWeight: FontWeight.bold),
            ),
            Divider(endIndent: 12.5.w(context)),
            Row(
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Container(
                //     width: 3.w(context),
                //     child: const r.RiveAnimation.asset(
                //       'rive/building_apartments.riv',
                //     ),
                //   ),
                // ),
                TactileButton(child: Text("No Current Events"))
              ],
            ),
          ],
        ));
  }
}
