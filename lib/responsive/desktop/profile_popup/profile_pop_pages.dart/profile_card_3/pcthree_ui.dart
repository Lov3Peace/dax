import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_3/billing/billing_ui.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_3/general/general.ui.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_3/notifications/notify_ui.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_3/security/security_ui.dart';

import 'package:sizer/sizer.dart';

class PC3 extends StatelessWidget {
  const PC3({super.key});

  BoxDecoration containerDecoration(Color color) {
    return BoxDecoration(
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(30),
    );
  }

  Widget buildFirstContainer() {
    return Container(
      height: 44.h,
      width: 18.w,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 38, 42),
        border: Border.all(color: Colors.white70),
        borderRadius: BorderRadius.circular(30),
      ),
      child: GeneralUi(),
    );
  }

  Widget buildSecondContainer() {
    return Container(
      height: 44.h,
      width: 18.w,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 38, 42),
        border: Border.all(color: Colors.white70),
        borderRadius: BorderRadius.circular(30),
      ),
      child: SecurityUi(),
    );
  }

  Widget buildThirdContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 21.5.h,
          width: 19.w,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 34, 38, 42),
            border: Border.all(color: Colors.white70),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ParentWidget(),
        ),
        Container(
          height: 21.5.h,
          width: 19.w,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 34, 38, 42),
            border: Border.all(color: Colors.white70),
            borderRadius: BorderRadius.circular(30),
          ),
          child: BillingUi(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: containerDecoration(const Color.fromARGB(182, 31, 31, 31)),
      child: Wrap(
        spacing: .5.w,
        children: [
          Container(
            height: 44.h,
            width: 18.w,
            decoration: containerDecoration(const Color.fromARGB(0, 224, 6, 6)),
            child: buildFirstContainer(),
          ),
          Container(
            height: 44.h,
            width: 18.w,
            decoration: containerDecoration(const Color.fromARGB(0, 224, 6, 6)),
            child: buildSecondContainer(),
          ),
          Container(
            height: 44.h,
            width: 18.w,
            decoration: containerDecoration(const Color.fromARGB(0, 224, 6, 6)),
            child: buildThirdContainer(),
          ),
        ],
      ),
    );
  }
}
