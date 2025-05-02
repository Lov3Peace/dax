import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsSidePanel extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const SettingsSidePanel({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tran,
      width: 13.w(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Table of Contents :',
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, fontSize: 4.sp(context)),
            ),
            SizedBox(height: 1.h(context)),
            SettingsSidePanelButtons(
              currentIndex: currentIndex,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsSidePanelButtons extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  SettingsSidePanelButtons({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final List<String> labels = [
    'General',
    'Profile',
    'Billing',
    'Accessibility',
    'Security',
    'Privacy',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(labels.length, (index) {
        final isActive = currentIndex == index;

        return Padding(
          padding: EdgeInsets.only(bottom: 1.h(context)),
          child: GestureDetector(
            onTap: () => onTap(index),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                decoration: BoxDecoration(
                  border: Border.all(color: isActive ? Colors.white70 : tran),
                  boxShadow: [BoxShadow(color: isActive ? Colors.white : Colors.grey.shade700)],
                  color: tran,
                  borderRadius: BorderRadius.circular(60),
                ),
                width: isActive ? 13.w(context) : 9.w(context),
                height: 4.h(context),
                alignment: Alignment.center,
                child: Text(
                  labels[index],
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(fontSize: 2.sp(context)),
                    fontWeight: FontWeight.w400,
                    color: isActive ? const Color.fromARGB(221, 28, 24, 24) : Colors.white54,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
