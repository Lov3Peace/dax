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
                Autocomplete<String>(
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController controller,
                      FocusNode focusNode,
                      void Function() onSubmitted) {
                    return TextField(
                      focusNode: focusNode,
                      cursorColor: red,
                      style: TextStyle(fontSize: 3.sp(context)),
                      controller: controller,
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          height: 50,
                          child: ListView.builder(
                              itemCount: _selectedOptions.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return PillButton(
                                    child: Text(_selectedOptions[index]),
                                    onTap: () {
                                      setState(() {
                                        _searchController.clear();
                                        _selectedOptions.removeAt(index);
                                      });
                                    },
                                    borderRadius: 50.w(context),
                                    borderColor: deckBorderColor);
                              }),
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
                    return ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          return TactileButton(
                            onTap: () {
                              _searchController.clear();
                              onSelected(options.elementAt(index));
                            },
                            child: Container(
                                padding:
                                    EdgeInsetsDirectional.all(0.5.w(context)),
                                color: deckBackgroundColor,
                                child: Text(options.elementAt(index))),
                          );
                        });
                  },
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return [];
                    }
                    return _userList.where((user) =>
                        user.contains(textEditingValue.text.toLowerCase()));
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
