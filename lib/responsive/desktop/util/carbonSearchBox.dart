import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/providers/userProvider.dart';
import 'package:flutter_application_1/util/ui/pillButton.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:provider/provider.dart';

class CarbonSearchBox extends StatefulWidget {
  CarbonSearchBox({
    super.key,
    required this.fetch,
    required this.selectedOptions,
    required this.submitButtonWidth,
    required this.listViewHeight,
    this.submit,
    this.textStyle,
    this.chipWidth,
    this.labelText,
  });
  final Future Function(String) fetch;
  final List selectedOptions;
  final double submitButtonWidth;
  final double listViewHeight;
  final VoidCallback? submit;
  final TextStyle? textStyle;
  final double? chipWidth;
  final String? labelText;

  @override
  State<CarbonSearchBox> createState() => _CarbonSearchBoxState();
}

class _CarbonSearchBoxState extends State<CarbonSearchBox> {
  // late ConnectionsProvider _connectionsProvider;
  late UserProvider _userProvider;
  final TextEditingController _searchController = TextEditingController();
  Iterable _userList = [];
  Iterable<String> _optionsList = [];
  final FocusNode _focusNode = FocusNode();
  int highlightedIndex = 0;
  // late AnimationController _animationController =
  //     AnimationController(vsync: this);

  // List<String> _testUserList = [
  //   "l3x",
  //   "davonport",
  //   "goat",
  //   "port",
  //   "davon",
  //   "alex",
  //   "alexander"
  // ];

  @override
  void initState() {
    super.initState();
    // _connectionsProvider = context.read<ConnectionsProvider>();
    _userProvider = context.read<UserProvider>();
    // Attach a global key handler to the shared focus node.
    // It will catch Backspace and remove the last selected chip.
    _focusNode.onKeyEvent = (node, event) {
      if (event is KeyDownEvent &&
          event.logicalKey == LogicalKeyboardKey.backspace) {
        // Only act when the text field is empty to avoid interfering with normal deletion.
        if (_searchController.text.isEmpty &&
            widget.selectedOptions.isNotEmpty) {
          setState(() {
            widget.selectedOptions.removeLast();
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
    return RawAutocomplete<String>(
      focusNode: _focusNode,
      textEditingController: _searchController,
      fieldViewBuilder: (BuildContext context, TextEditingController _,
          FocusNode __, void Function() onSubmitted) {
        //
        // The custom textfield
        return TextField(
          focusNode: _focusNode,
          autofocus: true,
          maxLines: 1,
          cursorColor: red,
          style: widget.textStyle,
          controller: _searchController,
          readOnly: widget.selectedOptions.length >
              2, // disable typing once _selectedOptions length hits 3 (they can still click Submit)
          decoration: InputDecoration(
            // Only need to put padding on prefixIcon since it also affects the suffixIcon
            labelText: widget.labelText,
            labelStyle:
                TextStyle(fontSize: max(12, 2.sp(context)), color: grey),
            prefixIcon: Padding(
              padding: EdgeInsetsDirectional.all(max(10, 0.5.w(context))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Show search icon if no selections have been made and hide otherwise
                  if (widget.selectedOptions.isEmpty)
                    Icon(
                      Icons.search,
                      size: 1.5.w(context),
                    ),
                  // Put selections to the left of the cursor in the textfield and hide otherwise
                  if (widget.selectedOptions.isNotEmpty)
                    SizedBox(
                      height: widget.listViewHeight, // make this a parameter
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.selectedOptions.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 0.5.w(context)),
                            child: PillButton(
                              text: widget.selectedOptions[index],
                              textStyle:
                                  TextStyle(fontSize: max(12, 2.sp(context))),
                              width: widget.chipWidth ?? 7.w(context),
                              color1: deckBackgroundColor,
                              color2: deckColor,
                              horizontalPadding: 1.w(context),
                              onTap: () {
                                setState(() {
                                  _searchController.clear();
                                  widget.selectedOptions.removeAt(index);
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
            suffixIcon: widget.submit != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.w(context), vertical: 0.25.w(context)),
                    child: PillButton(
                        onTap: widget.submit ?? () {},
                        text: "Submit",
                        textStyle: TextStyle(fontSize: max(12, 2.sp(context))),
                        width: widget.submitButtonWidth,
                        horizontalPadding: 1.w(context),
                        borderRadius: 50.w(context),
                        borderColor: tran,
                        color1: red,
                        color2: pink),
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1.5.w(context)),
              borderSide: const BorderSide(
                  color: Color.fromARGB(151, 255, 255, 255), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1.w(context)),
              borderSide: BorderSide(color: grey, width: 1),
            ),
          ),
          onChanged: (input) async {
            if (input.isEmpty) return;
            final res = await widget.fetch(input);
            setState(() {
              _userList = res;
            });
            // print("onchanged _userList: $_userList");
          },
          onSubmitted: (selection) {
            if (_searchController.text.isEmpty) return;
            setState(() {
              widget.selectedOptions
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
                  bool isHighlighted = localHighlightedIndex == index;
                  return Container(
                    padding: EdgeInsetsGeometry.all(1.w(context)),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(max(10, 0.5.w(context))),
                      color: isHighlighted
                          ? darkGrey.withValues(alpha: 0.2)
                          : tran,
                    ),
                    child: TactileButton(
                      scale: 1.01,
                      onTap: () {
                        _searchController.clear();
                        if (!widget.selectedOptions
                            .contains(options.elementAt(index))) {
                          onSelected(options.elementAt(index));
                        }
                      },
                      child: Text(
                        options.elementAt(index),
                        style: TextStyle(fontSize: max(12, 2.5.sp(context))),
                      ),
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
            !widget.selectedOptions.contains(user) &&
            !user.contains(_userProvider.username));
        return _optionsList;
      },
      // On select (mouse click) add the selection _selectedOptions and clear the search box
      onSelected: (selection) {
        setState(() {
          widget.selectedOptions.add(selection);
          _searchController.clear();
          _focusNode.requestFocus();
        });
      },
    );
  }
}
