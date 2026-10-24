import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/connections/AddConnectionButton.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/desk_dock_button_templates/sp_card_template.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/providers/ConnectionsSocketIoProvider.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../../../util/providers/userProvider.dart';
import '../../../desk_decks.dart';
import '../desk_dock_button_templates/messages_template.dart';
import 'actions_buttons.dart';
import 'desk_connection_tactile.dart';
import 'package:flutter_application_1/main.dart';

class ConnectionsPopUp extends StatefulWidget {
  const ConnectionsPopUp({super.key});

  @override
  State<ConnectionsPopUp> createState() => ConnectionsPopUpState();
}

class ConnectionsPopUpState extends State<ConnectionsPopUp>
    with AnimationMixin {
  // Controls the text entered into the search field
  final TextEditingController searchController = TextEditingController();

  // Controls PageView changes programmatically
  final PageController pageController = PageController();

  // Tracks the currently selected tab / page
  int currentIndex = 0;

  // Handles tab button presses
  void handleButtonTap(int index) {
    setState(() {
      currentIndex = index;
    });

    pageController.animateToPage(
      index,
      duration: const Duration(
        milliseconds: 250,
      ),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> connectionPages = [];
  late ConnectionsProvider _connectionsProvider;
  late String currentUsername;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // User Provider
    currentUsername = context.watch<UserProvider>().username;
    // Connection Provider
    _connectionsProvider = context.watch<ConnectionsProvider>();

    // Each page represents a connection view
    // such as All Connections or Requests
    connectionPages = [
      //
      // All Connections
      CustomDataTable(
        headers: [
          'Username',
          'Status',
          'Last Seen',
          'Actions',
        ],
        rows: _connectionsProvider.connections.map((connection) {
          // Determine the Other User
          final username = connection.senderUsername == currentUsername
              ? connection.receiverUsername
              : connection.senderUsername;

          return [
            Text(
              username,
              style: TextStyle(
                fontSize: 2.5.sp(context),
              ),
            ),
            Text(
              'Connected',
              style: TextStyle(
                fontSize: 2.5.sp(context),
              ),
            ),
            Text(
              connection.timestamp.toString(),
              style: TextStyle(
                fontSize: 2.5.sp(context),
              ),
            ),
            const ActionsButtons(),
          ];
        }).toList(),
        fontSize: 2.5.sp(context),
        columnSpacing: 7.w(context),
        horizontalMargin: 7.w(context),
        topPadding: 1.h(context),
        decoration: BoxDecoration(
          color: deckBackgroundColor,
          borderRadius: BorderRadius.circular(
            1.w(context),
          ),
          border: Border.all(
            color: deckBorderColor,
          ),
        ),
      ),

      // Connection Requests
      CustomDataTable(
        headers: [
          'Username',
          'Status',
          'Time',
          'Actions',
        ],
        rows: _connectionsProvider.pendingRequests.map((request) {
          return [
            Text(
              request.senderUsername,
              style: TextStyle(
                fontSize: 2.5.sp(context),
              ),
            ),
            Text(
              request.status == 0 ? 'Pending' : 'Accepted',
              style: TextStyle(
                fontSize: 2.5.sp(context),
              ),
            ),
            Text(
              request.timestamp.toString(),
              style: TextStyle(
                fontSize: 2.5.sp(context),
              ),
            ),
            RequestActionButtons(
              onAccept: () {
                SocketIoClient.socket.emit(
                  "acceptConnection",
                  {
                    "requestId": request.requestId,
                    "username": request.receiverUsername,
                  },
                );
              },
              onReject: () {
                SocketIoClient.socket.emit(
                  "rejectConnection",
                  {
                    "requestId": request.requestId,
                    "username": request.receiverUsername,
                  },
                );
              },
            ),
          ];
        }).toList(),
        fontSize: 2.5.sp(context),
        columnSpacing: 7.w(context),
        horizontalMargin: 7.w(context),
        topPadding: 1.h(context),
        decoration: BoxDecoration(
          color: const Color.fromARGB(
            70,
            32,
            32,
            40,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: deckBorderColor,
          ),
        ),
      ),
    ];
    return SPCardTemplate(
      height: 100.h(context),
      width: 71.w(context),
      borderColor: deckBorderColor,
      child: Padding(
        padding: EdgeInsets.all(
          1.5.w(context),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                // Popup Title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Connections",
                    style: TextStyle(
                      fontSize: 7.sp(context),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Expanded(child: AddConnectionButton()),
              ],
            ),

            // Search Field
            Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                max(10, 1.w(context)),
                0,
                max(10, 1.w(context)),
              ),
              child: TextField(
                cursorColor: red,
                style: TextStyle(fontSize: 3.sp(context)),
                controller: searchController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.5.w(context)),
                      borderSide: BorderSide(color: deckBorderColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.w(context)),
                      borderSide: const BorderSide(color: white, width: 1),
                    ),
                    labelText: "Search Connections...",
                    labelStyle: TextStyle(color: grey)),
              ),
            ),

            // Connection Tabs
            Padding(
              padding: EdgeInsets.only(
                bottom: max(10, 1.w(context)),
              ),
              child: Container(
                height: 6.h(context),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    70,
                    32,
                    32,
                    40,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.w(context)),
                  ),
                  border: Border.all(
                    color: deckBorderColor,
                  ),
                ),
                child: ConnectionTactile(
                  onButtonTap: handleButtonTap,
                ),
              ),
            ),

            // Connections / Requests Pages
            Expanded(
              child: PageView(
                controller: pageController,

                // Allows user to manually swipe
                // between All and Requests
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },

                children: connectionPages,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Prevent memory leaks
    searchController.dispose();
    pageController.dispose();

    super.dispose();
  }
}
