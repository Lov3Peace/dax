import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/connections/AddConnectionButton.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/connections/ConnectionRequestsTable.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/connections/ConnectionsTable.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/desk_dock_button_templates/sp_card_template.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/providers/ConnectionsSocketIoProvider.dart';
import 'package:flutter_application_1/util/ui/CarbonCircleAvatar.dart';
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

    Widget heading(Widget child) => Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: max(10, 1.w(context))),
        child: child);
    Widget cell(Widget child) => Padding(
          padding: EdgeInsetsGeometry.only(top: max(10, 1.5.w(context))),
          child: child,
        );

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
                      fontSize: 7.75.sp(context),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Expanded(child: AddConnectionButton()),
              ],
            ),

            SizedBox(height: max(10, 1.w(context))),
            // Search Field
            TextField(
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

            SizedBox(height: max(10, 1.w(context))),
            // Connection Tabs
            Container(
              height: 6.h(context),
              width: double.infinity,
              decoration: BoxDecoration(
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

            SizedBox(height: max(10, 1.w(context))),
            // Connections / Requests Pages
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w(context)),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: deckBorderColor,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(1.5.w(context)),
                  ),
                ),
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),

                  // Allows user to manually swipe
                  // between All and Requests
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },

                  // Each page represents a connection view
                  // such as All Connections or Requests
                  children: [ConnectionsTable(), ConnectionRequestsTable()],
                ),
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
