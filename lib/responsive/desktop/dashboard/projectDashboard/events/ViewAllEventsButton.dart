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
      width: 8.w(context),
      borderRadius: 50.w(context),
      borderColor: deckBorderColor,
      text: "View All",
      textStyle: TextStyle(
          fontSize: max(12, 2.sp(context)), overflow: TextOverflow.ellipsis),
    );
  }
}
