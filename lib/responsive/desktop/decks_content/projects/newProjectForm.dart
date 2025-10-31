import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/imports.dart';

class NewProjectForm extends StatelessWidget {
  const NewProjectForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.w(context),
      width: 50.w(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w(context)),
        color: const Color.fromARGB(185, 21, 19, 22),
        border: Border.all(color: deckBorderColor),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [Text("New Project")],
        ),
      ),
    );
  }
}
