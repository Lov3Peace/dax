import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

// ProfileNotifier class for state management
class ProfileNotifier extends ChangeNotifier {
  int _currentIndex = 0;
}

// ProfilePopup UI
class ProfilePopup extends StatefulWidget {
  ProfilePopup({super.key});

  @override
  State<ProfilePopup> createState() => _ProfilePopupState();
}

class _ProfilePopupState extends State<ProfilePopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.h, top: 3.h),
        child: Container(
          height: 80.h,
          width: 60.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Material(
            shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
            color: const Color.fromARGB(42, 55, 52, 52),
            elevation: 2,
            borderRadius: BorderRadius.circular(32),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      height: 85.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromARGB(182, 31, 31, 31)),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
