import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:rive/rive.dart' as rive;
import 'package:rive/rive.dart';

class RiveLoadingAnimation extends StatelessWidget {
  const RiveLoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ArtBoardScreen(),
        Center(
          child: Container(
              height: 350,
              child: rive.RiveWidgetBuilder(
                fileLoader: rive.FileLoader.fromAsset("rive/completed.riv",
                    riveFactory: rive.Factory.rive),
                builder: (context, state) => switch (state) {
                  RiveLoading() =>
                    const Center(child: CircularProgressIndicator()),
                  RiveFailed() => ErrorWidget.withDetails(
                      message: state.error.toString(),
                      error: FlutterError(state.error.toString()),
                    ),
                  RiveLoaded() => rive.RiveWidget(
                      controller: state.controller,
                      fit: rive.Fit.contain,
                    )
                },
                // fit: rive.Fit.cover,
              )),
          // RiveAnimation.asset("rive/progress_bar_concept.riv")),
          // RiveAnimation.asset("rive/loadingsquare.riv")),
        ),
      ],
    );
  }
}
