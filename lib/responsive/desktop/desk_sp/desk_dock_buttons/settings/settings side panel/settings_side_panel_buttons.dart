import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings%20side%20panel/access_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings%20side%20panel/billing_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings%20side%20panel/general_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings%20side%20panel/privacy_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings%20side%20panel/profile_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings%20side%20panel/security_settings.dart';
import 'package:sizer/sizer.dart';

class SettingsSidePanelButtons extends StatefulWidget {
  const SettingsSidePanelButtons({super.key});

  @override
  State<SettingsSidePanelButtons> createState() =>
      _SettingsSidePanelButtonsState();
}

class _SettingsSidePanelButtonsState extends State<SettingsSidePanelButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: tran,
      width: 13.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          //General
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const GeneralSettings(),
          ),

          //
          //Profile
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const ProfileSettings(),
          ),
          //
          //Billing
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const BillingSettings(),
          ),
          //
          //Accessibility
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const AccessSettings(),
          ),
          //
          //Security Button
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const SecuritySettings(),
          ),
          //
          //Privacy Button
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const PrivacySettings(),
          ),
        ],
      ),
    );
  }
}
