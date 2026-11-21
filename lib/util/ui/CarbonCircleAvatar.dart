import 'dart:math';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/imports.dart';

class CarbonCircleAvatar extends StatelessWidget {
  CarbonCircleAvatar({super.key, this.width = 40});
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(max(9, 0.25.w(context))),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: deckBorderColor),
      ),
      child: Image.asset("images/creator.png"),
    );
  }
}
