import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/auth/registerForm.dart';
import 'package:flutter_application_1/util/providers/userProvider.dart';
import 'package:flutter_application_1/util/ui/CarbonCircleAvatar.dart';
import 'package:flutter_application_1/util/ui/gradient_label.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/providers/projectProvider.dart';
import 'package:flutter_application_1/util/ui/pillButton.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:optimized_search_field/base_multi_search_field.dart';
import 'package:http/browser_client.dart' as httpClient;
import 'package:provider/provider.dart';

class CarbonSearchBox extends StatefulWidget {
  CarbonSearchBox(
      {super.key,
      required this.fetchFunction,
      required this.initialList,
      required this.labelText,
      required this.parameter,
      required this.searchController,
      required this.optionsMenuWidth,
      required this.saveUserList,
      required this.textfieldNode,
      this.endpoint});
  final Future Function(String) fetchFunction;
  final List<String> initialList;
  final String labelText;
  final String parameter;
  final TextEditingController searchController;
  final String? endpoint;
  final double optionsMenuWidth;
  final FocusNode textfieldNode;
  void Function(List options) saveUserList;

  @override
  State<CarbonSearchBox> createState() => _CarbonSearchBoxState();
}

List<String> selectedOptions = [];

class _CarbonSearchBoxState extends State<CarbonSearchBox> {
  FocusNode optionsNode = FocusNode();
  var searchItemsList = [];
  Color highlightedColor = Colors.black87;
  final ScrollController _scrollController = ScrollController();
  int highlightIndex = 0;
  bool isHighlighted = false;
  final textFieldKey = GlobalKey();
  List<String> initialList = [];
  List<String> optionsList = [];
  var users;
  bool searching = true;
  Color formFieldOutlineColor = const Color.fromARGB(151, 255, 255, 255);
  bool selectedWithEnterKey = false;
  late UserProvider _userProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      optionsNode = Focus.of(textFieldKey.currentContext!);
      _userProvider = context.read<UserProvider>();
    });
    super.initState();
  }

  final client = httpClient.BrowserClient()..withCredentials = true;
  // Future _fetchUsers(searchString) async {
  //   print("Users before setState fetch: $users");
  //   try {
  //     String endpoint = widget.endpoint!;
  //     final getUsersEndpoint =
  //         Uri.parse("$hostname/api/$endpoint?searchString=$searchString");
  //     final res = await client.get(
  //       getUsersEndpoint,
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //     );
  //     final body = jsonDecode(res.body);
  //     users = body;
  //     print("Users after setState fetch: $users");
  //     return users;
  //   } catch (e) {
  //     print("COULDNT EEN DO IT: $e");
  //   }
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return BaseMultiSearchField<String>(
      dropDownList: widget.initialList,
      values: selectedOptions,
      item: (user) => Text(user),
      textFieldKey: textFieldKey,

      labelText: widget.labelText,
      labelTextStyle: TextStyle(fontSize: 2.5.sp(context)),

      showErrorText: true,
      controller: widget.searchController,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return [];
        }
        if (textEditingValue.text.length > 1) {
          // This is the Fetch. Only begin fetch on second character to narrow the scope
          // of the search
          var res = await widget.fetchFunction(textEditingValue.text);
          if (!mounted) return [];
          setState(() {
            searching = false;
            highlightIndex = 0;
            optionsList.clear();
          });
          for (var result in res) {
            if (!optionsList.contains(result[widget.parameter]) &&
                !selectedOptions.contains(result[widget.parameter]) &&
                result[widget.parameter] != _userProvider.username) {
              setState(() {
                optionsList.add(result[widget.parameter]);
              });
            }
          }

          return optionsList;
        }
        return [];
      },
      getItemText: (text) {
        if (optionsList.contains(text)) {
          return text;
        }
        return "";
      },
      focusNode: widget.textfieldNode,
      // The scroll controller for the options list
      listController: _scrollController,
      selectedWidget: (user) => PillButton(
        onTap: () => setState(() {
          selectedOptions.remove(user);
        }),
        borderColor: deckBorderColor,
        color1: tran,
        color2: tran,
        padding: EdgeInsets.symmetric(
            vertical: max(5, 0.5.w(context)),
            horizontal: max(10, 1.w(context))),
        borderRadius: 10.w(context),
        child: Text(
          user,
          style: TextStyle(fontSize: 2.5.sp(context)),
        ),
      ),
      listButtonItem: (
          {required index,
          required isEnabled,
          key,
          required onPressed,
          required value}) {
        isHighlighted = index == highlightIndex ? true : false;
        highlightedColor =
            isHighlighted ? Color.fromRGBO(50, 50, 50, 0.5) : tran;

// We create a FocusNode for the textFieldKey(thankfully this is a parameter of the widget
// to get access to the onKeyEvent() function. We must return a KeyEventResult for each
// scenario. This is to give the ability to use arrow keys to cycle through the options.
// This will be turned into its own widget.

        optionsNode.onKeyEvent = (node, event) {
          print(
              "Entered optionsNode.onKeyEvent() selectedWithEnterKey: $selectedWithEnterKey");
          if (value.isNotEmpty) {
            // optionsNode.requestFocus();
            // DOWN ARROW
            if (event is KeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.arrowDown &&
                highlightIndex < optionsList.length - 1) {
              if (highlightIndex != 0) {
                _scrollController.animateTo(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    _scrollController.offset +
                        3.5
                            .w(context) // Height of one item in search results
                            .clamp(0.0,
                                _scrollController.position.maxScrollExtent));
              }
              setState(() {
                highlightIndex++;
                _scrollController;
              });
              return KeyEventResult.handled;
            }
            // DOWN ARROW UPPER LIMIT
            if (event is KeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.arrowDown &&
                highlightIndex >= optionsList.length - 1) {
              setState(() {
                highlightIndex = optionsList.length - 1;
              });
              return KeyEventResult.handled;
            }
            // UP ARROW
            if (event is KeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.arrowUp &&
                highlightIndex > 0) {
              _scrollController.animateTo(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  (_scrollController.offset - 3.5.w(context))
                      .clamp(0.0, _scrollController.position.maxScrollExtent));
              setState(() {
                highlightIndex--;
              });
              return KeyEventResult.handled;
            }
            // UP ARROW LOWER LIMIT
            if (event is KeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.arrowUp &&
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

        // Tracking Enter key on _textFieldFocusNode. optionsNode can't track it
        widget.textfieldNode.onKeyEvent = (node, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.enter) {
            setState(() {
              selectedWithEnterKey = true;
            });

            print("KeyDownEvent selectedWithEnterKey: $selectedWithEnterKey");
          }
          // Ignore the result so that the node can process the onSubmitted function
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
          scale: 1.01,
          onTap: onPressed,
          // child: GradientContainer(
          //     height: 3.w(context),
          //     width: 6.w(context),
          //     text: value,
          //     textSize: 3.sp(context),
          //     gradient1: highlightedColor,
          //     gradient2: highlightedColor,
          //     neonGlow: tran,
          //     borderColor: tran,
          //     borderRadius: 0.w(context)),
          child: Container(
            color: highlightedColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: max(5, 1.w(context))),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CarbonCircleAvatar(),
                  const SizedBox(width: 15),
                  Text(value),
                  const Spacer(),
                  const Text("Online", style: TextStyle(color: green)),
                ],
              ),
            ),
          ),
        );
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

        return BlurryContainer(
          width: widget.optionsMenuWidth,
          child: ListView.builder(
            itemCount: length,
            controller: _scrollController,
            itemBuilder: (context, index) => item(index),
          ),
        );
      },
      removeEvent: (removedItem) => setState(() {
        selectedOptions.remove(removedItem);
      }),
      onSelected: (selectedItem) {
        if (selectedOptions.length > 3) {
          showErrorMessage("Maximum users reached.", context);
          return;
        }
        String optionHilighted = optionsList[highlightIndex];

        // Adds user to selectedOptions list if enter key was pressed for selection
        if (selectedWithEnterKey) {
          setState(() {
            selectedOptions.add(optionHilighted);
          });
        }

        // Adds user to selectedOptions if a user clicked on an item in the options list
        if (optionsNode.hasFocus && !selectedWithEnterKey) {
          setState(() {
            selectedOptions.add(selectedItem);
          });
        }
        // Passes the selectedOptions as an argument so we can use it in whatever Provider function we want
        widget.saveUserList(selectedOptions);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          optionsList.clear();
          widget.textfieldNode.requestFocus();
          setState(() {
            highlightIndex = 0;
            selectedWithEnterKey = false;
          });
        });
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
        return TextField(
          key: textFieldKey,
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(fontSize: 2.5.sp(context), color: white),
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
          borderRadius: BorderRadius.circular(1.w(context))),
      menuMargin: EdgeInsets.fromLTRB(0, 10, 20.w(context), 0),
      menuMaxHeight: 10.w(context),
      listClipBehavior: Clip.none,
    );
  }

  @override
  void dispose() {
    selectedOptions.clear();
    super.dispose();
  }
}
