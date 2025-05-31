import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TableofContentsTemplate extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<String> labels;
  final double spacing;
  final double activeWidth;
  final double inactiveWidth;
  final double height;
  final double fontSize;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final Color activeShadowColor;
  final Color inactiveShadowColor;
  final Color backgroundColor;
  final FontWeight fontWeight;

  const TableofContentsTemplate({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.labels,
    this.spacing = 12.0,
    this.activeWidth = 180.0,
    this.inactiveWidth = 120.0,
    this.height = 40.0,
    this.fontSize = 12.0,
    this.activeTextColor = const Color.fromARGB(221, 28, 24, 24),
    this.inactiveTextColor = Colors.white54,
    this.activeBorderColor = Colors.white70,
    this.inactiveBorderColor = Colors.transparent,
    this.activeShadowColor = Colors.white,
    this.inactiveShadowColor = const Color.fromARGB(255, 74, 74, 74),
    this.backgroundColor = Colors.transparent,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(labels.length, (index) {
        final isActive = currentIndex == index;

        return Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: GestureDetector(
            onTap: () => onTap(index),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                decoration: BoxDecoration(
                  border: Border.all(color: isActive ? activeBorderColor : inactiveBorderColor),
                  boxShadow: [BoxShadow(color: isActive ? activeShadowColor : inactiveShadowColor)],
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(60),
                ),
                width: isActive ? activeWidth : inactiveWidth,
                height: height,
                alignment: Alignment.center,
                child: Text(
                  labels[index],
                  style: GoogleFonts.montserrat(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: isActive ? activeTextColor : inactiveTextColor,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
