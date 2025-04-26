import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../../desk_decks.dart';
import 'actions_buttons.dart';

class PartnerMessages extends StatelessWidget {
  PartnerMessages({
    super.key,
  });

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h(context)),
            child: DataTable(
              dividerThickness: 0.25,
              columnSpacing: 7.w(context),
              horizontalMargin: 7.w(context),
              columns: [
                DataColumn(
                    label: Text('Username',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 2.5.sp(context),
                        ))),
                DataColumn(
                    label: Text('Status',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 2.5.sp(context),
                        ))),
                DataColumn(
                    label: Text('Last Seen',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 2.5.sp(context),
                        ))),
                DataColumn(
                    label: Text('Actions',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 2.5.sp(context),
                        ))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(
                    Padding(
                      padding: EdgeInsets.only(top: 1.h(context)),
                      child: Text(
                        '[Username]',
                        style: TextStyle(
                          fontSize: 2.5.sp(context),
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Padding(
                      padding: EdgeInsets.only(top: 1.h(context)),
                      child: Text(
                        '[Online/Offline]',
                        style: TextStyle(
                          fontSize: 2.5.sp(context),
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Padding(
                      padding: EdgeInsets.only(top: 1.h(context)),
                      child: Text(
                        '[Time]',
                        style: TextStyle(
                          fontSize: 2.5.sp(context),
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Padding(
                      padding: EdgeInsets.only(top: 1.h(context)),
                      child: const ActionsButtons(),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
