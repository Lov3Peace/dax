import "package:dotted_border/dotted_border.dart";

import "../../../util/imports.dart";

class CarbonDottedLine extends StatelessWidget {
  const CarbonDottedLine(
      {super.key,
      required this.color,
      required this.dashThickness,
      required this.dashLength,
      required this.gapLength});
  final Color color;
  final double dashThickness;
  final double dashLength;
  final double gapLength;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: CustomPathDottedBorderOptions(
        color: color,
        strokeWidth: dashThickness,
        dashPattern: [dashLength, gapLength],
        customPath: (size) => Path()
          ..moveTo(0, size.height)
          ..relativeLineTo(size.width, 0),
      ),
      child: SizedBox(
        width: double.infinity,
      ),
    );
  }
}
