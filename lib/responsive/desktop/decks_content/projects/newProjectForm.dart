import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/estimatedTimeToCompletionLists.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectRolesList.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectUserList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/blurryContainer.dart';
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

  bool isGroupProject = true;
  bool isSoloProject = false;
  bool isParticipantsVisible = true;
  bool isPublic = true;
  bool isPrivate = false;
  bool isRolesNeededVisible = true;
  var projectCategoryValue;
  var projectUserListValue;
  var etcUnitsValue;
  var etcValuesValue;
  var rolesNeededValue;
  var projectRolesValue;

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      height: 40.w(context),
      width: 60.w(context),
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
                          fontSize: 7.sp(context), fontWeight: FontWeight.w700),
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
                          color: Colors.white,
                          fontSize: 4.sp(context),
                          fontWeight: FontWeight.w600),
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
                          color: Colors.white,
                          fontSize: 4.sp(context),
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton2(
                      items: projectCategoryDropdownItems,
                      value: projectCategoryValue,
                      onChanged: (selectedValue) {
                        setState(() {
                          projectCategoryValue = selectedValue;
                        });
                      },
                      dropdownStyleData: DropdownStyleData(
                          maxHeight: 15.w(context),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.w(context))),
                            border: Border.all(
                              color: deckBorderColor,
                            ),
                          )),
                    ),
                    const SizedBox(height: 20),
                    //
                    // Description
                    Text(
                      textAlign: TextAlign.start,
                      "Project Description",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 4.sp(context),
                          fontWeight: FontWeight.w600),
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
                          color: Colors.white,
                          fontSize: 4.sp(context),
                          fontWeight: FontWeight.w600),
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
                    Text(
                      textAlign: TextAlign.start,
                      "Participation",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 4.sp(context),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Row(
                        children: [
                          const Text("Group"),
                          Radio(
                            activeColor: red,
                            hoverColor: tran,
                            value: true,
                            groupValue: isGroupProject,
                            onChanged: (value) {
                              setState(() {
                                isGroupProject = value!;
                                isSoloProject = false;
                                isParticipantsVisible = true;
                                isRolesNeededVisible = true;
                              });
                            },
                          ),
                          SizedBox(width: 3.w(context)),
                          const Text("Solo"),
                          Radio(
                            activeColor: pink,
                            hoverColor: tran,
                            value: true,
                            groupValue: isSoloProject,
                            onChanged: (value) {
                              setState(() {
                                isSoloProject = value!;
                                isGroupProject = false;
                                isParticipantsVisible = false;
                                isRolesNeededVisible = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    //
                    // Teammates
                    Visibility(
                      visible: isParticipantsVisible,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            textAlign: TextAlign.start,
                            "Teammates",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 4.sp(context),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          DropdownButton2(
                            items: projectUserList,
                            value: projectUserListValue,
                            onChanged: (selectedValue) {
                              setState(() {
                                projectUserListValue = selectedValue;
                              });
                            },
                            dropdownStyleData: DropdownStyleData(
                                maxHeight: 15.w(context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(1.w(context))),
                                  border: Border.all(
                                    color: deckBorderColor,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    //
                    // Estimated Time to Completion
                    Text(
                      textAlign: TextAlign.start,
                      "Estimated Time to Completion",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 4.sp(context),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        DropdownButton2(
                          items: etcValues,
                          value: etcValuesValue,
                          onChanged: (selectedValue) {
                            setState(() {
                              etcValuesValue = selectedValue;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(
                              maxHeight: 15.w(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(1.w(context))),
                                border: Border.all(
                                  color: deckBorderColor,
                                ),
                              )),
                        ),
                        SizedBox(width: 10),
                        DropdownButton2(
                          items: etcUnits,
                          value: etcUnitsValue,
                          onChanged: (selectedValue) {
                            setState(() {
                              etcUnitsValue = selectedValue;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(
                              maxHeight: 15.w(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(1.w(context))),
                                border: Border.all(
                                  color: deckBorderColor,
                                ),
                              )),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    //
                    // Privacy
                    Text(
                      textAlign: TextAlign.start,
                      "Privacy",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 4.sp(context),
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Row(
                        children: [
                          const Text("Public"),
                          Radio(
                            activeColor: red,
                            hoverColor: tran,
                            value: true,
                            groupValue: isPublic,
                            onChanged: (value) {
                              setState(() {
                                isPublic = value!;
                                isPrivate = false;
                              });
                            },
                          ),
                          SizedBox(width: 3.w(context)),
                          const Text("Private"),
                          Radio(
                            activeColor: pink,
                            hoverColor: tran,
                            value: true,
                            groupValue: isPrivate,
                            onChanged: (value) {
                              setState(() {
                                isPrivate = value!;
                                isPublic = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Visibility(
                      visible: isRolesNeededVisible,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            "Roles Needed",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 4.sp(context),
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10),
                          DropdownButton2(
                            items: projectRoles,
                            value: projectRolesValue,
                            onChanged: (selectedValue) {
                              setState(() {
                                projectRolesValue = selectedValue;
                              });
                            },
                            dropdownStyleData: DropdownStyleData(
                                maxHeight: 15.w(context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(1.w(context))),
                                  border: Border.all(
                                    color: deckBorderColor,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
