import 'package:flutter_application_1/util/imports.dart';

class GradientText extends StatelessWidget {
  final String text;
  final List<Color> gradients;
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final double lineHeight;

  const GradientText(
      {required this.text,
      required this.gradients,
      this.fontSize = 16,
      this.fontWeight = FontWeight.normal,
      this.fontFamily,
      this.lineHeight = 1.25,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: gradients,
      ).createShader(bounds),
      child: Text(
        text,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            color: Colors.white,
            height: lineHeight),
      ),
    );
  }
}
