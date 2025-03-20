import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_3/billing/billing_ui.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_3/general/general.ui.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_3/notifications/notify_ui.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_3/security/security_ui.dart';

class PC3 extends StatelessWidget {
  PC3({super.key});

  BoxDecoration containerDecoration(Color color) {
    return BoxDecoration(
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(30),
    );
  }

  Widget buildFirstContainer(context) {
    return Container(
      height: 44.h(context),
      width: 18.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 38, 42),
        border: Border.all(color: Colors.white70),
        borderRadius: BorderRadius.circular(30),
      ),
      child: GeneralUi(),
    );
  }

  Widget buildSecondContainer(context) {
    return Container(
      height: 44.h(context),
      width: 18.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 38, 42),
        border: Border.all(color: Colors.white70),
        borderRadius: BorderRadius.circular(30),
      ),
      child: SecurityUi(),
    );
  }

  Widget buildThirdContainer(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 21.5.h(context),
          width: 19.w(context),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 34, 38, 42),
            border: Border.all(color: Colors.white70),
            borderRadius: BorderRadius.circular(30),
          ),
          child: NotificationsUi(),
        ),
        Container(
          height: 21.5.h(context),
          width: 19.w(context),
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
      height: 45.h(context),
      decoration: containerDecoration(const Color.fromARGB(182, 31, 31, 31)),
      child: Wrap(
        spacing: .5.w(context),
        children: [
          Container(
            height: 44.h(context),
            width: 18.w(context),
            decoration: containerDecoration(const Color.fromARGB(0, 224, 6, 6)),
            child: buildFirstContainer(context),
          ),
          Container(
            height: 44.h(context),
            width: 18.w(context),
            decoration: containerDecoration(const Color.fromARGB(0, 224, 6, 6)),
            child: buildSecondContainer(context),
          ),
          Container(
            height: 44.h(context),
            width: 18.w(context),
            decoration: containerDecoration(const Color.fromARGB(0, 224, 6, 6)),
            child: buildThirdContainer(context),
          ),
        ],
      ),
    );
  }
}
