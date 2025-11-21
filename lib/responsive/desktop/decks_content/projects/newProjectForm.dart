import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:ionicons/ionicons.dart';

class NewProjectForm extends StatefulWidget {
  NewProjectForm({super.key});

  @override
  State<NewProjectForm> createState() => _NewProjectFormState();
}

class _NewProjectFormState extends State<NewProjectForm> {
  final TextEditingController _projectTitleController = TextEditingController();

  final TextEditingController _projectDescriptionController =
      TextEditingController();

  final TextEditingController _acceptanceCriteriaController =
      TextEditingController();

  var isGroupProject = false;

  var isSoloProject = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 1000),
      height: 40.w(context),
      width: 60.w(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w(context)),
        color: const Color.fromARGB(185, 21, 19, 22),
        border: Border.all(color: deckBorderColor),
      ),
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(35),
            child: Stack(
              children: [
                Column(
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
                    const SizedBox(height: 20),
                    //
                    // Title
                    Text(
                      textAlign: TextAlign.start,
                      "Title",
                      style: TextStyle(
                          color: Colors.white, fontSize: 4.sp(context)),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      autofocus: true,
                      cursorColor: red,
                      style: TextStyle(fontSize: 3.sp(context)),
                      controller: _projectTitleController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.w(context))),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(151, 255, 255, 255),
                            width: 0.05.w(context),
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(151, 255, 255, 255)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //
                    // Category Dropdown
                    Text(
                      textAlign: TextAlign.start,
                      "Category",
                      style: TextStyle(
                          color: Colors.white, fontSize: 4.sp(context)),
                    ),
                    const SizedBox(height: 10),
                    DropdownMenu(
                      dropdownMenuEntries: projectCategoryDropdownEntries,
                      inputDecorationTheme: InputDecorationTheme(
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.w(context))),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(151, 255, 255, 255)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //
                    // Description
                    Text(
                      textAlign: TextAlign.start,
                      "Project Description",
                      style: TextStyle(
                          color: Colors.white, fontSize: 4.sp(context)),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      cursorColor: red,
                      style: TextStyle(fontSize: 3.sp(context)),
                      controller: _projectDescriptionController,
                      minLines: 5,
                      maxLines: 10,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(1.w(context)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.w(context))),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(151, 255, 255, 255),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.w(context))),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(151, 255, 255, 255),
                            ),
                          )),
                    ),
                    const SizedBox(height: 20),
                    //
                    // Acceptance Criteria
                    Text(
                      textAlign: TextAlign.start,
                      "Acceptance Criteria",
                      style: TextStyle(
                          color: Colors.white, fontSize: 4.sp(context)),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      cursorColor: red,
                      style: TextStyle(fontSize: 3.sp(context)),
                      controller: _acceptanceCriteriaController,
                      minLines: 5,
                      maxLines: 10,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(1.w(context)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.w(context))),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(151, 255, 255, 255),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.w(context))),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(151, 255, 255, 255),
                            ),
                          )),
                    ),
                    const SizedBox(height: 20),
                    //
                    // Group or Solo
                    Row(
                      children: [
                        const Text("Group"),
                        Radio(
                          activeColor: pink,
                          hoverColor: tran,
                          value: true,
                          groupValue: isGroupProject,
                          onChanged: (value) {
                            setState(() {
                              isGroupProject = value!;
                              isSoloProject = false;
                            });
                          },
                        ),
                        SizedBox(width: 3.w(context)),
                        const Text("Solo"),
                        Radio(
                          activeColor: red,
                          hoverColor: tran,
                          value: true,
                          groupValue: isSoloProject,
                          onChanged: (value) {
                            setState(() {
                              isSoloProject = value!;
                              isGroupProject = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
