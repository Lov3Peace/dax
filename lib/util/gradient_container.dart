import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientContainer extends StatefulWidget {
  GradientContainer({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.textSize,
    required this.gradient1,
    required this.gradient2,
    required this.neonGlow,
    required this.borderColor,
    required this.borderRadius,
  });
  double height;
  double width;
  String text;
  double textSize;
  Color gradient1;
  Color gradient2;
  Color neonGlow;
  Color borderColor;
  double borderRadius;
  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [widget.gradient1, widget.gradient2]),
          boxShadow: [BoxShadow(color: widget.neonGlow, blurRadius: 10, blurStyle: BlurStyle.solid)],
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
          border: Border.all(color: widget.borderColor)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(widget.width, widget.height, widget.width, widget.height),
        child: Text(
          widget.text,
          style: GoogleFonts.montserrat(
            fontSize: widget.textSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
