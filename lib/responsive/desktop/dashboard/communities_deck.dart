import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:rive/rive.dart' as r;
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
          router.go("/communities");
        },
        child: BlurryContainer(
          // height: 7.w(context),
          // width: 30.w(context),
          borderRadius: 50.w(context),
          padding: 15,
          color: deckBackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  width: 5.w(context),
                  child: const r.RiveAnimation.asset(
                    'rive/twitter_rv.riv',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradientText(
                        text: "Communities",
                        gradients: const [orange, purp],
                        fontSize: 5.sp(context),
                        fontWeight: FontWeight.bold,
                      ),
                      Text(
                        'Post, join, or support independent projects anywhere in the world.',
                        style: TextStyle(
                            fontSize: 2.5.sp(context),
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )

        // riveAnim:
        );
  }
}
