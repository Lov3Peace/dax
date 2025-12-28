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
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/blurryContainer.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/providers/userProvider.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:ionicons/ionicons.dart';
import 'package:optimized_search_field/optimized_search_field.dart';
import 'package:http/browser_client.dart' as httpClient;
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';
import 'package:uuid/v4.dart';

class NewProjectForm extends StatefulWidget {
  NewProjectForm({super.key});

  @override
  State<NewProjectForm> createState() => _NewProjectFormState();
}

class _NewProjectFormState extends State<NewProjectForm> {
  Map projectData = {};
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
  var _projectCategoryValue;
  var projectUserListValue;
  var etcUnitsValue;
  var etcValuesValue;
  var rolesNeededValue;
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
  late FocusNode teammateOptionsNode;
  FocusNode _teammatesTextFieldFocusNode = FocusNode();
  final TextEditingController _teammatesSearchController =
      TextEditingController();
  var searchItemsList = [];
  Color highlightedColor = Colors.black87;
  final ScrollController _teammatesScrollController = ScrollController();
  int highlightIndex = 0;
  var _teammatesSelected = [];
  bool isHighlighted = false;
  List<String> _selectedTeammates = [];
  bool isSearchEmpty = true;
  bool isTeammateSelected = false;
  final textFieldKey = GlobalKey();
  var searchResultsListKey = GlobalKey();
  List<String> placeholderUsers = [];
  List<String> teammateOptionsList = [];
  var users;
  bool searching = true;
  //     items: projectUserList,
  //     displayProperty: (user) => user,
  //     filterProperty: (user) => user);
  final client = httpClient.BrowserClient()..withCredentials = true;
  Future createProjectPost() async {
    try {
      final createProjectEndpoint = Uri.parse("$hostname/api/createNewProject");
      final pid = const UuidV4().generate();
      final title = _projectTitleController.text;
      final description = _projectDescriptionController.text;
      final category = _projectCategoryValue.toString();
      final acceptanceCriteria = _acceptanceCriteriaController.text;
      final etc = etcValuesValue.toString() + " " + etcUnitsValue.toString();
      final timestamp = DateTime.now().toString();
      var errorText = "";

      if (title.isEmpty) {
        errorText = errorText + "- Title Cannot Be Empty\n";
      }
      if (description.isEmpty) {
        errorText = errorText + "- Description Cannot Be Empty\n";
      }
      if (category.contains("null")) {
        errorText = errorText + "- Category Cannot Be Empty\n";
      }
      if (acceptanceCriteria.isEmpty) {
        errorText = errorText + "- Acceptance Criteria Cannot Be Empty\n";
      }
      if (etc.contains("null")) {
        errorText = errorText +
            "- Estimated Time of Completion Fields Cannot Be Empty\n";
      }
      if (errorText.startsWith("-")) {
        return showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: BlurryContainer(
                    width: 30.w(context),
                    height: 20.w(context),
                    borderRadius: 1.5.w(context),
                    child: Padding(
                      padding: EdgeInsets.all(2.w(context)),
                      child: SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Errors Found",
                            style: TextStyle(
                                color: red,
                                fontSize: 5.sp(context),
                                fontWeight: FontWeight.w800),
                          ),
                          Divider(),
                          Text(
                            errorText,
                            style: TextStyle(fontSize: 3.sp(context)),
                          ),
                        ],
                      )),
                    )),
              );
            });
      }

      var userProvider = Provider.of<UserProvider>(context, listen: false);
      projectData.addAll({
        "pid": pid,
        "user": userProvider.username,
        "title": title,
        "category": category,
        "description": description,
        "acceptanceCriteria": acceptanceCriteria,
        "public": isPublic,
        "group": isGroupProject,
        "teammates": _selectedTeammates,
        "etc": etc,
        "rolesNeeded": rolesNeededValue,
        "timestamp": timestamp,
      });
      final res = await client.post(createProjectEndpoint,
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(projectData));
      final resBody = res.body;
      print("Project Post Response: $resBody");
      return 1;
    } catch (e) {
      print("Couldn't eeen do it: $e");
    }
  }

  Future _fetchUsers(searchString) async {
    try {
      final getUsersEndpoint =
          Uri.parse("$hostname/api/getUsers?searchString=$searchString");
      final res = await client.get(
        getUsersEndpoint,
        headers: {
          "Content-Type": "application/json",
        },
      );
      final body = jsonDecode(res.body);
      setState(() {
        users = body;
      });
      return users;
    } catch (e) {
      print("COULDNT EEN DO IT: $e");
    }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      height: 40.w(context),
      width: 60.w(context),
      borderRadius: 1.5.w(context),
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
                    Row(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "Title",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 4.sp(context),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          " *",
                          style: TextStyle(
                              color: red,
                              fontSize: 4.sp(context),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
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
                    Row(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "Category",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 4.sp(context),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          " *",
                          style: TextStyle(
                              color: red,
                              fontSize: 4.sp(context),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    DropdownButton2(
                      items: projectCategoryDropdownItems,
                      value: _projectCategoryValue,
                      onChanged: (selectedValue) {
                        setState(() {
                          _projectCategoryValue = selectedValue;
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
                    Row(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "Project Description",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 4.sp(context),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          " *",
                          style: TextStyle(
                              color: red,
                              fontSize: 4.sp(context),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
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
                    Row(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "Acceptance Criteria",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 4.sp(context),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          " *",
                          style: TextStyle(
                              color: red,
                              fontSize: 4.sp(context),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
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
                              _selectedTeammates.clear();
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
                          const SizedBox(height: 15),
                          BaseMultiSearchField<String>(
                            dropDownList: placeholderUsers,
                            values: _selectedTeammates,
                            item: (user) => Text(user),
                            textFieldKey: textFieldKey,

                            labelText: "Seach for Users...",
                            labelTextStyle:
                                TextStyle(fontSize: 2.5.sp(context)),

                            showErrorText: true,
                            controller: _teammatesSearchController,
                            optionsBuilder:
                                (TextEditingValue textEditingValue) async {
                              if (textEditingValue.text.isEmpty) {
                                return [];
                              }
                              if (textEditingValue.text.length > 1) {
                                await _fetchUsers(textEditingValue.text)
                                    .then((_) {
                                  setState(() {
                                    searching = false;
                                    teammateOptionsList.clear();
                                  });
                                });
                                for (var user in users) {
                                  if (!teammateOptionsList
                                          .contains(user["username"]) &&
                                      !_selectedTeammates
                                          .contains(user["username"])) {
                                    teammateOptionsList.add(user["username"]);
                                  }
                                }

                                return teammateOptionsList;
                              }
                              return [];
                            },
                            getItemText: (text) {
                              if (teammateOptionsList.contains(text)) {
                                return text;
                              }
                              return "";
                            },
                            focusNode: _teammatesTextFieldFocusNode,
                            // The scroll controller for the options list
                            listController: _teammatesScrollController,
                            selectedWidget: (user) => TactileButton(
                              scale: 1.10,
                              // Remove the selected teammate on tap
                              onTap: () => setState(() {
                                _selectedTeammates.remove(user);
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
                            listButtonItem: (
                                {required index,
                                required isEnabled,
                                key,
                                required onPressed,
                                required value}) {
                              isHighlighted =
                                  index == highlightIndex ? true : false;
                              highlightedColor = isHighlighted ? red : tran;

// We create a FocusNode for the textFieldKey(thankfully this is a parameter of the widget
// to get access to the onKeyEvent() function. We must return a KeyEventResult for each
// scenario. This is to give the ability to use arrow keys to cycle through the options.
// This will be turned into its own widget.
                              teammateOptionsNode =
                                  Focus.of(textFieldKey.currentContext!);

                              teammateOptionsNode.onKeyEvent = (node, event) {
                                if (value.isNotEmpty) {
                                  // teammateOptionsNode.requestFocus();
                                  // DOWN ARROW
                                  if (event is KeyDownEvent &&
                                      event.logicalKey ==
                                          LogicalKeyboardKey.arrowDown &&
                                      highlightIndex <
                                          teammateOptionsList.length - 1) {
                                    if (highlightIndex != 0) {
                                      _teammatesScrollController.animateTo(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                          _teammatesScrollController.offset +
                                              3.5
                                                  .w(
                                                      context) // Height of one item in search results
                                                  .clamp(
                                                      0.0,
                                                      _teammatesScrollController
                                                          .position
                                                          .maxScrollExtent));
                                    }
                                    setState(() {
                                      highlightIndex++;
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
                                    });
                                    return KeyEventResult.handled;
                                  }
                                  // UP ARROW
                                  if (event is KeyDownEvent &&
                                      event.logicalKey ==
                                          LogicalKeyboardKey.arrowUp &&
                                      highlightIndex > 0) {
                                    _teammatesScrollController.animateTo(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        (_teammatesScrollController.offset -
                                                3.5.w(context))
                                            .clamp(
                                                0.0,
                                                _teammatesScrollController
                                                    .position.maxScrollExtent));
                                    setState(() {
                                      highlightIndex--;
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
                                    });
                                    return KeyEventResult.handled;
                                  }
                                  // Must return a KeyEventResult
                                  return KeyEventResult.ignored;
                                }
                                // Must return a KeyEventResult
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
                                  scale: 1.05,
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
                            },
                            menuList: ({required item, required length}) {
                              if (searching == true) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(1.w(context)),
                                    child: CircularProgressIndicator(
                                      color: red,
                                    ),
                                  ),
                                );
                              }

                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListView.builder(
                                  itemCount: length,
                                  controller: _teammatesScrollController,
                                  itemBuilder: (context, index) => item(index),
                                ),
                              );
                            },
                            removeEvent: (removedItem) => setState(() {
                              _selectedTeammates.remove(removedItem);
                            }),
                            onSelected: (selectedItem) {
                              setState(() {
                                // This takes whatever you click on (selectedItem) and changes teammateOptionsList
                                // to that (so like teammateOptionsList = [l3x]). Then it appends
                                // teammateOptionsList to _selectedTeammates. Not sure why it works this way but
                                // it does. So, we use one variable (optionSelected) and adjust it to be the
                                // option that is highlighted when user presses Enter (teammateOptionsList[highlightIndex])
                                //or the option that is clicked (teammateOptionsList[0])
                                // var tolLen = teammateOptionsList.length;
                                // var optionSelected = teammateOptionsList[
                                //     0]; // default val is the first index
                                // if (tolLen != 1) {
                                // only change to the highlightIndex if tol_len != 1 (tol_len only == 1
                                // if you click on the option...not sure why)
                                var optionSelected =
                                    teammateOptionsList[highlightIndex];
                                // }
                                // print("Users: $users");
                                // print("TOL Length: $tol_len");
                                // print("TOL: $teammateOptionsList");
                                // print("optionSelected: $optionSelected");
                                // // _selectedTeammates.add(optionSelected);

                                print("SELECTED ITEM: $selectedItem");
                                // ON CLICK
                                if (teammateOptionsNode.hasFocus &&
                                    teammateOptionsList
                                        .contains(selectedItem) &&
                                    !_selectedTeammates
                                        .contains(selectedItem)) {
                                  _selectedTeammates.add(selectedItem);
                                }

                                print("OPTION SELECTED: $optionSelected");
                                // ON PRESS ENTER
                                if (teammateOptionsNode.hasFocus &&
                                    teammateOptionsList
                                        .contains(optionSelected) &&
                                    !_selectedTeammates
                                        .contains(selectedItem) &&
                                    !_selectedTeammates
                                        .contains(optionSelected)) {
                                  _selectedTeammates.add(optionSelected);
                                }
                                highlightIndex = 0;
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  _teammatesTextFieldFocusNode.requestFocus();
                                });
                              });
                              _teammatesTextFieldFocusNode.requestFocus();
                              if (_teammatesTextFieldFocusNode.hasFocus) {
                                print(
                                    "_teammatesTextFieldFocusNode  HAS FOCUS");
                              }
                            },
                            // customTextField because you can't change the input text font
                            // size otherwise. Pass the textFieldKey and everything works.
                            customTextField: ({
                              required controller,
                              required focusNode,
                              required key,
                              required onChanged,
                              required onSubmitted,
                              required suffixIcon,
                              required textFieldKey,
                            }) {
                              if (focusNode.hasFocus) {
                                print("focusNode HAS FOCUS");
                              }
                              return TextField(
                                key: textFieldKey,
                                controller: controller,
                                focusNode: focusNode,
                                onChanged: onChanged,
                                onSubmitted: onSubmitted,
                                decoration: InputDecoration(
                                  labelText: "Search for Users...",
                                  labelStyle: TextStyle(
                                      fontSize: 2.5.sp(context), color: white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(1.5.w(context)),
                                    borderSide: BorderSide(
                                      color: formFieldOutlineColor,
                                      width: 0.05.w(context),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(1.w(context)),
                                    borderSide: BorderSide(color: white),
                                  ),
                                ),
                                cursorColor: red,
                                style: TextStyle(
                                  fontSize: 3.sp(context),
                                  color: Colors.white,
                                ),
                              );
                            },
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
                            },
                            menuDecoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius:
                                    BorderRadius.circular(1.w(context))),
                            menuMargin:
                                EdgeInsets.fromLTRB(0, 10, 20.w(context), 0),
                            menuMaxHeight: 10.w(context),
                            listClipBehavior: Clip.none,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),

                    SizedBox(height: 25),
                    //
                    // Estimated Time to Completion
                    Row(
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "Estimated Time to Completion",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 4.sp(context),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          " *",
                          style: TextStyle(
                              color: red,
                              fontSize: 4.sp(context),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
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
                            value: rolesNeededValue,
                            onChanged: (selectedValue) {
                              setState(() {
                                rolesNeededValue = selectedValue;
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
                    //
                    // Submit
                    Row(
                      children: [
                        Expanded(child: SizedBox()),
                        TactileButton(
                          onTap: () async {
                            final res = await createProjectPost();
                            print("Res: $res");
                            if (res == 1) {
                              router.pop();
                              if (!mounted) {
                                return;
                              }
                              showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: BlurryContainer(
                                          width: 30.w(context),
                                          height: 7.w(context),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Ionicons.checkmark_circle,
                                                  color: green,
                                                ),
                                                SizedBox(width: 1.w(context)),
                                                Text(
                                                  "Project Posted Successfully",
                                                  style: TextStyle(
                                                      fontSize: 5.sp(context),
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: white),
                                                ),
                                              ],
                                            ),
                                          )),
                                    );
                                  });
                              Future.delayed(Duration(seconds: 2))
                                  .then((_) => router.pop());
                            }
                          },
                          scale: 1.08,
                          child: GradientContainer(
                            height: 3.w(context),
                            width: 7.w(context),
                            text: "Submit",
                            textSize: 2.5.sp(context),
                            gradient1: pink,
                            gradient2: red,
                            neonGlow: pink,
                            borderColor: tran,
                            borderRadius: 10.w(context),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
