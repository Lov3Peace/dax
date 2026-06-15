import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/util/ui/gradient_label.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/providers/projectProvider.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:optimized_search_field/base_multi_search_field.dart';
import 'package:http/browser_client.dart' as httpClient;
import 'package:provider/provider.dart';

class CarbonSearchBox extends StatefulWidget {
  const CarbonSearchBox(
      {super.key,
      required this.fetchFunction,
      required this.initialList,
      required this.labelText,
      required this.parameter,
      required this.searchController,
      required this.optionsMenuWidth,
      this.endpoint});
  final Future Function(String) fetchFunction;
  final List<String> initialList;
  final String labelText;
  final String parameter;
  final TextEditingController searchController;
  final String? endpoint;
  final double optionsMenuWidth;

  @override
  State<CarbonSearchBox> createState() => _CarbonSearchBoxState();
}

List<String> selectedOptions = [];

class _CarbonSearchBoxState extends State<CarbonSearchBox> {
  late FocusNode optionsNode;
  FocusNode _textFieldFocusNode = FocusNode();
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
          var res = await widget.fetchFunction(textEditingValue.text);
          if (!mounted) return [];
          setState(() {
            searching = false;
            optionsList.clear();
          });
          for (var result in res) {
            if (!optionsList.contains(result[widget.parameter]) &&
                !selectedOptions.contains(result[widget.parameter])) {
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
      focusNode: _textFieldFocusNode,
      // The scroll controller for the options list
      listController: _scrollController,
      selectedWidget: (user) => TactileButton(
        scale: 1.07,
        // Remove the selected option on tap
        onTap: () => setState(() {
          selectedOptions.remove(user);
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
        isHighlighted = index == highlightIndex ? true : false;
        highlightedColor = isHighlighted ? Colors.grey.shade800 : tran;

// We create a FocusNode for the textFieldKey(thankfully this is a parameter of the widget
// to get access to the onKeyEvent() function. We must return a KeyEventResult for each
// scenario. This is to give the ability to use arrow keys to cycle through the options.
// This will be turned into its own widget.
        optionsNode = Focus.of(textFieldKey.currentContext!);

        optionsNode.onKeyEvent = (node, event) {
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
          width: widget.optionsMenuWidth,
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(1.w(context)),
          ),
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
        // This takes whatever you click on (selectedItem) and changes optionsList
        // to that (so like optionsList = [l3x]). Then it appends
        // optionsList to selectedOptions. Not sure why it works this way but
        // it does. So, we use one variable (optionSelected) and adjust it to be the
        // option that is highlighted when user presses Enter (optionsList[highlightIndex])
        //or the option that is clicked (optionsList[0])
        // var tolLen = optionsList.length;
        // var optionSelected = optionsList[
        //     0]; // default val is the first index
        // if (tolLen != 1) {
        // only change to the highlightIndex if tol_len != 1 (tol_len only == 1
        // if you click on the option...not sure why)
        setState(() {
          var optionSelected = optionsList[highlightIndex];
          //this handles the CLICK
          if (optionsNode.hasFocus &&
              optionsList.contains(selectedItem) &&
              !selectedOptions.contains(selectedItem) &&
              !selectedOptions.contains(optionSelected)) {
            selectedOptions.add(selectedItem);
            optionsList.clear();
            //this else if handles the ENTER key
          } else if (optionsNode.hasFocus) {
            selectedOptions.add(optionSelected);
          }
          highlightIndex = 0;
        });
        var projectProvider = context.read<ProjectProvider>();
        projectProvider.saveTeammates(selectedOptions);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _textFieldFocusNode.requestFocus();
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
    print('SearchBox Disposed');
    super.dispose();
  }
}
