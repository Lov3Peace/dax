import 'dart:convert';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/util/carbonSearchBox.dart';
import 'package:flutter_application_1/util/auth/registerForm.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/providers/ConnectionsSocketIoProvider.dart';
import 'package:flutter_application_1/util/providers/userProvider.dart';
import 'package:flutter_application_1/util/ui/pillButton.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:http/browser_client.dart' as httpClient;
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class AddConnectionButton extends StatefulWidget {
  const AddConnectionButton({super.key});

  @override
  State<AddConnectionButton> createState() => _AddConnectionButtonState();
}

class _AddConnectionButtonState extends State<AddConnectionButton> {
  List<String> _connectionsRequestList = [];
  bool showUserSearch = false;
  List users = [];
  final FocusNode _connectionRequestFocusNode = FocusNode();
  final TextEditingController _teammatesSearchController =
      TextEditingController();
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

  late ConnectionsProvider _connectionsProvider;
  late UserProvider _userProvider;

  @override
  void initState() {
    _connectionsProvider = context.read<ConnectionsProvider>();
    _userProvider = context.read<UserProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  size: max(25, 1.5.w(context)),
                )),
          ),
        ),
        SizedBox(width: max(10, 1.w(context))),
        TactileButton(
          scale: showUserSearch ? 1.0 : 1.01,
          onTap: () {
            setState(() {
              showUserSearch = true;
              _connectionRequestFocusNode.requestFocus();
            });
          },
          child: AnimatedContainer(
            width: showUserSearch
                ? max(300, 25.w(context))
                : max(150, 14.w(context)),
            // height: 3.w(context),
            duration: 500.milliseconds,
            curve: Curves.easeOutBack,
            // padding: EdgeInsets.symmetric(
            //     horizontal: 1.w(context), vertical: 0.5.w(context)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.w(context)),
              border:
                  Border.all(color: showUserSearch ? tran : deckBorderColor),
              color: tran,
            ),
            child: Center(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: max(15, 1.w(context)),
                        vertical: max(10, 0.75.w(context))),
                    child: Visibility(
                      visible: !showUserSearch,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: max(5, 0.5.w(context)),
                        children: [
                          Icon(
                            Ionicons.person_add,
                            size: max(10, 1.25.w(context)),
                          ),
                          Text(
                            "Add Connection",
                            style:
                                TextStyle(fontSize: max(12, 2.5.sp(context))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showUserSearch,
                    child: CarbonSearchBox(
                      textfieldNode: _connectionRequestFocusNode,
                      fetchFunction: _fetchUsers,
                      initialList: [],
                      labelText: "Search for users...",
                      parameter: "username",
                      searchController: _teammatesSearchController,
                      optionsMenuWidth: 30.w(context),
                      // userList is the selectedOptions that is only available in the CarbonSearchBox. So we pass it into
                      // the saveUserList callback to be used in the _connectionsProvider.saveUserList(userList) call
                      saveUserList: (userList) {
                        _connectionsProvider.saveUserList(userList);
                        print(_connectionsProvider.connectionRequestList);
                      },
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
            onTap: () {
              SocketIoClient.socket.emit("sendConnectionRequest", {
                "sender": _userProvider.username,
                "receivers": _connectionsProvider.connectionRequestList
              });
              setState(() {
                showUserSearch = false;
              });
              showErrorMessage("Connection Request Sent!", context);
            },
            borderRadius: 50.w(context),
            borderColor: tran,
            padding: EdgeInsets.symmetric(
                horizontal: max(10, 1.5.w(context)),
                vertical: max(5, 0.5.w(context))),
            color1: pink,
            color2: red,
            child: Text("Connect",
                style: TextStyle(fontSize: max(12, 2.5.sp(context)))),
          ),
        ),
      ],
    );
  }
}
