import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

class SettingsToggle extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsToggle({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 3.sp(context),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 10),
            Transform.scale(
              scale: 0.85, // try 0.75 – 0.9 depending on taste
              child: Switch(
                value: value,
                onChanged: onChanged,
                // activeThumbColor: Colors.white,
                activeTrackColor: Colors.white24,
                inactiveThumbColor: Colors.white70,
                inactiveTrackColor: Colors.white24,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
