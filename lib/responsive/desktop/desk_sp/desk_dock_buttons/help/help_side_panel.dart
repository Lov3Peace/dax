import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../main.dart';
import '../../../../../util/ButtonState.dart';

class FAqsSidePanel extends StatelessWidget {
  const FAqsSidePanel({super.key});

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
          FAQsSidePanelButtons(),
        ],
      ),
    );
  }
}

class FAQsSidePanelButtons extends StatelessWidget {
  const FAQsSidePanelButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildButton(context, 'button1', 'FAQs'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button2', 'Projects'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button3', 'Communities'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button4', 'Socials'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button5', 'News'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button6', 'Wallet'),
        SizedBox(
          height: 1.h,
        ),
        _buildButton(context, 'button7', 'Tips & Tricks'),
      ],
    );
  }

  Widget _buildButton(
      BuildContext context, String faqsButtonId, String faqsButtonText) {
    var buttonState = Provider.of<ButtonState>(context);
    bool isActive = buttonState.activeFAQsButtonId == faqsButtonId;

    return GestureDetector(
      onTap: () {
        buttonState.setActiveFAQsButton(
            faqsButtonId); // Set the pressed button as active
        buttonState.callFAQsClassForButton(faqsButtonId);
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
                faqsButtonText,
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
