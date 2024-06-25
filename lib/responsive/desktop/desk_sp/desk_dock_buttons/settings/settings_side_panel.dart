import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/access_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/billing_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/general_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/privacy_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/profile_settings.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/settings/settings_side_panel_info/security_settings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../util/ButtonState.dart';

class SettingsSidePanelButtons extends StatelessWidget {
  const SettingsSidePanelButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tran,
      width: 13.w,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingsSidePanel(),
        ],
      ),
    );
  }
}

class SettingsSidePanel extends StatelessWidget {
  const SettingsSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildButton(context, 'button1', 'General'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button2', 'Profile'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button3', 'Billing'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button4', 'Accessibility'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button5', 'Security'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button6', 'Privacy'),
      ],
    );
  }

  Widget _buildButton(
      BuildContext context, String setButtonId, String setButtonText) {
    var buttonState = Provider.of<ButtonState>(context);
    bool isActive = buttonState.activeSetButtonId == setButtonId;

    return GestureDetector(
      onTap: () {
        buttonState.setActiveSetButton(
            setButtonId); // Set the pressed button as active
        buttonState.callSetClassForButton(setButtonId);
        // buttonState.deactivateOtherButtons(
        //     buttonId); // Call the specific class for the button
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          border: Border.all(color: isActive ? Colors.black87 : tran),
          boxShadow: [
            BoxShadow(color: isActive ? Colors.white : Colors.grey.shade700),
          ],
          color: tran,
          borderRadius: const BorderRadius.all(Radius.circular(60)),
        ),
        width: isActive ? 11.w : 9.w,
        height: 4.h,
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(left: isActive ? 3.w : 2.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                setButtonText,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(fontSize: 2.sp),
                    fontWeight: FontWeight.w400,
                    color: isActive
                        ? const Color.fromARGB(221, 28, 24, 24)
                        : Colors.white54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
