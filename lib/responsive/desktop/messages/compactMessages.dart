import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indexed/indexed.dart';
import 'package:ionicons/ionicons.dart';

class CompactMessages extends StatefulWidget {
  const CompactMessages({super.key});

  @override
  State<CompactMessages> createState() => _CompactMessagesState();
}

class _CompactMessagesState extends State<CompactMessages> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "messages",
      flightShuttleBuilder: textFlightShuttleBuilder,
      child: Container(
        constraints: 100.w(context) > 2560
            ? BoxConstraints(minHeight: 900, minWidth: 50)
            : BoxConstraints(minHeight: 450, minWidth: 50),
        // margin: EdgeInsets.all(1.w(context)),
        decoration: BoxDecoration(
          color: deckColor,
          // borderRadius: BorderRadius.circular(1.w(context)),
          border: Border.all(color: const Color.fromARGB(147, 58, 58, 58)),
          boxShadow: const [
            // BoxShadow(
            //   blurRadius: 5,
            //   color: Color.fromARGB(255, 14, 14, 14),
            //   offset: Offset(5, 5),
            // ),
            //   BoxShadow(
            //     blurRadius: 10,
            //     color: Color.fromARGB(255, 37, 37, 37),
            //     offset: Offset(-5, -5),
            //   )
          ],
        ),

        // height: 90.h(context),
        width: 6.5.w(context),
        // margin: EdgeInsets.only(right: 0.5.w(context)),

        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  1.w(context), 7.5.w(context), 1.w(context), 1.w(context)),
              child: Icon(
                Ionicons.chatbubble_ellipses_outline,
                size: 2.w(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
