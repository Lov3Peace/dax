import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:google_fonts/google_fonts.dart';

import '../desk_decks.dart';

class TitleBubble extends StatelessWidget {
  final String deckName;
  final double width;
  final double height;
  final BoxConstraints constraints;
  final VoidCallback? onTap;

  const TitleBubble({
    required this.deckName,
    this.width = 0,
    this.height = 0,
    required this.constraints,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.w(context)),
        color: deckColor,
        border: Border.all(color: deckBorderColor),
      ),
      constraints: constraints,
      height: height,
      width: width,
      child: Center(
        child: Text(
          deckName,
          style: GoogleFonts.montserrat(
            fontSize: 4.sp(context),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
