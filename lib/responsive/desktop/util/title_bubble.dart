import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:google_fonts/google_fonts.dart';

import '../desk_decks.dart';

class TitleBubble extends StatefulWidget {
  final String deckName;
  final VoidCallback? onTap;

  const TitleBubble({
    required this.deckName,
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
        constraints: const BoxConstraints(minHeight: 70, maxHeight: 300),
        height: 5.w(context),
        width: 17.25.w(context),
        child: Center(
          child: Text(
            widget.deckName,
            style: GoogleFonts.montserrat(
              fontSize: 4.sp(context),
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
