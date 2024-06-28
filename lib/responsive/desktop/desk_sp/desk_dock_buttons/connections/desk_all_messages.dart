import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_constants.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/connections/desk_profile_circle.dart';
import 'package:sizer/sizer.dart';

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
      decoration: const BoxDecoration(
        color: Color.fromARGB(235, 32, 32, 40),
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: ListView.separated(
        // shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 12.h),
        physics: const BouncingScrollPhysics(),
        itemCount: allconnections.length,
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.5.w),
            child: Divider(
              color: deckBorderColor,
              thickness: 0.75,
            ),
          );
        },
        itemBuilder: (context, index) {
          return const ProfileCircle();
        },
      ),
    );
  }
}
