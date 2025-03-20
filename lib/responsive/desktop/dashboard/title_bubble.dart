import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:google_fonts/google_fonts.dart';

import '../desk_decks.dart';

class TitleBubble extends StatefulWidget {
  final double deckHeight;
  final double deckWidth;
  final String deckName;
  final double textSize;
  final double leftPad;
  final VoidCallback? onTap;

  const TitleBubble({
    required this.deckHeight,
    required this.deckWidth,
    required this.deckName,
    required this.leftPad,
    required this.textSize,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<TitleBubble> createState() => _TitleBubbleState();
}

class _TitleBubbleState extends State<TitleBubble> {
  final Color shadowColor = Colors.white;

  final Color buttonColor = const Color.fromARGB(255, 29, 29, 29);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.w(context)),
          color: deckColor,
          border: Border.all(color: deckBorderColor),
        ),
        constraints: 100.w(context) > 1920 ? BoxConstraints(minHeight: 110) : BoxConstraints(minHeight: 55),
        height: widget.deckHeight,
        width: widget.deckWidth,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(widget.leftPad, 0, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.transparent, Colors.transparent]),
                  boxShadow: [BoxShadow(color: Colors.transparent, blurRadius: 20, blurStyle: BlurStyle.solid)],
                  borderRadius: BorderRadius.all(Radius.circular(20.sp(context))),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    widget.deckName,
                    style: GoogleFonts.montserrat(
                      fontSize: widget.textSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
