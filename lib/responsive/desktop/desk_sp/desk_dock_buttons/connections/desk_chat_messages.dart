import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/connections/desk_connections_popup.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/connections/desk_profile_circle.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({
    super.key,
  });
  final List partners = [
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
      height: 53.h(context),
      width: 100.w(context),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(42, 41, 41, 0.631).withOpacity(0.98),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: partners.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
            thickness: 2,
          );
        },
        itemBuilder: (context, index) {
          return const Row(
            children: [
              ProfileCircle(),
              Indicators(),
            ],
          );
        },
      ),
    );
  }
}
