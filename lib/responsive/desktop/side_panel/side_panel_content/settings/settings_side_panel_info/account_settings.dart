import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

import '../settings_templates/account_link.dart';
import '../settings_templates/device_trust.dart';
import '../settings_templates/frost_text.dart';
import '../settings_templates/settings_content_info_card.dart';
import '../settings_templates/settings_dropdown.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  String selectedLanguage = "English";
  String selectedTheme = "System";
  String selectedTimezone = "EST";

  final Map<String, bool> connectedAccounts = {
    "LinkedIn": true,
    "Pinterest": false,
    "Instagram": false,
    "Snapchat": false,
  };

  Future<void> toggleAccount(String platform) async {
    final isConnected = connectedAccounts[platform] ?? false;

    // Optional: confirm before disconnect
    if (isConnected) {
      final shouldDisconnect = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: Text("Disconnect $platform?",
              style: const TextStyle(color: Colors.white)),
          content: const Text(
            "You can reconnect anytime.",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Disconnect"),
            ),
          ],
        ),
      );

      if (shouldDisconnect != true) return;
    }

    setState(() {
      connectedAccounts[platform] = !isConnected;
    });
  }

  final Map<String, bool> connectedDevices = {
    "iPhone": true,
    "iPad": false,
    "Tablet": true,
    "Android": false,
  };

  Future<void> toggleDevice(String device) async {
    final isTrusted = connectedDevices[device] ?? false;

    setState(() {
      connectedDevices[device] = !isTrusted;
    });
  }

  Future<void> removeDevice(String device) async {
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Text("Remove $device?",
            style: const TextStyle(color: Colors.white)),
        content: const Text(
          "This device will be signed out and removed from your account.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Remove"),
          ),
        ],
      ),
    );

    if (shouldRemove != true) return;

    setState(() {
      connectedDevices.remove(device);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsCard(
          title: "Profile",
          children: [
            Text(
              "Basic account information",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            FrostedTextF(label: "Full Name", hint: "@John Doe"),
            const SizedBox(height: 12),
            FrostedTextF(label: "Username", hint: "@username"),
            const SizedBox(height: 12),
            FrostedTextF(label: 'Email', hint: "email@example.com"),
          ],
        ),
        SettingsCard(
          title: "Change Password",
          children: [
            SizedBox(height: 1.h(context)),
            Row(
              children: [
                SizedBox(
                  width: 23.w(context),
                  child: FrostedTextF(label: "Old", hint: "Old password"),
                ),
                SizedBox(width: 2.5.w(context)),
                SizedBox(
                  width: 23.w(context),
                  child: FrostedTextF(label: "New", hint: "New password"),
                ),
              ],
            ),
          ],
        ),
        SettingsCard(
          title: "Preferences",
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SettingsDropdown(
                    label: "Language",
                    value: selectedLanguage,
                    items: const ["English", "Spanish", "French"],
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => selectedLanguage = v);
                    },
                  ),
                ),
                SizedBox(width: 2.w(context)),
                Expanded(
                  child: SettingsDropdown(
                    label: "Theme",
                    value: selectedTheme,
                    items: const ["System", "Light", "Dark"],
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => selectedTheme = v);
                    },
                  ),
                ),
                SizedBox(width: 2.w(context)),
                Expanded(
                  child: SettingsDropdown(
                    label: "Time Zone",
                    value: selectedTimezone,
                    items: const ["EST", "CST", "MST", "PST"],
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => selectedTimezone = v);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SettingsCard(
                title: "Connected Accounts",
                children: [
                  ConnectedAccountTile(
                    platform: "LinkedIn",
                    icon: Icons.work_outline,
                    connected: connectedAccounts["LinkedIn"] ?? false,
                    onTap: () => toggleAccount("LinkedIn"),
                  ),
                  SizedBox(width: 2.h(context)),
                  ConnectedAccountTile(
                    platform: "Pinterest",
                    icon: Icons.push_pin_outlined,
                    connected: connectedAccounts["Pinterest"] ?? false,
                    onTap: () => toggleAccount("Pinterest"),
                  ),
                  SizedBox(width: 2.h(context)),
                  ConnectedAccountTile(
                    platform: "Instagram",
                    icon: Icons.camera_alt_outlined,
                    connected: connectedAccounts["Instagram"] ?? false,
                    onTap: () => toggleAccount("Instagram"),
                  ),
                  SizedBox(width: 2.h(context)),
                  ConnectedAccountTile(
                    platform: "Snapchat",
                    icon: Icons.chat_bubble_outline,
                    connected: connectedAccounts["Snapchat"] ?? false,
                    onTap: () => toggleAccount("Snapchat"),
                  ),
                ],
              ),
            ),
            SizedBox(width: 1.w(context)),
            Expanded(
              child: SettingsCard(
                title: "Devices",
                children: [
                  Column(
                    children: connectedDevices.entries
                        .expand((entry) => [
                              Devices(
                                device: entry.key,
                                icon: deviceIcon(entry.key),
                                trusted: entry.value,
                                onToggleTrusted: () => toggleDevice(entry.key),
                                onRemove: () => removeDevice(entry.key),
                              ),
                              SizedBox(height: 2.h(context)),
                            ])
                        .toList()
                      ..removeLast(), // removes extra space at end
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  IconData deviceIcon(String device) {
    switch (device.toLowerCase()) {
      case "iphone":
        return Icons.phone_iphone;
      case "android":
        return Icons.android;
      case "ipad":
        return Icons.tablet_mac;
      case "tablet":
        return Icons.tablet;
      default:
        return Icons.devices;
    }
  }
}
