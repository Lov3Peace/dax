import 'dart:convert';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/estimatedTimeToCompletionLists.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectRolesList.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectUserList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/blurryContainer.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:ionicons/ionicons.dart';
import 'package:optimized_search_field/optimized_search_field.dart';

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

  Color formFieldOutlineColor = const Color.fromARGB(151, 255, 255, 255);
  bool isGroupProject = true;
  bool isSoloProject = false;
  bool isPublic = true;
  bool isPrivate = false;
  bool isTeammatesVisible = true;
  bool isRolesNeededVisible = true;
  var projectCategoryValue;
  var projectUserListValue;
  var etcUnitsValue;
  var etcValuesValue;
  var rolesNeededValue;
  var projectRolesValue;
  ScrollController formScrollContrller = ScrollController();

// Group vs Solo
  Color grpButtonColor1 = pink;
  Color grpButtonColor2 = red;
  Color grpButtonBorderColor = tran;
  Color soloButtonColor1 = tran;
  Color soloButtonColor2 = tran;
  Color soloButtonGlow = tran;
  Color soloButtonBorderColor = deckBorderColor;

// Public vs Private
  Color pubButtonColor1 = pink;
  Color pubButtonColor2 = red;
  Color pubButtonBorderColor = tran;
  Color privateButtonColor1 = tran;
  Color privateButtonColor2 = tran;
  Color privateButtonGlow = tran;
  Color privateButtonBorderColor = deckBorderColor;

  // Teammates Search Dropdown
  // final MultipleSearchController _teammatesSearchController =MultipleSearchController();
  late FocusNode teammatesNode;
  final TextEditingController _teammatesSearchController =
      TextEditingController();
  var searchItemsList = [];
  Color highlightedColor = Colors.black87;
  final ScrollController _teammatesScrollController = ScrollController();
  int highlightIndex = -1;
  var _teammatesSelected = [];
  bool isHighlighted = false;
  FocusNode _teammatesTextFieldFocusNode = FocusNode();
  List<String> selectedTeammates = [];
  bool isSearchEmpty = true;
  bool isTeammateSelected = false;
  final textFieldKey = GlobalKey();
  var searchResultsListKey = GlobalKey();
  var teammateOptionsList;
  //     items: projectUserList,
  //     displayProperty: (user) => user,
  //     filterProperty: (user) => user);

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      height: 40.w(context),
      width: 60.w(context),
      child: SingleChildScrollView(
        controller: formScrollContrller,
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
                    Divider(
                      color: formFieldOutlineColor,
                    ),
                    const SizedBox(height: 25),
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
                    const SizedBox(height: 20),
                    TextField(
                      autofocus: true,
                      cursorColor: red,
                      style: TextStyle(fontSize: 3.sp(context)),
                      controller: _projectTitleController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1.5.w(context)),
                          borderSide: BorderSide(
                            color: formFieldOutlineColor,
                            width: 0.05.w(context),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1.w(context)),
                          borderSide: BorderSide(color: white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
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
                    const SizedBox(height: 20),
                    DropdownButton2(
                      items: projectCategoryDropdownItems,
                      value: projectCategoryValue,
                      onChanged: (selectedValue) {
                        setState(() {
                          projectCategoryValue = selectedValue;
                        });
                      },
                      style: TextStyle(fontSize: 3.sp(context), color: white),
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
                    const SizedBox(height: 25),
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
                    const SizedBox(height: 20),
                    TextField(
                      cursorColor: red,
                      style: TextStyle(fontSize: 3.sp(context)),
                      controller: _projectDescriptionController,
                      minLines: 5,
                      maxLines: 10,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1.5.w(context)),
                          borderSide: BorderSide(
                              color: formFieldOutlineColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1.w(context)),
                          borderSide: BorderSide(color: white, width: 1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
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
                    const SizedBox(height: 20),
                    TextField(
                      cursorColor: red,
                      style: TextStyle(fontSize: 3.sp(context)),
                      controller: _acceptanceCriteriaController,
                      minLines: 5,
                      maxLines: 10,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1.5.w(context)),
                          borderSide: BorderSide(
                              color: formFieldOutlineColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1.w(context)),
                          borderSide: BorderSide(color: white, width: 1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
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
                    SizedBox(height: 20),
                    Row(
                      children: [
                        TactileButton(
                          scale: 1.05,
                          onTap: () {
                            setState(() {
                              grpButtonColor1 = pink;
                              grpButtonColor2 = red;
                              grpButtonBorderColor = tran;
                              isGroupProject = true;
                              isTeammatesVisible = true;
                              _teammatesTextFieldFocusNode = FocusNode();
                              isRolesNeededVisible = true;

                              soloButtonColor1 = tran;
                              soloButtonColor2 = tran;
                              soloButtonGlow = tran;
                              soloButtonBorderColor = deckBorderColor;
                              isSoloProject = false;
                            });
                          },
                          child: GradientContainer(
                            height: 2.w(context),
                            width: 6.w(context),
                            text: "Group",
                            textSize: 2.sp(context),
                            gradient1: grpButtonColor1,
                            gradient2: grpButtonColor2,
                            neonGlow: tran,
                            borderColor: grpButtonBorderColor,
                            borderRadius: 10.w(context),
                          ),
                        ),
                        SizedBox(width: 25),
                        TactileButton(
                          scale: 1.05,
                          onTap: () {
                            setState(() {
                              soloButtonColor1 = pink;
                              soloButtonColor2 = red;
                              soloButtonGlow = tran;
                              soloButtonBorderColor = tran;
                              isSoloProject = true;
                              isTeammatesVisible = false;
                              isRolesNeededVisible = false;

                              grpButtonColor1 = tran;
                              grpButtonColor2 = tran;
                              grpButtonBorderColor = deckBorderColor;
                              isGroupProject = false;
                            });
                          },
                          child: GradientContainer(
                            height: 2.w(context),
                            width: 6.w(context),
                            text: "Solo",
                            textSize: 2.sp(context),
                            gradient1: soloButtonColor1,
                            gradient2: soloButtonColor2,
                            neonGlow: soloButtonGlow,
                            borderColor: soloButtonBorderColor,
                            borderRadius: 10.w(context),
                          ),
                        )
                      ],
                    ),
                    //
                    // Teammates
                    Visibility(
                      visible: isTeammatesVisible,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25),
                          Text(
                            textAlign: TextAlign.start,
                            "Teammates",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 4.sp(context),
                                fontWeight: FontWeight.w600),
                          ),
                          BaseMultiSearchField<String>(
                              textFieldKey: textFieldKey,
                              labelText: "Seach for Users...",
                              controller: _teammatesSearchController,
                              dropDownList: projectUserList,
                              getItemText: (text) {
                                print("TEXT: " + text);
                                if (projectUserList.contains(text)) {
                                  return text;
                                }
                                return "";
                              },
                              menuDecoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius:
                                      BorderRadius.circular(1.w(context))),
                              menuMargin: EdgeInsets.fromLTRB(0, 10, 300, 0),
                              focusNode: _teammatesTextFieldFocusNode,
                              listController: _teammatesScrollController,

                              // listPadding: EdgeInsets.only(left: 0),
                              menuMaxHeight: 200,
                              selectedWidget: (user) => TactileButton(
                                    scale: 1.10,
                                    onTap: () => setState(() {
                                      selectedTeammates.remove(user);
                                    }),
                                    child: GradientContainer(
                                      height: 2.w(context),
                                      width: 6.w(context),
                                      text: user,
                                      textSize: 2.sp(context),
                                      gradient1: Colors.white12,
                                      gradient2: Colors.white12,
                                      neonGlow: tran,
                                      borderColor: tran,
                                      borderRadius: 10.w(context),
                                    ),
                                  ),
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return [];
                                }
                                setState(() {
                                  teammateOptionsList = projectUserList
                                      .where((value) =>
                                          value.contains(
                                              textEditingValue.text) &&
                                          !selectedTeammates.contains(value))
                                      .toList();
                                });
                                return projectUserList.where((value) =>
                                    value.contains(textEditingValue.text) &&
                                    !selectedTeammates.contains(value));
                              },
                              listClipBehavior: Clip.none,
                              listButtonItem: (
                                  {required index,
                                  required isEnabled,
                                  key,
                                  required onPressed,
                                  required value}) {
                                isHighlighted =
                                    index == highlightIndex ? true : false;
                                highlightedColor = isHighlighted ? red : tran;

                                teammatesNode =
                                    Focus.of(textFieldKey.currentContext!);
                                teammatesNode.requestFocus();
                                if (teammatesNode.hasFocus) {
                                  print("TEAMMATES NODE HAS FOCUS");
                                }

                                teammatesNode.onKeyEvent = (node, event) {
                                  if (value.isNotEmpty) {
                                    // DOWN ARROW
                                    if (event is KeyDownEvent &&
                                        event.logicalKey ==
                                            LogicalKeyboardKey.arrowDown &&
                                        highlightIndex <
                                            teammateOptionsList.length - 1) {
                                      print("DOWN ARROW PRESSED");
                                      print("TEAMMATES OPTIONS LIST: " +
                                          teammateOptionsList.toString());
                                      if (highlightIndex != -1) {
                                        _teammatesScrollController.jumpTo(
                                            (_teammatesScrollController.offset +
                                                    50)
                                                .clamp(
                                                    0.0,
                                                    _teammatesScrollController
                                                        .position
                                                        .maxScrollExtent));
                                      }
                                      setState(() {
                                        highlightIndex++;
                                        print("highlightIndex: " +
                                            highlightIndex.toString());
                                        print("Teammate Options List Length: " +
                                            (teammateOptionsList.length - 1)
                                                .toString());
                                        _teammatesScrollController;
                                      });
                                      return KeyEventResult.handled;
                                    }
                                    // DOWN ARROW UPPER LIMIT
                                    if (event is KeyDownEvent &&
                                        event.logicalKey ==
                                            LogicalKeyboardKey.arrowDown &&
                                        highlightIndex >=
                                            teammateOptionsList.length - 1) {
                                      setState(() {
                                        highlightIndex =
                                            teammateOptionsList.length - 1;
                                        print("Teammate Options List Length: " +
                                            (teammateOptionsList.length - 1)
                                                .toString());
                                        print("highlightIndex: " +
                                            highlightIndex.toString());
                                      });
                                      return KeyEventResult.handled;
                                    }
                                    // UP ARROW
                                    if (event is KeyDownEvent &&
                                        event.logicalKey ==
                                            LogicalKeyboardKey.arrowUp &&
                                        highlightIndex > 0) {
                                      setState(() {
                                        highlightIndex--;
                                        _teammatesScrollController.jumpTo(
                                            (_teammatesScrollController.offset -
                                                    50)
                                                .clamp(
                                                    0.0,
                                                    _teammatesScrollController
                                                        .position
                                                        .maxScrollExtent));
                                        print("Teammate Options List Length: " +
                                            (teammateOptionsList.length - 1)
                                                .toString());
                                        print("highlightIndex: " +
                                            highlightIndex.toString());
                                      });
                                      return KeyEventResult.handled;
                                    }
                                    // UP ARROW LOWER LIMIT
                                    if (event is KeyDownEvent &&
                                        event.logicalKey ==
                                            LogicalKeyboardKey.arrowUp &&
                                        highlightIndex == 0) {
                                      setState(() {
                                        highlightIndex = 0;
                                        print("Teammate Options List Length: " +
                                            (teammateOptionsList.length - 1)
                                                .toString());
                                        print("highlightIndex: " +
                                            highlightIndex.toString());
                                      });
                                      return KeyEventResult.handled;
                                    }
                                    return KeyEventResult.ignored;
                                  }
                                  return KeyEventResult.ignored;
                                };
                                // WidgetsBinding.instance
                                //     .addPostFrameCallback((_) {
                                //   final textFieldContext =
                                //       textFieldKey.currentContext;
                                //   if (textFieldContext != null) {
                                //     final focusNode =
                                //         Focus.of(textFieldContext);
                                //     focusNode.onKeyEvent = (node, event) {
                                //       if (event is KeyDownEvent &&
                                //           event.logicalKey ==
                                //               LogicalKeyboardKey.arrowDown) {
                                //         setState(() => highlightIndex++);
                                //         return KeyEventResult.handled;
                                //       }
                                //       return KeyEventResult.ignored;
                                //     };
                                //   }
                                // });
                                return TactileButton(
                                    scale: 1.10,
                                    onTap: onPressed,
                                    child: GradientContainer(
                                        height: 3.w(context),
                                        width: 6.w(context),
                                        text: value,
                                        textSize: 3.sp(context),
                                        gradient1: highlightedColor,
                                        gradient2: highlightedColor,
                                        neonGlow: tran,
                                        borderColor: tran,
                                        borderRadius: 10.w(context)));
                                ;
                              },
                              item: (user) => Text(user),
                              removeEvent: (removedItem) => setState(() {
                                    selectedTeammates.remove(removedItem);
                                  }),
                              values: selectedTeammates,
                              onSelected: (selectedItem) => setState(() {
                                    var optionHighlighted =
                                        teammateOptionsList[highlightIndex];
                                    if (projectUserList
                                        .contains(selectedItem)) {
                                      selectedTeammates.add(selectedItem);
                                    }
                                    if (projectUserList
                                            .contains(optionHighlighted) &&
                                        !projectUserList
                                            .contains(selectedItem)) {
                                      selectedTeammates.add(optionHighlighted);
                                    }
                                    highlightIndex = 0;
                                  }),
                              fieldSuffixIcon: ({
                                required menuOpened,
                                required onCloseIconTap,
                                required onlyCloseMenu,
                              }) {
                                return menuOpened
                                    ? IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: onCloseIconTap,
                                      )
                                    : const Icon(Icons.arrow_drop_down);
                              }),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),

                    SizedBox(height: 25),
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
                    SizedBox(height: 20),
                    Row(
                      children: [
                        DropdownButton2(
                          items: etcValues,
                          value: etcValuesValue,
                          style:
                              TextStyle(fontSize: 3.sp(context), color: white),
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
                        SizedBox(width: 20),
                        DropdownButton2(
                          items: etcUnits,
                          value: etcUnitsValue,
                          style:
                              TextStyle(fontSize: 3.sp(context), color: white),
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

                    SizedBox(height: 25),
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
                    SizedBox(height: 20),
                    Row(
                      children: [
                        TactileButton(
                          scale: 1.05,
                          onTap: () {
                            setState(() {
                              pubButtonColor1 = pink;
                              pubButtonColor2 = red;
                              pubButtonBorderColor = tran;
                              isPublic = true;

                              privateButtonColor1 = tran;
                              privateButtonColor2 = tran;
                              privateButtonGlow = tran;
                              privateButtonBorderColor = deckBorderColor;
                              isPrivate = false;
                            });
                          },
                          child: GradientContainer(
                            height: 2.w(context),
                            width: 6.w(context),
                            text: "Public",
                            textSize: 2.sp(context),
                            gradient1: pubButtonColor1,
                            gradient2: pubButtonColor2,
                            neonGlow: tran,
                            borderColor: pubButtonBorderColor,
                            borderRadius: 10.w(context),
                          ),
                        ),
                        SizedBox(width: 25),
                        TactileButton(
                          scale: 1.05,
                          onTap: () {
                            setState(() {
                              privateButtonColor1 = pink;
                              privateButtonColor2 = red;
                              privateButtonBorderColor = tran;
                              isPrivate = true;

                              pubButtonColor1 = tran;
                              pubButtonColor2 = tran;
                              pubButtonBorderColor = deckBorderColor;
                              isPublic = false;
                            });
                          },
                          child: GradientContainer(
                            height: 2.w(context),
                            width: 6.w(context),
                            text: "Private",
                            textSize: 2.sp(context),
                            gradient1: privateButtonColor1,
                            gradient2: privateButtonColor2,
                            neonGlow: tran,
                            borderColor: privateButtonBorderColor,
                            borderRadius: 10.w(context),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 25),

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
                          SizedBox(height: 20),
                          DropdownButton2(
                            items: projectRoles,
                            value: projectRolesValue,
                            onChanged: (selectedValue) {
                              setState(() {
                                projectRolesValue = selectedValue;
                              });
                            },
                            style: TextStyle(
                                fontSize: 3.sp(context), color: white),
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

  var list = [
    Contact(1, "Joel McHale"),
    Contact(2, "Danny Pudi"),
    Contact(3, "Donald Glover"),
    Contact(4, "Gillian Jacobs"),
    Contact(5, "Alison Brie"),
    Contact(6, "Chevy Chase"),
    Contact(7, "Jim Rush"),
    Contact(8, "Yvette Nicole Brown"),
    Contact(9, "Jeff Winger"),
    Contact(10, "Abed Nadir"),
    Contact(11, "Troy Barnes"),
    Contact(12, "Britta Perry"),
    Contact(13, "Annie Edison"),
  ];
}

class Contact {
  final int id;
  final String name;

  Contact(
    this.id,
    this.name,
  );

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
