import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
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
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:supercharged/supercharged.dart';

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
  final MultipleSearchController _teammatesSearchController =
      MultipleSearchController();
  var searchItemsList = [];
  Color highlightedColor = Colors.black87;
  final ScrollController _teammatesScrollController = ScrollController();
  int highlightIndex = -1;
  var _teammatesSelected = [];
  bool isHighlighted = false;
  FocusNode _teammatesTextFieldFocusNode = FocusNode();

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
                          Focus(
                            onFocusChange: (changed) {
                              if (changed) {
                                formScrollContrller.jumpTo(
                                    formScrollContrller.position.extentInside +
                                        100);
                              }
                              // if (!changed && searchItemsList.isEmpty) {
                              //   _teammatesSearchController.clearSearchField();
                              // }
                            },
                            onKeyEvent: (node, event) {
                              if (event is KeyDownEvent &&
                                  event.logicalKey ==
                                      LogicalKeyboardKey.arrowDown &&
                                  highlightIndex < searchItemsList.lastIndex!) {
                                print("DOWN ARROW PRESSED");
                                if (highlightIndex != -1) {
                                  _teammatesScrollController.jumpTo(
                                      (_teammatesScrollController.offset + 50)
                                          .clamp(
                                              0.0,
                                              _teammatesScrollController
                                                  .position.maxScrollExtent));
                                }
                                setState(() {
                                  highlightIndex++;
                                  print("highlightIndex: " +
                                      highlightIndex.toString());
                                  print("Search Items List Length: " +
                                      (searchItemsList.lastIndex!).toString());
                                  _teammatesScrollController;
                                });
                                return KeyEventResult.handled;
                              }
                              if (event is KeyDownEvent &&
                                  event.logicalKey ==
                                      LogicalKeyboardKey.arrowUp &&
                                  highlightIndex > 0) {
                                setState(() {
                                  highlightIndex--;
                                  _teammatesScrollController.jumpTo(
                                      (_teammatesScrollController.offset - 50)
                                          .clamp(
                                              0.0,
                                              _teammatesScrollController
                                                  .position.maxScrollExtent));
                                  print("Search Items List Length: " +
                                      (searchItemsList.lastIndex!).toString());
                                  print("highlightIndex: " +
                                      highlightIndex.toString());
                                });
                              }
                              if (event is KeyDownEvent &&
                                  event.logicalKey ==
                                      LogicalKeyboardKey.arrowUp &&
                                  highlightIndex == 0) {
                                setState(() {
                                  highlightIndex = 0;
                                  print("Search Items List Length: " +
                                      (searchItemsList.lastIndex!).toString());
                                  print("highlightIndex: " +
                                      highlightIndex.toString());
                                });
                              }
                              if (event is KeyDownEvent &&
                                  event.logicalKey ==
                                      LogicalKeyboardKey.arrowDown &&
                                  highlightIndex >=
                                      searchItemsList.lastIndex!) {
                                setState(() {
                                  highlightIndex = searchItemsList.lastIndex!;
                                  print("Search Items List Length: " +
                                      (searchItemsList.lastIndex!).toString());
                                  print("highlightIndex: " +
                                      highlightIndex.toString());
                                });
                              }
                              if (event is KeyDownEvent &&
                                  (event.logicalKey ==
                                          LogicalKeyboardKey.arrowDown ||
                                      event.logicalKey ==
                                          LogicalKeyboardKey.arrowUp)) {
                                return KeyEventResult.handled;
                              }

                              // Once Enter is pressed, add the item to the picked items list via the callback function,
                              // remove the item from the all items list via the callback function, set the highlightIndex
                              // back to 0 to reset it for the next search, clear the search field to avoid confusion, and
                              // request focus back to the TextField.

                              if (event is KeyDownEvent &&
                                  event.logicalKey ==
                                      LogicalKeyboardKey.enter) {
                                setState(() {
                                  _teammatesSearchController
                                      .getPickedItemsCallback!()
                                      .add(searchItemsList[highlightIndex]);
                                  _teammatesSearchController
                                      .getAllItemsCallback!()
                                      .remove(searchItemsList[highlightIndex]);
                                  highlightIndex = 0;

                                  _teammatesSearchController.clearSearchField();
                                });
                                print(_teammatesSearchController
                                    .getPickedItems());

                                _teammatesTextFieldFocusNode.requestFocus();
                                return KeyEventResult.handled;
                              }

                              return KeyEventResult.ignored;
                            },
                            child: Container(
                              width: 30.w(context),
                              child: MultipleSearchSelection(
                                items: projectUserList,
                                searchField: TextField(
                                  cursorColor: red,
                                  decoration: InputDecoration(
                                    labelText: 'Search Users...',
                                    labelStyle: TextStyle(color: Colors.grey),
                                    floatingLabelStyle: TextStyle(color: white),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(1.5.w(context)),
                                      borderSide: BorderSide(
                                          color: formFieldOutlineColor,
                                          width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(1.w(context)),
                                      borderSide:
                                          BorderSide(color: white, width: 1),
                                    ),
                                  ),
                                ),
                                itemsVisibility: ShowedItemsVisibility.onType,
                                controller: _teammatesSearchController,
                                showedItemsScrollController:
                                    _teammatesScrollController,
                                onItemAdded: (item) {
                                  _teammatesTextFieldFocusNode.requestFocus();
                                },
                                onSearchChanged: (text) {
                                  _teammatesSearchController
                                      .getAllItemsCallback;
                                  setState(() {
                                    searchItemsList = _teammatesSearchController
                                        .searchItems(text);
                                  });
                                },
                                sortShowedItems: true,
                                fieldToCheck: (user) => user,
                                maximumShowItemsHeight: 20.w(context),
                                clearSearchFieldOnSelect: true,
                                showSelectAllButton: false,
                                itemBuilder: (user, index, isPicked) {
                                  print(user);
                                  isHighlighted =
                                      index == highlightIndex ? true : false;
                                  highlightedColor = isHighlighted
                                      ? Colors.grey.shade700
                                      : tran;

                                  return MouseRegion(
                                    onEnter: (_) {
                                      print("HOVERED");
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(0.25.w(context)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10.w(context)),
                                          color: highlightedColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 20.0,
                                            horizontal: 12,
                                          ),
                                          child: Text(user),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                showedItemsBoxDecoration: BoxDecoration(
                                  color: Colors.black87,
                                  border: BoxBorder.all(
                                      style: BorderStyle.solid,
                                      color: deckBorderColor),
                                  borderRadius:
                                      BorderRadius.circular(1.5.w(context)),
                                ),
                                pickedItemBuilder: (user) {
                                  return TactileButton(
                                    child: GradientContainer(
                                        height: 2.w(context),
                                        width: 6.w(context),
                                        text: user,
                                        textSize: 2.sp(context),
                                        gradient1: Colors.white12,
                                        gradient2: Colors.white12,
                                        neonGlow: tran,
                                        borderColor: tran,
                                        borderRadius: 10.w(context)),
                                  );
                                },
                                pickedItemsBoxDecoration: BoxDecoration(
                                    border: BoxBorder.all(
                                        color: formFieldOutlineColor),
                                    borderRadius:
                                        BorderRadius.circular(1.5.w(context))),
                              ),
                            ),
                          ),
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
}
