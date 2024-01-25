import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/auth/auth_check.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';

import '../../../util/tactile_button.dart';

class DeskHomeWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  DeskHomeWindowButton({super.key, required, required this.dockIcon});
  Widget dockIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Material(
        color: tran,
        child: dockIcon,
      ),
    );
  }
}

class DeskHomeDockButton extends StatefulWidget {
  const DeskHomeDockButton({super.key});

  @override
  State<DeskHomeDockButton> createState() => _DeskHomeDockButtonState();
}

class _DeskHomeDockButtonState extends State<DeskHomeDockButton> {
  bool isHover = false;
  bool isHover2 = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5.h, 0, 1.5.h),
      child: DeskHomeWindowButton(
        dockIcon: Material(
          color: tran,
          child: MouseRegion(
            onEnter: (event) {
              setState(() {
                isHover = true;
              });
            },
            onExit: (event) {
              setState(() {
                isHover = false;
              });
            },
            child: TactileButton(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (buildContext) {
                  return AuthCheck();
                }));
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: isHover
                    ? EdgeInsets.only(left: 10)
                    : EdgeInsets.only(left: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: isHover ? Colors.black87 : tran),
                  boxShadow: [
                    BoxShadow(
                      color: (isHover ? Colors.grey.shade700 : tran),
                    ),
                  ],
                  color: tran,
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                ),
                width: 13.w,
                height: 5.h,
                alignment: Alignment.centerLeft,
                child: addElement(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  addElement() {
    return Padding(
      padding: EdgeInsets.only(left: 0.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.dashboard_rounded,
            color:
                (isHover ? Color.fromARGB(241, 255, 255, 255) : Colors.white70),
            size: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: .5.w),
            child: Text(
              'Home',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 2.sp),
                fontWeight: FontWeight.w400,
                color: (isHover ? Colors.white : Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
