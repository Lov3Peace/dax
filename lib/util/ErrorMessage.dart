import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/imports.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          blendMode: BlendMode.darken,
          child: SizedBox(),
        ),
        AlertDialog(
          backgroundColor: tran,
          content: Container(
            padding: EdgeInsetsGeometry.all(1.w(context)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.5.w(context)),
                color: deckColor,
                border: Border.all(color: deckBorderColor)),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 3.sp(context), color: white),
            ),
          ),
        )
      ]),
    );
  }
}
