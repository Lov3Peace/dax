import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/button_state.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../main.dart';

// This class creates the info side panel and all its contents
class InfoSidePanel extends StatelessWidget {
  const InfoSidePanel({super.key});

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
          const Text(
            'Table of Contents :',
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
          ),
          SizedBox(height: 1.h),
          const InfoSidePanelButtons()
        ],
      ),
    );
  }
}

// This class houses all side panel buttons in the info popup
class InfoSidePanelButtons extends StatelessWidget {
  const InfoSidePanelButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildButton(context, 'button1', 'About Us'),
        SizedBox(
          height: 1.5.h,
        ),
        _buildButton(context, 'button2', 'Contact Us'),
        SizedBox(
          height: 1.5.h,
        ),
        _buildButton(context, 'button3', 'Goals'),
        SizedBox(
          height: 1.5.h,
        ),
        _buildButton(context, 'button4', 'Terms & Conditions'),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String infoButtonId, String infoButtonText) {
    var buttonState = Provider.of<ButtonState>(context);
    bool isActive = buttonState.activeInfoButtonId == infoButtonId;

    return GestureDetector(
      onTap: () {
        buttonState.setActiveInfoButton(infoButtonId);
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            border: Border.all(color: isActive ? Colors.black87 : Colors.transparent),
            boxShadow: [
              BoxShadow(color: isActive ? Colors.white : Colors.grey.shade700),
            ],
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(60)),
          ),
          width: isActive ? 13.w : 9.w,
          height: 4.h,
          alignment: Alignment.center,
          child: Text(
            infoButtonText,
            style: TextStyle(
              fontSize: 2.sp,
              fontWeight: FontWeight.w400,
              color: isActive ? const Color.fromARGB(221, 28, 24, 24) : Colors.white54,
            ),
          ),
        ),
      ),
    );
  }
}
