import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:google_fonts/google_fonts.dart';

class NeonLabel extends StatefulWidget {
  NeonLabel(
      {super.key,
      required this.height,
      required this.width,
      required this.text,
      required this.textSize,
      required this.gradient1,
      required this.gradient2,
      required this.neonGlow,
      required this.borderColor,
      required this.borderRadius,
      required this.shadowColor});
  final double height;
  final double width;
  final String text;
  final double textSize;
  final Color gradient1;
  final Color gradient2;
  final Color neonGlow;
  final Color borderColor;
  final double borderRadius;
  final Color shadowColor;
  @override
  State<NeonLabel> createState() => _NeonLabelState();
}

class _NeonLabelState extends State<NeonLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(minHeight: 40),
        height: widget.height,
        width: widget.width,
        // padding: EdgeInsets.fromLTRB(widget.width, widget.height, widget.width, widget.height),
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [widget.gradient1, widget.gradient2]),
            boxShadow: [
              BoxShadow(
                  color: widget.neonGlow,
                  blurRadius: 9,
                  blurStyle: BlurStyle.solid)
            ],
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius)),
            border: Border.all(color: widget.borderColor)),
        child: Center(
          child: Text(
            widget.text,
            style: GoogleFonts.montserrat(
              fontSize: widget.textSize,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              shadows: [
                Shadow(color: widget.shadowColor, blurRadius: 1),
                Shadow(color: widget.shadowColor, blurRadius: 2),
              ],
            ),
          ),
        ));
  }
}
