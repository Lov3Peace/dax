import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_2/bio/bio_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../../main.dart';

class PC2 extends StatelessWidget {
  PC2({super.key});

  BoxDecoration containerDecoration(Color color) {
    return BoxDecoration(
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(30),
    );
  }

  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _isTextFieldActive = ValueNotifier(false);

  Widget buildFirstContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 21.5.h,
          width: 19.w,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 34, 38, 42),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white70),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
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
          height: 21.5.h,
          width: 19.w,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 34, 38, 42),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white70),
          ),
        ),
      ],
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
        ),
        Container(
          height: 21.5.h,
          width: 19.w,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 34, 38, 42),
            border: Border.all(color: Colors.white70),
            borderRadius: BorderRadius.circular(30),
          ),
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
