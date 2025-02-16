import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_constants.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/connections/actions_buttons.dart';
import 'package:sizer/sizer.dart';

import '../../../desk_decks.dart';

class AllMessages extends StatelessWidget {
  AllMessages({
    super.key,
  });
  final List allconnections = [
    "Tiffany",
    "Mitch",
    "Cassandra",
    "Bluecheese",
    "Johnny",
    "susy",
    "himothy",
    "mario",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: const Color.fromARGB(70, 32, 32, 40),
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
          border: Border.all(color: deckBorderColor)),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            dividerThickness: 0.25,
            columnSpacing: 10.w,
            horizontalMargin: 7.w,
            columns: const [
              DataColumn(label: Text('Username', style: TextStyle(color: Colors.grey))),
              DataColumn(label: Text('Status', style: TextStyle(color: Colors.grey))),
              DataColumn(label: Text('Last Seen', style: TextStyle(color: Colors.grey))),
              DataColumn(label: Text('Actions', style: TextStyle(color: Colors.grey))),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text('[Username]')),
                DataCell(Text('[Online/Offline]')),
                DataCell(Text('[Time]')),
                DataCell(
                  ActionsButtons(),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
