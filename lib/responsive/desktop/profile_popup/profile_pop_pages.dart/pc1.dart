import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';

class PC1 extends StatelessWidget {
  PC1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h(context),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(182, 31, 31, 31)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // LEFT COLUMN
            Column(
              mainAxisAlignment: MainAxisAlignment.center, // center vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // center horizontally
              children: [
                Image.asset(
                  "images/creator.png",
                  height: 35.h(context),
                ),
                const SizedBox(height: 8),
                Text(
                  "Creator",
                  style: TextStyle(
                    color: white,
                    fontSize: 5.sp(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // DIVIDER

            VerticalDivider(
              thickness: 0.8,
              color: Colors.white.withOpacity(0.12),
              indent: 12,
              endIndent: 12,
            ),

            // RIGHT COLUMN
            Column(
              mainAxisAlignment: MainAxisAlignment.center, // center vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // center horizontally
              children: [
                Container(
                  width: 24.w(context),
                  height: 36.h(context),
                  color: tran,
                ),
                SizedBox(height: 1.h(context)),
                Text(
                  "Badges",
                  style: TextStyle(
                    color: white,
                    fontSize: 5.sp(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
