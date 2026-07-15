import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/routes/go_routes.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:rive/rive.dart' as rive;

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
          padding: EdgeInsets.symmetric(
              horizontal: max(desktopContainerPadLowerLimit, 1.w(context))),
          color: deckBackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //
              // Communities Rive Animation
              // Container(
              //     width: max(50, 3.w(context)),
              //     child: rive.RiveWidgetBuilder(
              //       fileLoader: rive.FileLoader.fromAsset("rive/twitter_rv.riv",
              //           riveFactory: rive.Factory.rive),
              //       builder: (context, state) => switch (state) {
              //         rive.RiveLoading() =>
              //           const Center(child: CircularProgressIndicator()),
              //         rive.RiveFailed() => ErrorWidget.withDetails(
              //             message: state.error.toString(),
              //             error: FlutterError(state.error.toString()),
              //           ),
              //         rive.RiveLoaded() => rive.RiveWidget(
              //             controller: state.controller,
              //             fit: rive.Fit.contain,
              //           )
              //       },
              //     )),
              //
              // Communities Heading and Description
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          max(desktopContainerPadLowerLimit, 0.5.w(context))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradientText(
                        text: "Communities",
                        gradients: const [orange, purp],
                        fontSize: max(24, 5.sp(context)),
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
                            fontSize: max(10, 2.5.sp(context)),
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
