import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../main.dart';
import '../../../../../util/GlobalProvider.dart';
import '../../../../../util/tactile_button.dart';

class DeskFriendsButtonHover extends StatefulWidget {
  const DeskFriendsButtonHover({super.key});

  @override
  State<DeskFriendsButtonHover> createState() => _DeskFriendsButtonHoverState();
}

class _DeskFriendsButtonHoverState extends State<DeskFriendsButtonHover> {
//
// start hover is false
  bool isHover = false;
  bool isHover2 = false;

//start active is false
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
      child: GestureDetector(
        onTap: () {
          setState(() {
            //
            //activates the settings popup
            if (!isActive) {
              final startSlide = context.read<GlobalProvider>();
              startSlide.friendActivateSlide();
              //
              //gives the active color to be true
              isActive = true;
            }
          });
        },
        child: TactileButton(
          child: AnimatedContainer(
            padding: isActive
                ? const EdgeInsets.only(left: 10)
                : isHover
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: isActive
                      ? Colors.black87
                      : isHover
                          ? Colors.black87
                          : tran),
              boxShadow: [
                BoxShadow(
                  color: isActive
                      ? Colors.white
                      : (isHover ? Colors.grey.shade700 : tran),
                ),
              ],
              color: tran,
              borderRadius: const BorderRadius.all(Radius.circular(60)),
            ),
            duration: const Duration(milliseconds: 200),
            width: 13.w,
            height: 5.h,
            alignment: Alignment.centerLeft,
            child: addElement(),
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
            Icons.people_outlined,
            color: isActive
                ? Colors.black87
                : (isHover
                    ? const Color.fromARGB(241, 255, 255, 255)
                    : Colors.white70),
            size: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: .5.w),
            child: Text(
              'Connections',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 2.sp),
                fontWeight: FontWeight.w400,
                color: isActive
                    ? const Color.fromARGB(221, 28, 24, 24)
                    : (isHover ? Colors.white : Colors.white54),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.5.w),
            child: Stack(
              children: [
                Icon(
                  Icons.arrow_right_sharp,
                  color: isActive
                      ? Colors.white70
                      : isHover
                          ? const Color.fromARGB(241, 255, 255, 255)
                          : tran,
                  size: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      //
                      //Reverses the popup card
                      final startSlide = context.read<GlobalProvider>();
                      startSlide.friendReverseSlide();
                      //
                      //gives the active color to be flase
                      isActive = false;
                    });
                  },
                  child: MouseRegion(
                    onEnter: (e) {
                      setState(() {
                        isHover2 = true;
                      });
                    },
                    onExit: (e) {
                      setState(() {
                        isHover2 = false;
                      });
                    },
                    child: Icon(
                      Icons.cancel_rounded,
                      color: (isActive && isHover2)
                          ? red
                          : (!isHover2 && isActive)
                              ? Colors.black87
                              : tran,
                      size: 30.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
