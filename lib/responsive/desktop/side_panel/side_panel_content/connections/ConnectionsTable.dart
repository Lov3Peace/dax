import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/connections/actions_buttons.dart';
import 'package:flutter_application_1/responsive/desktop/util/responsive_shorthand.dart';
import 'package:flutter_application_1/util/providers/ConnectionsSocketIoProvider.dart';
import 'package:flutter_application_1/util/providers/userProvider.dart';
import 'package:flutter_application_1/util/ui/CarbonCircleAvatar.dart';
import 'package:provider/provider.dart';

class ConnectionsTable extends StatelessWidget {
  ConnectionsTable({super.key});

  late UserProvider _userProvider;
  late ConnectionsProvider _connectionsProvider;
  Widget heading({child, verticalPadding}) => Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: verticalPadding),
      child: child);
  Widget cell({child, topPadding}) => Padding(
        padding: EdgeInsetsGeometry.only(top: topPadding),
        child: child,
      );
  @override
  Widget build(BuildContext context) {
    // User Provider
    _userProvider = context.watch<UserProvider>();
    // Connection Provider
    _connectionsProvider = context.watch<ConnectionsProvider>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(width: 0.5, color: grey))),
              children: [
                heading(
                  verticalPadding: max(10, 1.w(context)),
                  child: Center(
                    child: Text(
                      "Username",
                      style: TextStyle(
                          fontSize: max(12, 2.5.sp(context)), color: grey),
                    ),
                  ),
                ),
                heading(
                  verticalPadding: max(10, 1.w(context)),
                  child: Center(
                    child: Text(
                      "Status",
                      style: TextStyle(
                          fontSize: max(12, 2.5.sp(context)), color: grey),
                    ),
                  ),
                ),
                heading(
                  verticalPadding: max(10, 1.w(context)),
                  child: Center(
                    child: Text(
                      "Last Seen",
                      style: TextStyle(
                          fontSize: max(12, 2.5.sp(context)), color: grey),
                    ),
                  ),
                ),
                heading(
                  verticalPadding: max(10, 1.w(context)),
                  child: Center(
                    child: Text(
                      "Actions",
                      style: TextStyle(
                          fontSize: max(12, 2.5.sp(context)), color: grey),
                    ),
                  ),
                ),
              ]),
          ..._connectionsProvider.connections.map((connection) {
            //     // Determine the Other User
            final username = connection.senderUsername == _userProvider.username
                ? connection.receiverUsername
                : connection.senderUsername;

            return TableRow(children: [
              cell(
                topPadding: max(10, 1.25.w(context)),
                child: Row(
                  children: [
                    const Spacer(),
                    CarbonCircleAvatar(width: max(40, 4.w(context))),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: max(5, 0.5.w(context))),
                        child: Text(
                          username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 2.75.sp(context),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: max(20, 2.w(context)))
                  ],
                ),
              ),
              cell(
                topPadding: max(10, 1.25.w(context)),
                child: Center(
                  child: Text(
                    'Connected',
                    style: TextStyle(
                      fontSize: 2.75.sp(context),
                    ),
                  ),
                ),
              ),
              cell(
                topPadding: max(10, 1.25.w(context)),
                child: Center(
                  child: Text(
                    connection.timestamp.toString(),
                    style: TextStyle(
                      fontSize: 2.75.sp(context),
                    ),
                  ),
                ),
              ),
              cell(
                  topPadding: max(10, 1.25.w(context)),
                  child: const Center(child: ActionsButtons())),
            ]);
          })
        ],
      ),
    );
  }
}
