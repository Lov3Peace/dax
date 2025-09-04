import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../desk_dock_button_templates/toc_template.dart';

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
            TableofContentsTemplate(
              currentIndex: currentIndex,
              onTap: onTap,
              labels: const [
                'General',
                'Profile',
                'Billing',
                'Accessibility',
                'Security',
                'Privacy',
              ],
              spacing: 1.h(context),
              activeWidth: 13.w(context),
              inactiveWidth: 9.w(context),
              height: 4.h(context),
              fontSize: 2.sp(context),
            )
          ],
        ),
      ),
    );
  }
}
