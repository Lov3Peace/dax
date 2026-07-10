import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/util/scaledButton.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/pillButton.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';

class ProjectDashHeadingProgress extends StatefulWidget {
  const ProjectDashHeadingProgress({super.key});

  @override
  State<ProjectDashHeadingProgress> createState() =>
      _ProjectDashHeadingProgressState();
}

class _ProjectDashHeadingProgressState
    extends State<ProjectDashHeadingProgress> {
  @override
  Widget build(BuildContext context) {
    //
    // Project Title, Creators, Mission Statement, Progress Bar
    return Column(
      // spacing is being determined by the flex ratio in projectDashboard.dart
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              // Project Title
              Align(
                alignment: Alignment.centerLeft,
                child: GradientText(
                  text: "Carbon",
                  gradients: [pink, red],
                  fontSize: max(36, 10.sp(context)),
                  fontWeight: FontWeight.bold,
                  lineHeight: 1,
                ),
              ),
              //
              // Overview Button
              PillButton(
                onTap: () {},
                scale: 1.04,
                padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 2.w(context), vertical: 0.5.w(context)),
                borderRadius: 10.w(context),
                borderColor: darkGrey,
                child: Text(
                  'Overview',
                  style:
                      TextStyle(fontSize: max(12, 2.sp(context)), color: white),
                ),
              ),
            ],
          ),
        ),
        //
        // Creators
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Creators: l3x, PrimeApe",
            style: TextStyle(
                fontSize: max(12, 3.sp(context)),
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade400),
          ),
        ),
        //
        // Mission Statement
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Turning ideas into projects and projects into companies.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: max(12, 3.sp(context)),
                      fontWeight: FontWeight.normal),
                ),
              ),
              //
              // Progress Percentage
              Expanded(
                flex: 1,
                child: TactileButton(
                  scale: 1.05,
                  child: Text(
                    "17%",
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: max(headerlowerlimit, 5.5.sp(context)),
                        fontWeight: FontWeight.w800,
                        height: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        //
        // Progress Bar (FUTURE: RIVE ANIMATION)
        Container(
          width: max(250, double.infinity),
          child: FAProgressBar(
            maxValue: 100,
            currentValue: 17,
            size: 1.w(context),
            borderRadius: BorderRadius.circular(10.w(context)),
            backgroundColor: deckBorderColor,
            animatedDuration: const Duration(milliseconds: 300),
            // border: BoxBorder.all(color: deckBorderColor),
            progressGradient:
                const LinearGradient(colors: [orangeGlow, orange, orangeGlow]),
            direction: Axis.horizontal,
          ),
        ),
        //
        // TO-DO: MILESTONES
      ],
    );
  }
}
