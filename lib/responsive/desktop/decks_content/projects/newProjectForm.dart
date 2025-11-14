import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/imports.dart';

class NewProjectForm extends StatelessWidget {
  NewProjectForm({super.key});

  final TextEditingController _projectTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 1000),
      height: 35.w(context),
      width: 50.w(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w(context)),
        color: const Color.fromARGB(185, 21, 19, 22),
        border: Border.all(color: deckBorderColor),
      ),
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Project",
                  style: TextStyle(
                      fontSize: 5.sp(context), fontWeight: FontWeight.w600),
                ),
                const Divider(
                  color: Color.fromARGB(151, 255, 255, 255),
                ),
                //
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    textAlign: TextAlign.start,
                    "Title",
                    style:
                        TextStyle(color: Colors.white, fontSize: 4.sp(context)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: TextField(
                    autofocus: true,
                    style: TextStyle(fontSize: 3.sp(context)),
                    controller: _projectTitleController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(20.w(context))),
                        borderSide: BorderSide(
                          color: Color.fromARGB(151, 255, 255, 255),
                          width: 0.05.w(context),
                        ),
                      ),
                    ),
                  ),
                ),
                //
                // Category Dropdown
                Padding(
                  padding: EdgeInsets.only(),
                  child: DropdownMenu(
                      dropdownMenuEntries: projectCategoryDropdownEntries),
                ),
              ],
            ).animate().fadeIn(
                delay: Duration(milliseconds: 200),
                duration: Duration(milliseconds: 50))),
      ),
    );
  }
}
