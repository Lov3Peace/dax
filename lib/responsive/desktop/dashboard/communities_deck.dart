import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:rive/rive.dart' as r;
import '../../../util/tactile_button.dart';
import '../desk_decks.dart';

class CommunitiesDeck extends StatelessWidget {
  const CommunitiesDeck(
      {Key? key, this.height = 0, this.width = 0, required this.constraints})
      : super(key: key);
  final double height;
  final double width;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return TactileButton(
        onTap: () {
          router.go("/communities");
        },
        child: BlurryContainer(
          height: height,
          width: width,
          constraints: constraints,
          borderRadius: 50.w(context),
          padding: 1.w(context),
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
                      // Text(
                      //   "Communities",
                      //   // gradients: const [pink, red],
                      //   style: TextStyle(
                      //     fontSize: 5.sp(context),
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
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
