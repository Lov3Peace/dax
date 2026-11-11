import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/util/providers/profileSocketIoProvider.dart';

/// PC1 - Emblem and badge display card
///
/// Displays a two-column card with creator info on the left
/// and a badge section on the right. Built responsively using
/// custom sizing extensions and structured for future dynamic data.

class PC1 extends StatelessWidget {
  final String username;

  const PC1({
    super.key,
    required this.username,
  });
  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final profile = profileProvider.profile?['profile'] ?? {};

    final emblem = profile['emblem'] ?? 'starter';
    final title = profile['title'] ?? '';

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
                  'images/${emblem == "starter" ? "creator" : emblem}.png',
                  height: 35.h(context),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
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
