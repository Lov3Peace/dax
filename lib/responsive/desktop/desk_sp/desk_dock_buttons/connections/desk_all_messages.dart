import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_constants.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/connections/desk_profile_circle.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:ionicons/ionicons.dart';
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
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: const Color.fromARGB(140, 32, 32, 40),
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
          border: Border.all(color: deckBorderColor)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.5.w),
                    child: Text('Name', style: TextStyle(color: Colors.grey)),
                  ),
                  Text('Status', style: TextStyle(color: Colors.grey)),
                  Text('Last Seen', style: TextStyle(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.only(right: 7.w),
                    child: Text('Actions', style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
            ListView.separated(
              clipBehavior: Clip.hardEdge,
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 3.h, top: 3.h),
              physics: const BouncingScrollPhysics(),
              itemCount: allconnections.length,
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Divider(
                    color: deckBorderColor,
                    thickness: 0.75,
                  ),
                );
              },
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileCircle(),
                        Text('[Username]', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const Text('[Status]', style: TextStyle(color: Colors.grey)),
                    const Text('[Time]', style: TextStyle(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: Row(
                        children: [
                          TactileButton(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(1.w, 0.5.w, 1.w, 0.5.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(1.5.w)),
                                  gradient: LinearGradient(colors: [purp, Colors.purple.shade300])),
                              child: const Icon(
                                Ionicons.chatbubble_sharp,
                                size: 20,
                              ),
                            ),
                          ),
                          TactileButton(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(1.w, 0.5.w, 1.w, 0.5.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(1.5.w)),
                                  gradient: LinearGradient(colors: [Colors.grey.shade800, Colors.grey.shade700])),
                              child: const Icon(
                                Ionicons.ellipsis_horizontal,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
