import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/util/FetchUsers.dart';
import 'package:flutter_application_1/util/providers/ConnectionsSocketIoProvider.dart';
import 'package:flutter_application_1/util/ui/pillButton.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/animation_mixin/animation_mixin.dart';
import '../../../../util/imports.dart';
import 'package:http/browser_client.dart' as httpClient;

class DevPage extends StatefulWidget {
  DevPage({super.key, this.submit, this.fetch});

  final void submit;
  final Future Function(String)? fetch;
  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> with AnimationMixin {
  // late ConnectionsProvider _connectionsProvider;
  final TextEditingController _searchController = TextEditingController();
  // late AnimationController _animationController =
  //     AnimationController(vsync: this);

  Iterable _userList = [];

  // List<String> _testUserList = [
  //   "l3x",
  //   "davonport",
  //   "goat",
  //   "port",
  //   "davon",
  //   "alex",
  //   "alexander"
  // ];

  List<String> _selectedOptions = [];
  Iterable<String> _optionsList = [];
  final FocusNode _focusNode = FocusNode();
  int highlightedIndex = 0;

  @override
  void initState() {
    super.initState();
    // _connectionsProvider = context.read<ConnectionsProvider>();
    // Attach a global key handler to the shared focus node.
    // It will catch Backspace and remove the last selected chip.
    _focusNode.onKeyEvent = (node, event) {
      if (event is KeyDownEvent &&
          event.logicalKey == LogicalKeyboardKey.backspace) {
        // Only act when the text field is empty to avoid interfering with normal deletion.
        if (_searchController.text.isEmpty && _selectedOptions.isNotEmpty) {
          setState(() {
            _selectedOptions.removeLast();
          });
          return KeyEventResult.handled;
        }
      }
      return KeyEventResult.ignored;
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebUiTemplate(
        title: "Test",
        button1: SizedBox(),
        button2: SizedBox(),
        button3: SizedBox(),
        child: Center(
          child: SizedBox(
            width: 30.w(context), // maybe make this a parameter
            height: 20.h(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RawAutocomplete<String>(
                  focusNode: _focusNode,
                  textEditingController: _searchController,
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController _,
                      FocusNode __,
                      void Function() onSubmitted) {
                    //
                    // The custom textfield
                    return TextField(
                      focusNode: _focusNode,
                      autofocus: true,
                      maxLines: 1,
                      cursorColor: red,
                      style: TextStyle(fontSize: 3.sp(context)),
                      controller: _searchController,
                      readOnly: _selectedOptions.length >
                          2, // disable typing once _selectedOptions length hits 3 (they can still click Submit)
                      decoration: InputDecoration(
                        // Only need to put padding on prefixIcon since it also affects the suffixIcon
                        prefixIcon: Padding(
                          padding: EdgeInsetsDirectional.all(
                              max(10, 0.5.w(context))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Show search icon if no selections have been made and hide otherwise
                              if (_selectedOptions.isEmpty)
                                Icon(
                                  Icons.search,
                                  size: max(35, 0.5.w(context)),
                                ),
                              // Put selections to the left of the cursor in the textfield and hide otherwise
                              if (_selectedOptions.isNotEmpty)
                                SizedBox(
                                  height:
                                      8.sp(context), // make this a parameter
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: _selectedOptions.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: 0.5.w(context)),
                                        child: PillButton(
                                          text: _selectedOptions[index],
                                          width: 7.w(context),
                                          color1: deckBackgroundColor,
                                          color2: deckColor,
                                          horizontalPadding: 1.w(context),
                                          onTap: () {
                                            setState(() {
                                              _searchController.clear();
                                              _selectedOptions.removeAt(index);
                                              _focusNode.requestFocus();
                                            });
                                          },
                                          borderRadius: 50.w(context),
                                          borderColor: deckBorderColor,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 1.w(context)),
                          child: PillButton(
                              onTap: () => widget.submit,
                              text: "Submit",
                              width: 7.w(context),
                              horizontalPadding: 1.w(context),
                              borderRadius: 50.w(context),
                              borderColor: tran,
                              color1: pink,
                              color2: red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1.5.w(context)),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(151, 255, 255, 255),
                              width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1.w(context)),
                          borderSide: const BorderSide(color: white, width: 1),
                        ),
                      ),
                      onChanged: (input) async {
                        if (input.isEmpty) return;
                        final res = await fetchUsers(input);
                        setState(() {
                          _userList = res;
                        });
                        print("onchanged _userList: $_userList");
                      },
                      onSubmitted: (selection) {
                        if (_searchController.text.isEmpty) return;
                        setState(() {
                          _selectedOptions
                              .add(_optionsList.elementAt(highlightedIndex));
                          _searchController.clear();
                          _focusNode.requestFocus();
                        });
                      },
                    );
                  },
                  // // The logic for how the options drowdown should look
                  optionsViewBuilder: (
                    BuildContext context,
                    AutocompleteOnSelected<String> onSelected,
                    Iterable<String> options,
                  ) {
                    return Padding(
                      padding: EdgeInsets.only(top: max(5, 0.5.w(context))),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            max(10, 0.5.w(context)),
                          ),
                          color: deckBackgroundColor,
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: options.length,
                            // padding: EdgeInsetsDirectional.all(
                            //     max(10, 1.w(context))),
                            itemBuilder: (context, index) {
                              int localHighlightedIndex =
                                  AutocompleteHighlightedOption.of(context);
                              highlightedIndex = localHighlightedIndex;
                              bool isHighlighted =
                                  localHighlightedIndex == index;
                              return Container(
                                padding: EdgeInsetsGeometry.all(1.w(context)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      max(10, 0.5.w(context))),
                                  color: isHighlighted
                                      ? darkGrey.withValues(alpha: 0.2)
                                      : tran,
                                ),
                                child: TactileButton(
                                  scale: 1.01,
                                  onTap: () {
                                    _searchController.clear();
                                    if (!_selectedOptions
                                        .contains(options.elementAt(index))) {
                                      onSelected(options.elementAt(index));
                                    }
                                  },
                                  child: Text(options.elementAt(index)),
                                ),
                              );
                            }),
                      ),
                    );
                  },
                  // The logic for building the options dropdown list
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return [];
                    }

                    // Show users that match the search query and are not in the _selectedOptions list once the search is at least 2 characters
                    // (smaller read on DB)
                    List<String> usernames = [];
                    for (var user in _userList) {
                      usernames.add(user["username"]); // ..add
                    }
                    _optionsList = usernames.where((user) =>
                        textEditingValue.text.length > 1 &&
                        user.startsWith(textEditingValue.text.toLowerCase()) &&
                        !_selectedOptions.contains(user));
                    return _optionsList;
                  },
                  // On select (mouse click) add the selection _selectedOptions and clear the search box
                  onSelected: (selection) {
                    setState(() {
                      _selectedOptions.add(selection);
                      _searchController.clear();
                      _focusNode.requestFocus();
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
