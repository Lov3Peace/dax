import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/ButtonState.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DeskButtonSidePanel extends StatelessWidget {
  const DeskButtonSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    //final buttonState = Provider.of<ButtonState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SlideButton(
          deskButtonId: 'wallet',
          icon: Icons.wallet,
          deskButtonText: 'Wallet',
        ),
        SizedBox(height: 2.h), // Adjusted the height to 2.h
        const SlideButton(
          deskButtonId: 'friend',
          icon: Icons.person,
          deskButtonText: 'Friend',
        ),
        SizedBox(height: 2.h), // Adjusted the height to 2.h
        const SlideButton(
          deskButtonId: 'settings',
          icon: Icons.settings,
          deskButtonText: 'Settings',
        ),
        SizedBox(height: 2.h), // Adjusted the height to 2.h
        const SlideButton(
          deskButtonId: 'help',
          icon: Icons.help,
          deskButtonText: 'Help',
        ),
        SizedBox(height: 2.h), // Adjusted the height to 2.h
        const SlideButton(
          deskButtonId: 'info',
          icon: Icons.info,
          deskButtonText: 'Info',
        ),
      ],
    );
  }
}

class SlideButton extends StatelessWidget {
  final String deskButtonId;
  final IconData icon;
  final String deskButtonText;

  const SlideButton({
    required this.deskButtonId,
    required this.icon,
    required this.deskButtonText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var buttonState = Provider.of<ButtonState>(context);
    bool isActive = buttonState.activeDeskButtonId == deskButtonId;
    bool isHover = buttonState.hoverDeskButtonId == deskButtonId;

    return MouseRegion(
      onEnter: (event) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          buttonState.setHoverDeskButton(deskButtonId);
        });
      },
      onExit: (event) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          buttonState.clearHoverDeskButton(deskButtonId);
        });
      },
      child: GestureDetector(
        onTap: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            buttonState.setActiveDeskButton(deskButtonId);
            buttonState.callDeskFunctionForButton(deskButtonId);
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(left: isActive || isHover ? 10 : 0),
          decoration: BoxDecoration(
            border: Border.all(
              color: isActive || isHover ? Colors.black87 : Colors.transparent,
            ),
            boxShadow: isActive
                ? [
                    const BoxShadow(
                      color: Color.fromARGB(125, 155, 39, 176),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ]
                : isHover
                    ? [
                        BoxShadow(
                          color: Colors.grey.shade700,
                          spreadRadius: 1,
                          blurRadius: 0,
                          // changes position of shadow
                        ),
                      ]
                    : [],
            gradient: isActive
                ? const LinearGradient(
                    colors: [red, purp],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isActive ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(60),
          ),
          width: 13.w,
          height: 5.h,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 0.5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: isActive
                      ? Colors.white
                      : isHover
                          ? const Color.fromARGB(241, 255, 255, 255)
                          : Colors.white70,
                  size: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: .5.w),
                  child: Text(
                    deskButtonText,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 2.sp),
                      fontWeight: FontWeight.w400,
                      color: isActive ? Colors.white : Colors.white54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
