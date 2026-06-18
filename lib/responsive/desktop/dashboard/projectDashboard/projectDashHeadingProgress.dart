import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/util/scaledButton.dart';
import 'package:flutter_application_1/util/imports.dart';
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
    return
        //
        // Project Title, Progress Bar, Spacer
        Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      spacing: max(10, 0.5.w(context)),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: max(0, 0.w(context))),
                child: GradientText(
                  text: "Carbon",
                  gradients: [pink, red],
                  fontSize: max(headerlowerlimit, 10.sp(context)),
                  fontWeight: FontWeight.bold,
                  lineHeight: 1,
                ),
              ),
            ),
            TactileButton(
                scale: 1.07,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 1.5.w(context), vertical: 0.5.w(context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w(context)),
                    border: Border.all(color: white),
                    color: tran,
                  ),
                  child: Text('Overview'),
                ))
          ],
        ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  child: Text(
                    "Turning ideas into projects and projects into companies.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: max(12, 3.sp(context)),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: TactileButton(
                  scale: 1.05,
                  child: Text(
                    "17%",
                    style: TextStyle(
                        fontSize: max(headerlowerlimit, 5.5.sp(context)),
                        fontWeight: FontWeight.w800,
                        height: 1.25),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          width: max(250, double.infinity),
          child: FAProgressBar(
            maxValue: 100,
            currentValue: 17,
            size: 17,
            borderRadius: BorderRadius.circular(10.w(context)),
            backgroundColor: deckBorderColor,
            animatedDuration: const Duration(milliseconds: 300),
            // border: BoxBorder.all(color: deckBorderColor),
            progressGradient:
                const LinearGradient(colors: [orangeGlow, orange, orangeGlow]),
            direction: Axis.horizontal,
          ),
        ),
        // Spacer(),
      ],
    );
  }
}
