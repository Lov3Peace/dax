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

  List<String> _userList = ["l3x", "davonport", "goat", "port"];
  List<String> _selectedOptions = [];
  FocusNode _focusNode = FocusNode();

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
                            if (_selectedOptions.isEmpty)
                              Padding(
                                padding:
                                    EdgeInsets.all(max(10, 0.5.w(context))),
                                child: const Icon(Icons.search),
                              ),
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
                          _searchController.clear();
                          _selectedOptions.add(selection);
                        });
                      },
                    );
                  },
                  // displayStringForOption: (user) => "HELLO",
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
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: max(5, 0.25.w(context))),
                                child: TactileButton(
                                  scale: 1.01,
                                  onTap: () {
                                    _searchController.clear();
                                    if (!_selectedOptions
                                        .contains(options.elementAt(index)))
                                      onSelected(options.elementAt(index));
                                  },
                                  child: Text(options.elementAt(index)),
                                ),
                              );
                            }),
                      ),
                    );
                  },
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return [];
                    }

                    return _userList.where((user) =>
                        user.contains(textEditingValue.text.toLowerCase()) &&
                        !_selectedOptions.contains(user));
                  },
                  onSelected: (selection) {
                    setState(() {
                      _searchController.clear();
                      _selectedOptions.add(selection);
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
