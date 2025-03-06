import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/communities_deck.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/desk_dashboard.dart';
import 'package:flutter_application_1/responsive/desktop/hero_deck_pages/desk_hero_communities_page.dart';
import 'package:flutter_application_1/util/auth/auth_check.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import '../../../../util/button_state.dart';

class DeskHomeButton extends StatefulWidget {
  const DeskHomeButton({super.key});

  @override
  State<DeskHomeButton> createState() => _DeskHomeButtonState();
}

class _DeskHomeButtonState extends State<DeskHomeButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          isHover = true;
          // print(isHover);
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
          // print(isHover);
        });
      },
      child: GestureDetector(
        onTap: () {
          goHome();
        },
        child: Stack(
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [red, pink]),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  width: isHover ? 10.w : 0.25.w,
                  height: 7.sp,
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    // color: blue,
                    height: 7.sp,
                  ),
                ),
              ],
            ),
            // Since they're not in a row, have to use Positioned. This allows
            // the animated container to pass under the icon
            Positioned(
              top: 1.sp,
              left: 0.5.w,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0.5.w),
                    child: Icon(
                      Icons.dashboard_rounded,
                      size: 5.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.5.w),
                    child: Text(
                      'Home',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(fontSize: 2.sp),
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goHome() {
    Get.to(() => DesktopDashboard(),
        routeName: '/',
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 200),
        fullscreenDialog: true,
        preventDuplicates: false,
        popGesture: true);
  }
}
