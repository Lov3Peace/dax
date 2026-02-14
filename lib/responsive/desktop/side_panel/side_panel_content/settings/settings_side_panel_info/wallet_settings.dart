import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../settings_templates/settings_buttons.dart';
import '../settings_templates/settings_content_info_card.dart';
import '../settings_templates/settings_dropdown.dart';
import '../settings_templates/settings_toggle.dart';

class WalletSettings extends StatefulWidget {
  const WalletSettings({super.key});

  @override
  State<WalletSettings> createState() => WalletSettingsState();
}

class WalletSettingsState extends State<WalletSettings> {
  //Data Privacy
  bool localOnly = true;
  bool cloudSync = false;
  bool hideBalances = false;

  //Display Preferences
  String selectedCurrency = "USD";
  String selectedDisplay = "Compact";
  String selectedDecimals = "2";

  //Security
  bool requireConfirmation = true;
  String autoLock = "1 min";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsCard(
          title: "Data Privacy",
          children: [
            const Text(
              "Control how your wallet data is stored and shared.",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: .5.h(context)),
            Row(
              children: [
                SettingsToggle(
                  label: "Local Only",
                  value: localOnly,
                  onChanged: (v) => setState(() => localOnly = v),
                ),
                SizedBox(width: .5.w(context)),
                SettingsToggle(
                  label: "Cloud Sync",
                  value: cloudSync,
                  onChanged: (v) => setState(() => cloudSync = v),
                ),
                SizedBox(width: .5.w(context)),
                SettingsToggle(
                  label: "Hide Balances",
                  value: hideBalances,
                  onChanged: (v) => setState(() => hideBalances = v),
                ),
                SizedBox(width: .5.w(context)),
                SettingsActionButton(
                  label: "Export Wallet",
                  icon: Icons.share,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
        SettingsCard(
          title: "Display Preferences",
          children: [
            // SizedBox(height: 1.h(context)),
            Row(
              children: [
                Expanded(
                  child: SettingsDropdown(
                    label: "Currency",
                    value: selectedCurrency,
                    items: const ["USD", "EUR", "GBP", "JPY"],
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => selectedCurrency = v);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SettingsDropdown(
                    label: "Display",
                    value: selectedDisplay,
                    items: const ["Compact", "Detailed", "Minimal"],
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => selectedDisplay = v);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SettingsDropdown(
                    label: "Decimals",
                    value: selectedDecimals,
                    items: const ["0", "2", "4", "6", "8"],
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => selectedDecimals = v);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        SettingsCard(
          title: "Security",
          children: [
            // const SizedBox(height: 12),
            Row(
              children: [
                SettingsToggle(
                  label: "Require Confirm",
                  value: requireConfirmation,
                  onChanged: (v) => setState(() => requireConfirmation = v),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SettingsDropdown(
                    label: "Auto-Lock",
                    showLabel: false,
                    value: autoLock,
                    items: const [
                      "30 sec",
                      "1 min",
                      "5 min",
                      "15 min",
                      "1 hour",
                      "Never",
                    ],
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => autoLock = v);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                SettingsActionButton(
                  label: "Disconnect",
                  icon: Icons.link_off_outlined,
                  onTap: () async {
                    final shouldDisconnect = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: const Color(0xFF1E1E1E),
                        title: const Text(
                          "Disconnect wallet?",
                          style: TextStyle(color: Colors.white),
                        ),
                        content: const Text(
                          "This will disconnect connected wallets and end active sessions.",
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

                    // To Do: your disconnect logic here
                  },
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: const SettingsCard(
                title: "Networks",
                children: [
                  Text(
                    "Ethereum, Solana, Bitcoin",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(width: 1.w(context)),
            Expanded(
              child: const SettingsCard(
                title: "Connected Wallets",
                children: [
                  Text(
                    "MetaMask, Coinbase, Uniswap",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
