import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../../util/tactile_button.dart';
import '../desk_decks.dart';

class CommunitiesDeck extends StatefulWidget {
  const CommunitiesDeck({
    super.key,
  });

  @override
  State<CommunitiesDeck> createState() => _CommunitiesDeckState();
}

class _CommunitiesDeckState extends State<CommunitiesDeck> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deckHeight = 22.h(context);
    double halfDeckWidth = 17.325.w(context);
    double headingTextSize = 6.25.sp(context);
    subTextSize = 2.5.sp(context);
    double labelTextSize = 2.5.sp(context);
    textConstraint = 500;
    subTextConstraint = 500;
    if (100.w(context) < 1440) {
      headingTextSize = headingTextSize * 0.9;
    }
    return TactileButton(
        onTap: () {
          router.go("/communities");
        },
        // values set in desk_decks.dart
        child: Deck(
          deckHeight: deckHeight,
          deckWidth: halfDeckWidth,
          deckName: 'Communities',
          gradient1: red,
          gradient2: orange,
          neonGlow: orangeGlow,
          labelTextSize: labelTextSize,
          headingTextSize: headingTextSize,
          headingText: 'Find your community.',
          subText: "Connect with others and say what's on your mind.",
        ));
  }
}
