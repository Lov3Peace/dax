import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/desktop_projects_page.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/estimatedTimeToCompletionLists.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectRolesList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/routes/go_routes.dart';
import 'package:flutter_application_1/responsive/desktop/util/carbonSearchBox.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/providers/projectProvider.dart';
import 'package:flutter_application_1/util/providers/userProvider.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:ionicons/ionicons.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:http/browser_client.dart' as httpClient;
import 'package:provider/provider.dart';

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
  var etcUnitsValue;
  var etcValuesValue;
  List rolesNeeded = [];
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
  // Initial Teammates List
  List<String> teammates = [];
  List<String> teammateOptionsList = [];
  List users = [];
  bool searching = true;
  String searchVal = "";
  final client = httpClient.BrowserClient()..withCredentials = true;
  bool successfulPost = false;
  final rolesController = MultiSelectController<String>();
  Future createProjectPost() async {
    try {
      final createProjectEndpoint = Uri.parse("$hostname/api/createNewProject");
      final title = _projectTitleController.text;
      final description = _projectDescriptionController.text;
      final category = _projectCategoryValue.toString();
      final acceptanceCriteria = _acceptanceCriteriaController.text;
      final etc = etcValuesValue.toString() + " " + etcUnitsValue.toString();
      // User Provider to get username
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      // Project Provider to get values of teammates and roles needed
      var projectProvider =
          Provider.of<ProjectProvider>(context, listen: false);

      // Error Message Builder for Missing Fields
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

      projectData.addAll({
        "username": userProvider.username,
        "title": title,
        "category": category,
        "description": description,
        "acceptance_criteria": acceptanceCriteria,
        "is_public": isPublic,
        "is_group": isGroupProject,
        "etc": etc,
        "teammates": [],
        "roles_needed": [],
        "images": []
      });

      // Populate lists if not empty
      if (projectProvider.images.isNotEmpty) {
        // debugPrint("Images Added: ${projectProvider.teammates}");
        projectData["images"] = projectProvider.images;
      }
      if (projectProvider.teammates.isNotEmpty) {
        // debugPrint("Teammates Added: ${projectProvider.teammates}");
        projectData["teammates"] = projectProvider.teammates;
      }
      if (projectProvider.rolesNeeded.isNotEmpty) {
        // debugPrint("Roles Added: ${projectProvider.rolesNeeded}");
        projectData["roles_needed"] = projectProvider.rolesNeeded;
      }

      // debugPrint("Project Data Request: $projectData");
      final res = await client.post(createProjectEndpoint,
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(projectData));
      final resStatus = res.statusCode;
      final resBody = res.body;
      if (resStatus == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Unable to post project: $e");
    }
  }

  // Fetch Users Future to get users from database (used in CarbonSearchBox)
  Future _fetchUsers(searchString) async {
    // debugPrint("Users before setState fetch: $users");
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
      users = body;
      // debugPrint("Users after setState fetch: $users");
      return users;
    } catch (e) {
      // debugPrint("Could not fetch users: $e");
    }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlurryContainer(
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
                            fontSize: 7.sp(context),
                            fontWeight: FontWeight.w700),
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
                            borderSide: const BorderSide(color: white),
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
                              borderRadius: BorderRadius.all(
                                  Radius.circular(1.w(context))),
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
                            borderSide:
                                const BorderSide(color: white, width: 1),
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
                            borderSide:
                                const BorderSide(color: white, width: 1),
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
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          TactileButton(
                            scale: 1.05,
                            onTap: () {
                              setState(() {
                                teammates.clear();
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
                          const SizedBox(width: 25),
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
                            CarbonSearchBox(
                              fetchFunction: _fetchUsers,
                              initialList: teammates,
                              labelText: "Search for users...",
                              parameter: "username",
                              searchController: _teammatesSearchController,
                              optionsMenuWidth: 30.w(context),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),
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
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          DropdownButton2(
                            items: etcValues,
                            value: etcValuesValue,
                            style: TextStyle(
                                fontSize: 3.sp(context), color: white),
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
                          const SizedBox(width: 20),
                          DropdownButton2(
                            items: etcUnits,
                            value: etcUnitsValue,
                            style: TextStyle(
                                fontSize: 3.sp(context), color: white),
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

                      const SizedBox(height: 25),
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
                      const SizedBox(height: 20),
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
                          const SizedBox(width: 25),
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
                      //
                      // Roles Needed
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
                            MultiDropdown<String>(
                              items: projectRoles,
                              controller: rolesController,
                              fieldDecoration: FieldDecoration(
                                  hintText: "Select Roles",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(1.w(context)),
                                    borderSide: BorderSide(
                                        color: formFieldOutlineColor),
                                  )),
                              searchEnabled: true,
                              selectedItemBuilder: (item) {
                                return TactileButton(
                                  child: Chip(
                                    label: Text(item.value),
                                    deleteIcon: Icon(Icons.close),
                                    onDeleted: () {
                                      rolesController.unselectWhere(
                                          (selectedItem) =>
                                              selectedItem.value == item.value);
                                    },
                                    mouseCursor: SystemMouseCursors.click,
                                    backgroundColor: Colors.grey.shade800,
                                    shape: const StadiumBorder(
                                      side: BorderSide(
                                        color: tran,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              chipDecoration:
                                  ChipDecoration(backgroundColor: red),
                              onSelectionChange: (selectedItems) {
                                var projectProvider =
                                    Provider.of<ProjectProvider>(context,
                                        listen: false);
                                projectProvider.saveRolesNeeded(selectedItems);

                                // debugPrint('Selected: $selectedItems');
                              },
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      //
                      // Submit
                      Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          TactileButton(
                            onTap: () async {
                              // res returns a boolean based on if the db write was successful
                              final res = await createProjectPost();

                              // guarding against passing context across async gap
                              if (!mounted) return;
                              if (!res) {
                                //Error on Insert
                                showDialog(
                                    barrierDismissible: true,
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: BlurryContainer(
                                            width: 42.w(context),
                                            height: 9.w(context),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.error,
                                                    color: red,
                                                  ),
                                                  SizedBox(width: 1.w(context)),
                                                  Text(
                                                    "There was an error posting the project :(",
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
                              } else {
                                // Successfully Inserted
                                router.pop();
                                final projectProvider =
                                    context.read<ProjectProvider>();
                                projectProvider.clearData();
                                showDialog(
                                    barrierDismissible: true,
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: BlurryContainer(
                                            width: 42.w(context),
                                            height: 9.w(context),
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
      ),
    );
  }

  @override
  void dispose() {
    teammates.clear();
    rolesNeeded.clear();
    super.dispose();
  }
}
