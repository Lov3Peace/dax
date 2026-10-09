import 'dart:convert';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectsList.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/util/carbonSearchBox.dart';
import 'package:flutter_application_1/responsive/desktop/util/large_stagger_load.dart';
import 'package:flutter_application_1/responsive/desktop/util/test_web_ui_template.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/util/providers/ConnectionsSocketIoProvider.dart';
import 'package:flutter_application_1/util/ui/pillButton.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../../../../util/imports.dart';
import 'package:http/browser_client.dart' as httpClient;

class DevPage extends StatefulWidget {
  DevPage({super.key});

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  late ConnectionsProvider _connectionsProvider;
  bool showUserSearch = false;
  List users = [];
  List<String> _connectionsRequestList = [];
  final TextEditingController _teammatesSearchController =
      TextEditingController();
  final FocusNode _userSearchFocusNode = FocusNode();
  final client = httpClient.BrowserClient()..withCredentials = true;
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
  void initState() {
    super.initState();
    _connectionsProvider = context.read<ConnectionsProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return WebUiTemplate(
      title: "Dev",
      button1: CommunitiesButton(),
      button2: SocialsButton(),
      button3: NewsButton(),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 7.sp(context),
              ),
            ),
            Visibility(
              visible: showUserSearch,
              child: TactileButton(
                onTap: () {
                  setState(() {
                    showUserSearch = false;
                  });
                },
                child: Container(
                    padding: EdgeInsets.all(0.5.w(context)),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: deckBorderColor)),
                    child: Icon(
                      Icons.close,
                      size: 1.5.w(context),
                    )),
              ),
            ),
            SizedBox(width: max(10, 1.w(context))),
            TactileButton(
              scale: showUserSearch ? 1.0 : 1.01,
              onTap: () {
                setState(() {
                  showUserSearch = true;
                });
              },
              child: AnimatedContainer(
                width: showUserSearch ? 25.w(context) : 12.w(context),
                height: 3.w(context),
                duration: 300.milliseconds,
                // padding: EdgeInsets.symmetric(
                //     horizontal: 1.w(context), vertical: 0.5.w(context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.w(context)),
                  color: showUserSearch ? tran : deckBackgroundColor,
                ),
                child: Center(
                  child: Stack(
                    children: [
                      Visibility(
                        visible: !showUserSearch,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: max(5, 0.5.w(context)),
                          children: [
                            Icon(
                              Ionicons.person_add,
                              size: max(10, 1.25.w(context)),
                            ),
                            Text("Add Connection"),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: showUserSearch,
                        child: CarbonSearchBox(
                          textfieldNode: _userSearchFocusNode,
                          fetchFunction: _fetchUsers,
                          initialList: _connectionsRequestList,
                          labelText: "Search for users...",
                          parameter: "username",
                          searchController: _teammatesSearchController,
                          optionsMenuWidth: 30.w(context),
                          saveUserList: _connectionsProvider
                              .saveUserList(_connectionsRequestList),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: max(10, 1.w(context)),
            ),
            Visibility(
              visible: showUserSearch,
              child: PillButton(
                onTap: () {},
                borderRadius: 50.w(context),
                borderColor: tran,
                height: 3.w(context),
                width: 7.w(context),
                color1: pink,
                color2: red,
                child: Text("Connect"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
