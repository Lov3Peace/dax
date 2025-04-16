import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/hero_deck_pages/projects/desk_hero_project_page.dart';
import 'package:flutter_application_1/util/button_state.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SpButtonTemplate extends StatefulWidget {
  final IconData icon;
  final String deskButtonText;
  final Widget child;

  const SpButtonTemplate({
    required this.icon,
    required this.deskButtonText,
    required this.child,
    Key? key,
  }) : super(key: key);
  @override
  State<SpButtonTemplate> createState() => _SpButtonTemplateState();
}

class _SpButtonTemplateState extends State<SpButtonTemplate> {
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
          slideIn();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(left: isHover ? 10 : 0),
          decoration: BoxDecoration(
            gradient: isHover
                ? const LinearGradient(
                    colors: [red, pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(60),
          ),
          width: 10.w(context),
          height: 3.w(context),
          child: Padding(
            padding: EdgeInsets.only(left: 1.w(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  widget.icon,
                  color: isHover ? Colors.white : Colors.white54,
                  size: 5.sp(context),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.5.w(context)),
                  child: Text(
                    widget.deskButtonText,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 2.sp(context)),
                      fontWeight: FontWeight.w400,
                      color: isHover ? Colors.white : Colors.white54,
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

  void slideIn() {
    // toggle between control instructions
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        //slide animation
        showGeneralDialog(
          barrierDismissible: true,
          barrierLabel: "PopUp",
          context: context,
          // transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, _, __) => Center(
            child: widget.child.animate().slideX(begin: -1, end: 0, curve: Curves.easeOutBack, duration: const Duration(milliseconds: 500)),
          ),
        );
      },
    );
  }
}
