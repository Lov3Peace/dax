import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/util/providers/ConnectionsSocketIoProvider.dart';
import 'package:flutter_application_1/util/ui/pillButton.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/animation_mixin/animation_mixin.dart';
import '../../../../util/imports.dart';
import 'package:http/browser_client.dart' as httpClient;

class DevPage extends StatefulWidget {
  DevPage({super.key});

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> with AnimationMixin {
  late ConnectionsProvider _connectionsProvider;
  bool showUserSearch = false;
  List _users = [];
  List<String> _connectionsRequestList = [];
  final TextEditingController _searchController = TextEditingController();
  final client = httpClient.BrowserClient()..withCredentials = true;
  late AnimationController _animationController =
      AnimationController(vsync: this);

  List<String> _userList = [
    "l3x",
    "davonport",
    "goat",
    "port",
    "davon",
    "alex",
    "alexander"
  ];
  List<String> _selectedOptions = [];
  Iterable<String> _optionsList = [];
  FocusNode _focusNode = FocusNode();
  int highlightedIndex = 0;

  @override
  void initState() {
    super.initState();
    _connectionsProvider = context.read<ConnectionsProvider>();
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
            width: 30.w(context),
            height: 20.h(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RawAutocomplete<String>(
                  focusNode: _focusNode,
                  textEditingController: _searchController,
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController controller,
                      FocusNode focusNode,
                      void Function() onSubmitted) {
                    //
                    // The custom textfield
                    return TextField(
                      focusNode: _focusNode,
                      cursorColor: red,
                      style: TextStyle(fontSize: 3.sp(context)),
                      controller: _searchController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsetsDirectional.all(max(20, 1.w(context))),
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Show search icon if no selections have been made and hide otherwise
                            if (_selectedOptions.isEmpty)
                              Padding(
                                padding:
                                    EdgeInsets.all(max(10, 0.5.w(context))),
                                child: const Icon(Icons.search),
                              ),
                            // Put selections to the left of the cursor in the textfield and hide otherwise
                            if (_selectedOptions.isNotEmpty)
                              SizedBox(
                                height: max(35, 1.w(context)),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: _selectedOptions.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(left: 0.5.w(context)),
                                      child: PillButton(
                                        color1: deckBackgroundColor,
                                        color2: deckColor,
                                        padding:
                                            EdgeInsetsDirectional.symmetric(
                                                horizontal: 1.w(context),
                                                vertical: 0.25.w(context)),
                                        onTap: () {
                                          setState(() {
                                            controller.clear();
                                            _selectedOptions.removeAt(index);
                                            focusNode.requestFocus();
                                          });
                                        },
                                        borderRadius: 50.w(context),
                                        borderColor: deckBorderColor,
                                        child: Text(_selectedOptions[index]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
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
                      onSubmitted: (selection) {
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
                            padding: EdgeInsetsDirectional.all(
                                max(10, 1.w(context))),
                            itemBuilder: (context, index) {
                              int localHighlightedIndex =
                                  AutocompleteHighlightedOption.of(context);
                              highlightedIndex = localHighlightedIndex;
                              bool isHighlighted =
                                  localHighlightedIndex == index;
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: max(5, 0.25.w(context))),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        max(10, 0.5.w(context))),
                                    color: isHighlighted
                                        ? darkGrey
                                        : Colors.transparent,
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
                    _optionsList = _userList.where((user) =>
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
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
