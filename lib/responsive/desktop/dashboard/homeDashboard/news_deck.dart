import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/routes/go_routes.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';

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
    double deckHeight = 22.h(context);
    double deckWidth = 35.25.w(context);
    double headingTextSize = 6.5.sp(context);
    double labelTextSize = 2.5.sp(context);
    if (100.w(context) < 1440) {
      // headingTextSize = headingTextSize * 0.8;
    }
    return TactileButton(
      onTap: () {
        router.go("/news");
      },
      child: Deck(
        deckHeight: deckHeight,
        deckWidth: deckWidth,
        deckName: 'News',
        gradient1: blue,
        gradient2: purp,
        neonGlow: blue,
        labelTextSize: labelTextSize,
        headingTextSize: headingTextSize,
        headingText: 'Stay up to date.',
        subText:
            'Add your preferred news source to get news updates to your feed.',
      ),
    );
  }
}
