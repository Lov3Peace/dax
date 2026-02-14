import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

class SettingsHeader extends StatelessWidget {
  final String tab;
  final String? subSection;

  const SettingsHeader({
    super.key,
    required this.tab,
    this.subSection,
  });

  @override
  Widget build(BuildContext context) {
    final HeaderConfig config = headerConfig[tab] ?? headerConfig["account"]!;

    // Build breadcrumb text
    final String breadcrumb = subSection == null
        ? "Settings → ${config.title}"
        : "Settings → ${config.title} → $subSection";

    return Row(
      spacing: 1.5.w(context),
      children: [
        Icon(
          config.icon,
          size: 3.h(context),
          color: Colors.white,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumb line: Settings -> Account -> ...
            Text(
              breadcrumb,
              style: TextStyle(
                fontSize: 5.sp(context),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            // Subtitle from config
            Text(
              config.subtitle,
              style: TextStyle(
                fontSize: 2.8.sp(context),
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HeaderConfig {
  final IconData icon;
  final String title;
  final String subtitle;

  const HeaderConfig(this.icon, this.title, this.subtitle);
}

const Map<String, HeaderConfig> headerConfig = {
  "account": HeaderConfig(
    Icons.person_outline,
    "Account",
    "Personal information & identity",
  ),
  "wallet": HeaderConfig(
    Icons.account_balance_wallet_outlined,
    "Wallet",
    "Cash and crypto preferences",
  ),
  "security": HeaderConfig(
    Icons.lock_outline,
    "Security",
    "Authentication & protection",
  ),
  "appearance": HeaderConfig(
    Icons.palette_outlined,
    "Appearance",
    "Theme and interface options",
  ),
  "notifications": HeaderConfig(
    Icons.notifications_none,
    "Notifications",
    "Alerts and activity updates",
  ),
  "advanced": HeaderConfig(
    Icons.settings_outlined,
    "Advanced",
    "System and developer settings",
  ),
};
