import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/pillButton.dart';

class ViewAllEventsButton extends StatelessWidget {
  const ViewAllEventsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PillButton(
      onTap: () {},
      height: max(25, 2.w(context)),
      width: max(75, 7.w(context)),
      borderRadius: 50.w(context),
      borderColor: deckBorderColor,
      child: Text(
        "View All",
        style: TextStyle(fontSize: max(12, 2.sp(context))),
      ),
    );
  }
}
