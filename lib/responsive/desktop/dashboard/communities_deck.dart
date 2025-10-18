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
    return TactileButton(
      onTap: () {
        router.push("/communities");
      },
      child: communityDeck(),
    );
  }

  Widget communityDeck({VoidCallback? onTap, Color? color}) {
    // values set in desk_decks.dart
    double deckHeight = 22.sp(context);
    double deckWidth = 35.25.w(context);
    double halfDeckWidth = 17.325.w(context);
    double headerTextSize = 6.5.sp(context);
    subTextSize = 2.5.sp(context);
    double labelTextSize = 2.5.sp(context);
    textConstraint = 500;
    subTextConstraint = 500;
    return Deck(
      deckHeight: deckHeight,
      deckWidth: halfDeckWidth,
      deckName: 'Communities',
      gradient1: red,
      gradient2: orange,
      neonGlow: orangeGlow,
      labelTextSize: labelTextSize,
      textConstraint: halfDeckWidth,
      subTextConstraint: halfDeckWidth * 0.7,
      headingText: 'Find your community.',
      subText: "Connect with others and say what's on your mind.",
    );
  }
}
