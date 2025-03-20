import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_2/bio/bio_ui.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_2/goals/goals_ui.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_2/showcase/showcase_ui.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_2/skills/skills_ui.dart';

import '../../../../../main.dart';

class PC2 extends StatelessWidget {
  PC2({super.key});

  BoxDecoration containerDecoration(Color color) {
    return BoxDecoration(
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(30),
    );
  }

  Widget buildFirstContainer(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 21.5.h(context),
          width: 19.w(context),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 34, 38, 42),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white70),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bio",
                  style: TextStyle(color: white, fontSize: 28, fontWeight: FontWeight.bold),
                ),
                BioTextField(),
              ],
            ),
          ),
        ),
        Container(
          height: 21.5.h(context),
          width: 19.w(context),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 34, 38, 42),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white70),
          ),
          child: SkillsUI(),
        ),
      ],
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
      child: Center(
        child: UploadShowcase(),
      ),
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
        ),
        Container(
          height: 21.5.h(context),
          width: 19.w(context),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 34, 38, 42),
            border: Border.all(color: Colors.white70),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Goals",
                  style: TextStyle(color: white, fontSize: 28, fontWeight: FontWeight.bold),
                ),
                GoalsUi(),
              ],
            ),
          ),
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
