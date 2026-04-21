import 'package:flutter_application_1/responsive/desktop/util/dottedLine.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:rive/rive.dart' as r;

import '../../../util/imports.dart';

class MyProjectsMiniDashDeck extends StatelessWidget {
  const MyProjectsMiniDashDeck(
      {super.key, this.height = 450, this.width = 1200});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
        height: height,
        width: width,
        constraints: BoxConstraints(minWidth: 250, minHeight: 450),
        padding: 1.5.w(context),
        borderRadius: 2.w(context),
        color: deckBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Projects",
              style: TextStyle(
                  fontSize: 5.sp(context), fontWeight: FontWeight.bold),
            ),
            Divider(endIndent: 50.w(context)),
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
                TactileButton(child: Text("No Current Projects"))
              ],
            ),
          ],
        ));
  }
}
