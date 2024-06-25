import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/ButtonState.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../main.dart';

//
//
//This holds all the side panel buttons within the
class InfoSidePanelButtons extends StatelessWidget {
  const InfoSidePanelButtons({super.key});

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
          Text(
            'Table of Contents :',
            style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
          InfoButtonSidePanel()
        ],
      ),
    );
  }
}

class InfoButtonSidePanel extends StatelessWidget {
  const InfoButtonSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildButton(context, 'button1', 'About Us'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button2', 'Contact Us'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button3', 'Goals'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button4', 'Terms & Conditions'),
      ],
    );
  }

  Widget _buildButton(
      BuildContext context, String infoButtonId, String infoButtonText) {
    var buttonState = Provider.of<ButtonState>(context);
    bool isActive = buttonState.activeInfoButtonId == infoButtonId;

    return GestureDetector(
      onTap: () {
        buttonState.setActiveInfoButton(
            infoButtonId); // Set the pressed button as active
        buttonState.callInfoClassForButton(infoButtonId);
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
                infoButtonText,
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
