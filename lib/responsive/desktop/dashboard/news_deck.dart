import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../main.dart';
import '../../../util/tactile_button.dart';
import '../../mobile/mobile_news_page.dart';
import '../../tablet/tablet_news_page.dart';
import '../desk_decks.dart';
import '../desk_constants.dart';
import '../decks_content/desk_news_page.dart';
import './desk_dashboard.dart';

class NewsDeck extends StatefulWidget {
  const NewsDeck({
    super.key,
  });

  @override
  State<NewsDeck> createState() => _NewsDeckState();
}

class _NewsDeckState extends State<NewsDeck> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      onTap: () {
        router.push("/news");
      },
      child: newsDeck(),
    );
  }

  Widget newsDeck({VoidCallback? onTap, Color? color}) {
    // values set in desk_decks.dart
    double deckHeight = 22.sp(context);
    double deckWidth = 35.25.w(context);
    double halfDeckWidth = 17.325.w(context);
    double headerTextSize = 6.5.sp(context);
    subTextSize = 2.5.sp(context);
    profBubTextSize = 20;
    double labelTextSize = 2.5.sp(context);
    textConstraint = 500;
    subTextConstraint = 500;
    return Deck(
      deckHeight: deckHeight,
      deckWidth: deckWidth,
      deckName: 'News',
      gradient1: blue,
      gradient2: purp,
      neonGlow: blue,
      labelTextSize: labelTextSize,
      textConstraint: 30.w(context),
      subTextConstraint: 25.w(context),
      headingText: 'Stay up to date.',
      subText:
          'Add your preferred news source to get news updates to your feed.',
    );
  }
}
